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

- (void)loadAllRouterHandle {
    NSString *plistFilePath = [[NSBundle mainBundle] pathForResource:@"routerConfig" ofType:@"plist"];
    NSMutableArray *routerArr = [[NSMutableArray alloc] initWithContentsOfFile:plistFilePath];
    for (int i = 0; i < [routerArr count]; i++) {
        NSString *routerPath = [routerArr objectAtIndex:i];
        NSString *routerFileHandle = [[NSBundle mainBundle] pathForResource:routerPath ofType:@"plist"];
        NSMutableArray *routerhandleArr = [[NSMutableArray alloc] initWithContentsOfFile:routerFileHandle];
        [self registerPathWithRouterHandleArr:routerhandleArr];
    }
    
}

/**
 * register router by handlePlist
 */
- (void)registerPathWithRouterHandleArr:(NSArray *)routerhandleArr {
    if ([routerhandleArr count] > 0) {
        for (int i = 0; i < [routerhandleArr count]; i++) {
            NSDictionary *dic = [routerhandleArr objectAtIndex:i];
            DHRouterModel *model = [[DHRouterModel alloc] init];
            model.routerType = [[dic objectForKey:@"type"] integerValue];
            model.routerClassName = [dic objectForKey:@"class"];
            model.routerPath = [dic objectForKey:@"path"];
            [_routerMap setObject:model forKey:[dic objectForKey:@"path"]];
        }
    }
}

/**
 * parse router to protocol
 */
- (void)parseRouterWithSchemeUrl:(NSURL *)url {
    
}

@end
