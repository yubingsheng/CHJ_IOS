//
//  AppDelegate.h
//  chjapp
//
//  Created by 启年信息 on 14-11-9.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMeunView.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LeftMeunView *LeftView;
-(void)showLeftMenu;
-(void)hidedLeftView;
@end
