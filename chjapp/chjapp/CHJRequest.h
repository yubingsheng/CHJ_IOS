//
//  CHJRequest.h
//  chjapp
//
//  Created by 小郁 on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHJRequestUrl.h"
#define BASE_URL    @"http://www.woowei.cn/"

@interface CHJRequest : NSObject
//登录
+ (CHJRequestUrl *)loginRequestWithSoapBody:(NSString*)soapBody soapUrl:(NSString*)soapUrl;
@end
