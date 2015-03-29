//
//  LCCardViewController.m
//  LingvoCards
//
//  Created by jessie on 29.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import "LCCardViewController.h"

@interface LCCardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *enLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardBackImage;
@property BOOL isRotated;

@end

@implementation LCCardViewController
- (IBAction)soundButton:(id)sender {
}
- (IBAction)learnButton:(id)sender {

}

#pragma mark - animation

- (void)rotateView{
    int direction = 1;
    if(self.isRotated){
        direction = -1;
    }
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    perspectiveTransform.m34 = 1.0 / -400;
    perspectiveTransform = CATransform3DRotate(perspectiveTransform,  direction*M_PI / 2, 0.0f, 1.0f, 0.0f);
    //     cardController.view.layer.anchorPoint = CGPointMake(0.0, 0.0);
    self.view.layer.zPosition=500;
    self.view.layer.allowsEdgeAntialiasing = YES;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.view.layer.transform = perspectiveTransform;
    } completion:^(BOOL finished) {
        self.cardBackImage.hidden = self.isRotated;
        CATransform3D originalPerspectiveTransform = CATransform3DRotate(perspectiveTransform,  M_PI / 2, 0.0f, 1.0f, 0.0f);
        //CATransform3DIdentity;
        [UIView animateWithDuration:0.5  delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.view.layer.transform = originalPerspectiveTransform;
        }completion:^(BOOL finished) {
            self.view.layer.zPosition=0;
            self.isRotated = !self.isRotated;
        }];
    }];
}


#pragma mark - gesture recognize

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isRotated = NO;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRecognize:)];
    [self.view addGestureRecognizer:tapRecognizer];
    // Do any additional setup after loading the view from its nib.
}

- (void)tapRecognize:(UIGestureRecognizer*)gestureRecognizer{
    [self rotateView];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
