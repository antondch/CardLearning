//
//  LCItemStore.m
//  LingvoCards
//
//  Created by jessie on 28.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import "LCItemStore.h"
#import "AppDelegate.h"
#import "LCItem.h"

@import CoreData;
@interface LCItemStore()
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSMutableArray *privateLearnedItems;
@property (nonatomic, strong) NSMutableArray *privateItemsForLearning;
@end
@implementation LCItemStore

#pragma mark - init

+(id)sharedStore{
    static LCItemStore *sharedStore;
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.context = appDelegate.managedObjectContext;
    self.model = appDelegate.managedObjectModel;
    self.persistentStoreCoordinator = appDelegate.persistentStoreCoordinator;
    [self loadAllItems];
    return self;
}

#pragma mark - items manipulation

-(void)loadAllItems{
    if(!self.privateItemsForLearning){
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        NSEntityDescription *ed = [NSEntityDescription entityForName:@"LCItem" inManagedObjectContext:self.context];
        request.entity = ed;
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if(!result){
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription] ];
        }
        self.privateItemsForLearning = [[NSMutableArray alloc]initWithArray:result];
    }
}

-(void)addNewItemWithEn:(NSString *)en transcription:(NSString *)transcription ru:(NSString *)ru{
    LCItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"LCItem" inManagedObjectContext:self.context];
    item.ru = ru;
    item.en = en;
    item.transcription = transcription;
    [self.privateItemsForLearning addObject:item];
}

-(NSArray*)privateItemsForLearning{
    return self.privateItemsForLearning;
}

-(NSArray*)learnedItems{
    return self.privateItemsForLearning;
}

@end
