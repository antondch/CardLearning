//
//  LCCardViewController.h
//  LingvoCards
//
//  Created by jessie on 29.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCItem.h"
#import "LCCardViewControllerDelegate.h"
@class LCCardViewController;

@protocol LCCardViewControllerDelegate <NSObject>
@optional
-(void)cardWillRemoved:(LCCardViewController*)cardController;
-(void)cardDidRemoved:(LCCardViewController*)cardController;
@end

@interface LCCardViewController : UIViewController
@property (nonatomic, weak) LCItem *item;
@property (nonatomic) BOOL isActive;
@property (nonatomic, weak) id<LCCardViewControllerDelegate> delegate;
@end
