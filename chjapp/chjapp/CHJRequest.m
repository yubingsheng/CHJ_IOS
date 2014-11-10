//
//  CHJRequest.m
//  chjapp
//
//  Created by 小郁 on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "CHJRequest.h"

@implementation CHJRequest
//登录
+ (CHJRequestUrl *)loginRequestWithSoapBody:(NSString*)soapBody
{
    CHJRequestUrl *request = [[CHJRequestUrl alloc]initWithBaseURL:BASE_URL
                                                         service:@"WebService"
                                                          method:@"Employees.asmx"
                                                      httpMethod:@"POST"
                                                      parameters:nil
                                                      soapBody:soapBody];
    return request;
}


@end
