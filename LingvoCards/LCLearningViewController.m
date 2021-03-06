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
    NSArray *items = [[LCItemStore sharedStore]itemsForLearning];
    int itemsCount = (int)[items count];
    if (cardsCount>itemsCount) {
        cardsCount = itemsCount;
    }
    for(int i =0; i<cardsCount; i++){
        [self addCardWithItem:(LCItem*)items[i]];
    }
    LCCardViewController *cc = [self.cardControllers lastObject];
    self.currentController = cc;
}

- (void)addCardWithItem:(LCItem*)item{
    LCCardViewController *cardController = [[LCCardViewController alloc]init];
    int order = (int)[self.cardControllers count];
    cardController.item = item;
    cardController.isActive = NO;
    [self.cardControllers addObject:cardController];
    [self displayContentCardController:cardController order:order];
}

-(void)removeCard:(LCCardViewController*)cardController{
        [cardController removeFromParentViewController];
        [cardController.view removeFromSuperview];
}

-(void)setCurrentController:(LCCardViewController *)currentController{
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
    CGSize mainSize = [UIScreen mainScreen].bounds.size;
    CGRect frame = CGRectMake(mainSize.width/2-mainSize.width/2*0.75, mainSize.height/2-mainSize.width/2*0.75*1.5-order/2, mainSize.width*0.75, mainSize.width*0.75*1.5);
    return frame;
}

#pragma mark - cards controller delegate

-(void)cardWillRemoved:(LCCardViewController*)cardController{
    [self.cardControllers removeObject:cardController];
    NSArray *items = [[LCItemStore sharedStore] itemsForLearning];
    int itemsCount = (int)[items count];
    int cardsOnTable = (int)[self.cardControllers count];
    if([items count]>cardsOnTable){
        [self addCardWithItem:items[itemsCount-1-cardsOnTable]];
    }
    if([self.cardControllers count]>0){
        self.currentController = [self.cardControllers lastObject];
    }
}

-(void)cardDidRemoved:(LCCardViewController*)cardController{
    [self removeCard:cardController];
}




@end
