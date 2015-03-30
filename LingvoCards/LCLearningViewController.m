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
@property (nonatomic,strong) NSMutableArray *cardControllers;
@end

@implementation LCLearningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    [self createCards];
}

- (void)createCards{
    self.cardControllers = [[NSMutableArray alloc]init];
    for(id object in [[LCItemStore sharedStore]itemsForLearning]){
        LCCardViewController *cardController = [[LCCardViewController alloc]init];
        LCItem *item = (LCItem*) object;
        cardController.item = item;
        int order = [self.cardControllers count];
        [self displayContentController:cardController order:order];
        [self.cardControllers addObject:cardController];
    }
}

- (void)displayContentController: (UIViewController*) content order:(int) order;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
