//
//  LCCardViewController.h
//  LingvoCards
//
//  Created by jessie on 29.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCItem.h"

@interface LCCardViewController : UIViewController
@property (nonatomic,weak) LCItem *item;
@property (nonatomic,weak) void (^discardBlock)(void);
@end
