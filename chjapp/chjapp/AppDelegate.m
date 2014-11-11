//
//  AppDelegate.m
//  chjapp
//
//  Created by 启年信息 on 14-11-9.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UINavigationBar appearance]setBackgroundImage:[self navigationBarImageFromColor:S_PINK] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    
    [application setStatusBarHidden:NO];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    _LeftView=[[LeftMeunView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    __block AppDelegate *ad=self;
    _LeftView.cellAction=^(id obj){
        [ad hidedLeftView];
    };
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [_LeftView addGestureRecognizer:swipe];
    [self.window addSubview:_LeftView];
    return YES;
}
- (UIImage *) navigationBarImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.window.width, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(void)showLeftMenu
{
    [UIView animateWithDuration:0.26 animations:^{
        for (UIView *xx in self.window.subviews)
        {
            if (xx!=_LeftView)
            {
                xx.frame=CGRectMake(xx.frame.origin.x+Main_Screen_Width-60, xx.frame.origin.y, xx.frame.size.width, xx.frame.size.height);
            }
        }
    } completion:nil];
    [UIView animateWithDuration:0.14 animations:^{
        _LeftView.tag=1;
    }];
}
-(void)swipe
{
    [self hidedLeftView];
}

-(void)hidedLeftView
{
    [UIView animateWithDuration:0.2 animations:^{
        for (UIView *xx in self.window.subviews)
        {
            if (xx!=_LeftView)
            {
                xx.frame=CGRectMake(xx.frame.origin.x-Main_Screen_Width+60, xx.frame.origin.y, xx.frame.size.width, xx.frame.size.height);
            }
        }
    } completion:^(BOOL bl){
        [UIView animateWithDuration:0.1 animations:^{
            _LeftView.tag=0;
        }];
        
    }];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
