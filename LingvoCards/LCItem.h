//
//  LCItems.h
//  LingvoCards
//
//  Created by jessie on 28.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LCDictionary;

@interface LCItem : NSManagedObject

@property (nonatomic, retain) NSString * ru;
@property (nonatomic, retain) NSString * en;
@property (nonatomic, retain) NSString * transcription;
@property (nonatomic, retain) NSString * ruUser;
@property (nonatomic, retain) NSNumber * isLearned;
@property (nonatomic, retain) LCDictionary *dictionary;

@end
