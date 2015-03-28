//
//  XMLItemsParserDelegate.h
//  LingvoCards
//
//  Created by jessie on 28.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLItemsParserDelegate : NSObject<NSXMLParserDelegate>{
    BOOL m_done;
    BOOL m_isItem;
    BOOL m_isItemProp;
    NSMutableString* m_prop;
    NSError* m_error;
    NSMutableArray* m_items;
    NSMutableArray* m_item;
    
}
@property (nonatomic, readonly) BOOL done;
@property (nonatomic, copy) void (^doneParse)(void);
@property (nonatomic, readonly) NSError* error;
@property (nonatomic, readonly) NSArray* items;
@end
