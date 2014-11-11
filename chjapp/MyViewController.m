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

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>

{
   UITableView *myTableView;
    BOOL   isShowed;
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
//        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        
//        CustomTabbarController *vc=[sb instantiateViewControllerWithIdentifier:@"tabbar"];
//        [self presentViewController:vc animated:YES completion:nil];
        NSLog(@"成功");
        
        NSString* request = (NSString*)result;
        NSLog(@" == %@",request);
        
    } failure:^(NSError *error){
         NSLog(@"失败");
    }];
    [operation startWithHUD:@"正在加载" inView:self.view];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self addTableView];
    [self initNavigationBar];
    
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
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 24;
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
