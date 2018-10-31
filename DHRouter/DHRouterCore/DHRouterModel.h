//
//  DHRouterModel.h
//  DHRouter
//
//  Created by wangpengfei on 2018/10/31.
//  Copyright © 2018 pengfei wang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DHRouterModelType){
    DHRouterModelTypePUSH = 0,
    DHRouterModelTypeSelector = 1
};

@interface DHRouterModel : NSObject

@property (nonatomic, assign) DHRouterModelType routerType;

@property (nonatomic, copy) NSString *routerClassName;

@property (nonatomic, copy) NSString *routerPath;

@end
