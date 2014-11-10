//
//  ViewController.m
//  chjapp
//
//  Created by 启年信息 on 14-11-9.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomTabbarController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)loginBtn:(UIButton *)sender
{
    CHJRequestUrl *request=[CHJRequest loginRequestWithSoapBody:@"<GetModelByENameAndEPassword2 xmlns=\"http://www.woowei.cn/\">\n"
                         "<EName>方银儿</EName>\n"
                         "<EPassword>123456</EPassword>\n"
                         "</GetModelByENameAndEPassword2>\n"];
    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        CustomTabbarController *vc=[sb instantiateViewControllerWithIdentifier:@"tabbar"];
        [self presentViewController:vc animated:YES completion:nil];
        
    } failure:^(NSError *error){
        
    }];
    [operation startWithHUD:@"登录" inView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
