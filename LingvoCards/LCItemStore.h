//
//  LCItemStore.h
//  LingvoCards
//
//  Created by jessie on 28.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCItemStore : NSObject
+(id)sharedStore;
@property(nonatomic,readonly) NSArray *allItems;
@end
