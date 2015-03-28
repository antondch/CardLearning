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
-(void)addNewItemWithEn:(NSString*) en transcription:(NSString*)transcription ru:(NSString*)ru;
@property(nonatomic,readonly) NSArray *allItems;
@end
