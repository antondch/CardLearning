//
//  LCAPI.m
//  LingvoCards
//
//  Created by jessie on 28.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import "LCAPI.h"
#import "XMLItemsParserDelegate.h"
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

-(NSArray*)getItemsForDictionary:(NSString *)dictionary{
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
    
    return nil;
}

-(void)doneParse{
    
    NSLog(@"done parse");
}

-(NSString*)xmlPath{
    return [[NSBundle mainBundle] pathForResource:@"defaultItems" ofType:@"xml"];;
}

@end
