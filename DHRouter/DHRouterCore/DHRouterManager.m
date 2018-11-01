//
//  DHRouterManager.m
//  DHRouter
//
//  Created by pengfei wang on 2018/10/29.
//  Copyright © 2018年 pengfei wang. All rights reserved.
//

#import "DHRouterManager.h"
#import "DHRouterHandle.h"
#import "DHRouterModel.h"
#import <objc/runtime.h>

@interface DHRouterManager()

@property (nonatomic, strong) NSMutableDictionary *routerMap;

@property (nonatomic, strong) DHRouterModel *parseModel;

@end

@implementation DHRouterManager

static DHRouterManager *instance;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DHRouterManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _routerMap = [NSMutableDictionary new];
    }
    return self;
}

/*
 * @brief 加载所有路由配置
 *
 **/
- (void)loadAllRouterHandle {
    NSString *plistFilePath = [[NSBundle mainBundle] pathForResource:@"routerConfig" ofType:@"plist"];
    NSMutableArray *routerArr = [[NSMutableArray alloc] initWithContentsOfFile:plistFilePath];
    for (int i = 0; i < [routerArr count]; i++) {
        NSString *routerPath = [routerArr objectAtIndex:i];
        NSString *routerFileHandle = [[NSBundle mainBundle] pathForResource:routerPath ofType:@"plist"];
        NSMutableArray *routerhandleArr = [[NSMutableArray alloc] initWithContentsOfFile:routerFileHandle];
        if (routerhandleArr) {
             [self registerPathWithRouterHandleArr:routerhandleArr];
        }
    }
}

/**
 * @brief 注册句柄路由配置
 */
- (void)registerPathWithRouterHandleArr:(NSArray *)routerhandleArr {
    if ([routerhandleArr count] > 0) {
        for (int i = 0; i < [routerhandleArr count]; i++) {
            if ([[routerhandleArr objectAtIndex:i] isMemberOfClass:[NSDictionary class]]) {
                NSDictionary *dic = [routerhandleArr objectAtIndex:i];
                DHRouterModel *model = [[DHRouterModel alloc] init];
                model.routerType = [[dic objectForKey:@"type"] integerValue];
                model.routerClassName = [dic objectForKey:@"class"];
                model.routerPath = [dic objectForKey:@"path"];
                [_routerMap setObject:model forKey:[dic objectForKey:@"path"]];
            }
        }
    }
}

/**
 * @brief 解析sheme地址，分发协议，没有返回值
 */
- (BOOL)parseRouterWithSchemeUrl:(NSURL *)url {
    _parseModel = nil;
    NSString *urlPath = [url path];
    if (urlPath.length > 0) {
        _parseModel = [_routerMap objectForKey:urlPath];
        if (!_parseModel) {
            NSDictionary *paramsDic = [self parseRouterParamsWithURL:url];
            if (_parseModel.routerType == DHRouterModelTypePUSH) {
                if (_parseModel.routerClassName.length) {
                    Class class = NSClassFromString(_parseModel.routerClassName);
                    DHRouterHandle *handle = nil;
                    if (class && [class respondsToSelector:@selector(initObjectWithURL:withParams:)]) {
                        handle = [class initObjectWithURL:url withParams:paramsDic];
                    }
                }
                return YES;
            } else if (_parseModel.routerType == DHRouterModelTypeSelector) {
                
                return YES;
            }
        }
        return NO;
    }
}

/**
 * @brief 解析sheme地址，分发协议，有返回值
 */
- (BOOL)parseRouterWithSchemeUrl:(NSURL *)url withCallBack:(callBack)callBack{
    _parseModel = nil;
    BOOL success = [self parseRouterWithSchemeUrl:url];
    if (!success && _parseModel) {
        if (_parseModel.routerType == DHRouterModelTypeSelectorCallBack) {
            
        }
    }
}

- (NSDictionary *)parseRouterParamsWithURL:(NSURL *)url {
    NSDictionary *paramsDic = nil;
    NSString *paramsStr = [url query];
    if (paramsStr.length) {
        
    }
    return paramsDic;
}

@end
