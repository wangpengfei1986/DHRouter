//
//  DHRouterManager.h
//  DHRouter
//
//  Created by pengfei wang on 2018/10/29.
//  Copyright © 2018年 pengfei wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHRouterManager : NSObject

+ (instancetype)shareInstance;

/**
 * @brief load All inheritance router.
 */
- (void)loadAllRouterHandle;


/**
 * @brief parse scheme url , deliver url to inheritance router.
 *
 * @param url.
 */
- (void)parseRouterWithSchemeUrl:(NSString *)url;

@end
