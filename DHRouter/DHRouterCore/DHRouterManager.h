//
//  DHRouterManager.h
//  DHRouter
//
//  Created by pengfei wang on 2018/10/29.
//  Copyright © 2018年 pengfei wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHRouterHandle.h"

@interface DHRouterManager : NSObject

+ (instancetype)shareInstance;

/**
 * @brief 读取所有路由注册信息
 */
- (void)loadAllRouterHandle;


/**
 * @brief 解析SchemeUrl，分发到注册句柄协议中
 *
 * @param url
 */
- (BOOL)parseRouterWithSchemeUrl:(NSURL *)url;

/**
* @brief 解析sheme地址，分发协议，有返回值
*/
- (BOOL)parseRouterWithSchemeUrl:(NSURL *)url withCallBack:(callBack)callBack;

@end
