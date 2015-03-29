//
//  LCLearningViewController.m
//  LingvoCards
//
//  Created by jessie on 29.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import "LCLearningViewController.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LCLearningViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@end

@implementation LCLearningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
//    CGRect imageFrame = [[UIScreen mainScreen] bounds];
//    self.bgImage.frame = imageFrame;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
