//
//  DHRouterProtocol.h
//  DHRouter
//
//  Created by pengfei wang on 2018/10/29.
//  Copyright © 2018年 pengfei wang. All rights reserved.
//

#ifndef DHRouterProtocol_h
#define DHRouterProtocol_h


#endif /* DHRouterProtocol_h */

typedef void(^callBack)(NSDictionary *callBackDic);

@protocol DHRouterProtocol

+ (instancetype)initObjectWithURL:(NSURL *)URL withParams:(NSDictionary *)nativeParams;

+ (instancetype)initObjectWithURL:(NSURL *)URL withParams:(NSDictionary *)nativeParams withCallBack:(callBack)callBack;

@end
