//
//  LCItemStore.h
//  LingvoCards
//
//  Created by jessie on 28.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCItem.h"

@interface LCItemStore : NSObject
+(id)sharedStore;
-(void)moveItemToLearning:(LCItem*)item;
-(void)moveItemToLeaned:(LCItem*)item;
-(void)skipItem:(LCItem*)card;
-(void)addNewItemWithEn:(NSString*) en transcription:(NSString*)transcription ru:(NSString*)ru;
@property(nonatomic,readonly) NSArray *itemsForLearning;
@property(nonatomic,readonly) NSArray *learnedItems;
@end
