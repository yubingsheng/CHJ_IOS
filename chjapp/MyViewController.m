//
//  MyViewController.m
//  chjapp
//
//  Created by 小郁 on 14-11-9.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "MyViewController.h"
#import "MJRefresh.h"
#import "MyActivityCell.h"
#import "GDataXMLNode.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>

{
   UITableView *myTableView;
    BOOL   isShowed;
    
    NSMutableArray* tableMuArr;
}

@end

@implementation MyViewController


// 我的会议安排
- (void)GetListByPage2:(NSString*)eName StartIndex:(int)startIndex EndIndex:(int)endIndex
{
    NSString* urlString = [NSString stringWithFormat:@"<GetListByPage2 xmlns=\"http://www.woowei.cn/\">\n"
                           "<EName>%@</EName>\n"
                           "<orderby></orderby>\n"
                           "<startIndex>%d</startIndex>\n"
                           "<endIndex>%d</endIndex>\n"
                           "</GetListByPage2>\n",eName,startIndex,endIndex];
    CHJRequestUrl *request=[CHJRequest GetListByPage2:urlString soapUrl:@"GetListByPage2"];
    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
        
        NSLog(@"成功");
        
        NSString* request = (NSString*)result;
        NSLog(@" == %@",request);
        [self xmlString:request];
        
    } failure:^(NSError *error){
         NSLog(@"失败");
    }];
    [operation startWithHUD:@"正在加载" inView:self.view];
}

- (void)xmlString:(NSString*)xmlString
{
    
    
    //初始化xml文档
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithXMLString:xmlString options:0 error:nil];
//    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:self.reciveData options:0 error:nil];
    
    //获取根节点
    GDataXMLElement *rootElement = [document rootElement];
    
    //获取根节点的子节点，通过节点的名称
    
    GDataXMLElement *Body = [rootElement elementsForName:@"soap:Body"].lastObject;
    GDataXMLElement *GetModelByENameAndEPassword2Response = [Body elementsForName:@"GetListByPage2Response"].lastObject;
    GDataXMLElement *GetListByPage2Result = [GetModelByENameAndEPassword2Response elementsForName:@"GetListByPage2Result"].lastObject;
    GDataXMLElement *diffgram = [GetListByPage2Result elementsForName:@"diffgr:diffgram"].lastObject;
    GDataXMLElement *NewDataSet = [diffgram elementsForName:@"NewDataSet"].lastObject;
    NSArray *ds = [NewDataSet elementsForName:@"ds"];
    
    for (GDataXMLElement * note in ds){
        
        
        NSString* MName = [[note elementsForName:@"MName"].lastObject stringValue];
        NSString* MDate = [[note elementsForName:@"MDate"].lastObject stringValue];
        NSString* MSTIme = [[note elementsForName:@"MSTIme"].lastObject stringValue];
        NSString* METime = [[note elementsForName:@"METime"].lastObject stringValue];
        
        NSMutableDictionary* dicItem = [[NSMutableDictionary alloc] init];
        
        [dicItem setValue:MName forKey:@"MName"];
        [dicItem setValue:MDate forKey:@"MDate"];
        [dicItem setValue:MSTIme forKey:@"MSTIme"];
        [dicItem setValue:METime forKey:@"METime"];
        
        [tableMuArr addObject:dicItem];
    }
    
    [myTableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self addTableView];
    [self initNavigationBar];
    tableMuArr = [NSMutableArray array];
    
    [self GetListByPage2:@"方银儿" StartIndex:0 EndIndex:10];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -addViews
-(void)addTableView
{
    myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64-44)];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [myTableView addHeaderWithTarget:self action:@selector(headerRefresh)];
    [myTableView addFooterWithTarget:self action:@selector(footerRefresh)];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:myTableView];
}
-(void)headerRefresh
{
    [myTableView footerEndRefreshing];
}
-(void)footerRefresh
{
    [myTableView headerEndRefreshing];
}
- (void)initNavigationBar
{
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:@"我的日程"withAlignment:NavigationBarTitleViewAlignmentCenter];
    
    self.navigationItem.leftBarButtonItem = [CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(leftMeun) withImage:@"morex" withHighlightImage:@"morex"];
    
    UIBarButtonItem *shareBtn=[CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(addThing) withImage:@"addx" withHighlightImage:@"addx"];
    
    [self.navigationItem setRightBarButtonItem:shareBtn];
}
-(void)leftMeun
{
    AppDelegate *app=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    app.LeftView.cellAction=^(id obj){
        DLog(@"obj==%@",obj);
    };
    if (app.LeftView.tag==0)
    {
        [app showLeftMenu];
    }
    else
    {
        [app hidedLeftView];
    }
}
-(void)addThing
{
    
}


#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cell";
    MyActivityCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[MyActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
//    NSDate *  senddate=[NSDate date];
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"HH:mm"];
//    NSString *  locationString=[dateformatter stringFromDate:senddate];
//    
//    cell.textLabel.text=[NSString stringWithFormat:@"%@",locationString];
    [cell tableViewCellArray:tableMuArr Index:indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableMuArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}
#pragma mark - MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
