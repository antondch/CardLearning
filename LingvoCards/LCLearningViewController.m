//
//  LCLearningViewController.m
//  LingvoCards
//
//  Created by jessie on 29.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import "LCLearningViewController.h"
#import "LCCardViewController.h"
#import "LCItem.h"
#import "LCItemStore.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LCLearningViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (nonatomic, strong) NSMutableArray *cardControllers;
@property (nonatomic, strong) LCCardViewController *currentController;
@end

@implementation LCLearningViewController

#pragma mark - stuff

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    [self createCards];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


#pragma mark - cards manipulation

- (void)createCards{
    self.cardControllers = [[NSMutableArray alloc]init];
    int cardsCount = 6;
    if (cardsCount>(int)[[[LCItemStore sharedStore]itemsForLearning]count]) {
        cardsCount = (int)[[[LCItemStore sharedStore]itemsForLearning]count];
    }
    for(int i =0; i<cardsCount; i++){
        [self addCard];
    }
}

- (void)addCard{
    LCCardViewController *cardController = [[LCCardViewController alloc]init];
    LCItem *item = [[[LCItemStore sharedStore]itemsForLearning] lastObject];
    int order = (int)[self.cardControllers count];
    cardController.item = item;
    [self.cardControllers addObject:cardController];
    [self displayContentCardController:cardController order:order];
    self.currentController = cardController;
}

-(void)removeCard:(LCCardViewController*)cardController{
        [self.cardControllers removeObject:cardController];
        [cardController removeFromParentViewController];
        [cardController.view removeFromSuperview];
}

-(void)setCurrentController:(LCCardViewController *)currentController{
    if(_currentController){
        _currentController.isActive = NO;
    }
    _currentController = currentController;
    currentController.isActive = YES;
    currentController.delegate = self;
}

#pragma mark - add cadr in frame

- (void)displayContentCardController: (UIViewController*) content order:(int) order;
{
    [self addChildViewController:content];
    content.view.frame = [self frameForContentControllerWithOrder:order];
    [self.view addSubview:content.view];
    [content didMoveToParentViewController:self];
}

- (CGRect)frameForContentControllerWithOrder:(int) order{
    
    CGRect frame = CGRectMake(50, 50-order/2, self.view.bounds.size.width-200, (self.view.bounds.size.width-200)*1.5);
    return frame;
}

#pragma mark - cards controller delegate

-(void)cardWillRemoved:(id)cardController{
    if([self.cardControllers count]>0){
        self.currentController = [self.cardControllers lastObject];
    }
}

-(void)cardDidRemoved:(id)cardController{
    [self removeCard:cardController];
}




@end
