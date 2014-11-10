//
//  AllViewController.m
//  chjapp
//
//  Created by 小郁 on 14-11-9.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "AllViewController.h"

@interface AllViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView *tableView;
@end

@implementation AllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self addTableView];
    // Do any additional setup after loading the view.
}
#pragma mark -addViews
-(void)addTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64-44)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView addHeaderWithTarget:self action:@selector(headerRefresh)];
    [_tableView addFooterWithTarget:self action:@selector(footerRefresh)];
    [self.view addSubview:_tableView];
}
-(void)headerRefresh
{
    [_tableView footerEndRefreshing];
}
-(void)footerRefresh
{
    [_tableView headerEndRefreshing];
}
#pragma mark- TableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@",locationString];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 24;
}
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
