//
//  LCAPI.m
//  LingvoCards
//
//  Created by jessie on 28.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import "LCAPI.h"
#import "XMLItemsParserDelegate.h"
#import "LCItemStore.h"

@interface LCAPI()
@property (nonatomic,strong)XMLItemsParserDelegate *parseDelegate;
@end

@implementation LCAPI

#pragma mark - init

+(id)defaultAPI{
    static LCAPI *defaultAPI;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        defaultAPI = [[self alloc]initPrivate];
    });
    return defaultAPI;
}

-(id)init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"use +[LCAPI defaultAPI]" userInfo:nil];
    return nil;
}

-(id)initPrivate{
    self = [super init];
    return self;
}

#pragma mark - get items
-(void)initResources:(NSString *)dictionary{
    LCItemStore *itemStore = [LCItemStore sharedStore];
    if([[itemStore allItems]count]==0){
    _parseDelegate = [[XMLItemsParserDelegate alloc]init];
    NSError *error;
    NSData *data = [NSData dataWithContentsOfFile:[self xmlPath] options:0 error:&error];
    NSXMLParser* parser = [[NSXMLParser alloc]initWithData:data];
    parser.delegate = _parseDelegate;
    __weak LCAPI *weakSelf = self;
    _parseDelegate.doneParse = ^(void){
        LCAPI *strongSelf = weakSelf;
        [strongSelf doneParse];
    };
    [parser parse];
    }
}

-(void)doneParse{
    LCItemStore *itemStore = [LCItemStore sharedStore];
    for(id object in self.parseDelegate.items){
        NSArray *itemArray = (NSArray*)object;
        [itemStore addNewItemWithEn:itemArray[0] transcription:itemArray[1] ru:itemArray[2]];
    }
    NSLog(@"done parse");
}

-(void)sendCompleteInit{
    if(self.initComplete){
        self.initComplete();
    }
}

-(NSString*)xmlPath{
    return [[NSBundle mainBundle] pathForResource:@"defaultItems" ofType:@"xml"];;
}

@end
