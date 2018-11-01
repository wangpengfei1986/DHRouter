//
//  DHRouterHandle.h
//  DHRouter
//
//  Created by pengfei wang on 2018/10/29.
//  Copyright © 2018年 pengfei wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHRouterProtocol.h"

@interface DHRouterHandle : NSObject <DHRouterProtocol>

@property (nonatomic, assign) callBack callback;

@end
