//
//  LCDictionaryStore.m
//  LingvoCards
//
//  Created by jessie on 28.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import "LCDictionaryStore.h"

@implementation LCDictionaryStore
#pragma mark - init

+(id)sharedStore{
    static LCDictionaryStore *sharedStore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedStore = [[self alloc]initPrivate];
    });
    return sharedStore;
}

-(id)init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"use +[LCItemStore sharedStore]" userInfo:nil];
    return nil;
}

-(id)initPrivate{
    self = [super init];
    return self;
}

@end
