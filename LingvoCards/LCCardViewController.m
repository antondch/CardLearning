//
//  LCCardViewController.m
//  LingvoCards
//
//  Created by jessie on 29.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import "LCCardViewController.h"
#import "LCItemStore.h"

@interface LCCardViewController (){
    BOOL isRotated;
    CGPoint cardOutDistance;
    int order;
}
@property (weak, nonatomic) IBOutlet UILabel *enLabel;

@property (weak, nonatomic) IBOutlet UIImageView *cardBackImage;

//@property BOOL isRotated;

@end

@implementation LCCardViewController
- (IBAction)soundButton:(id)sender {
}
- (IBAction)learnButton:(id)sender {
    [[LCItemStore sharedStore]moveItemToLeaned:self.item];
    [self flyOutView];
}

-(void)setIsActive:(BOOL)isActive{
    self.view.userInteractionEnabled = isActive;
    _isActive = isActive;
    self.enLabel.hidden = !isActive;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.userInteractionEnabled = NO;
    self.enLabel.text = self.item.en;
    NSLog(@"text: %@",self.enLabel.text);
        NSLog(@"en: %@",self.item.en);
    isRotated = NO;
    
    CGSize appSize = [[UIScreen mainScreen] bounds].size;
    CGSize cardSize = self.view.bounds.size;
    cardOutDistance.x = -appSize.width/2-cardSize.height/2;
    cardOutDistance.x = -appSize.width/2-cardSize.height/2;
    cardOutDistance.y = appSize.height/2+cardSize.width/2;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRecognize:)];
    [self.view addGestureRecognizer:tapRecognizer];
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRecognize:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRecognizer];
}


#pragma mark - animation

- (void)rotateView{
    self.item.wasKeeked = YES;
    int direction = 1;
    if(isRotated){
        direction = -1;
    }
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    perspectiveTransform.m34 = 1.0 / -500;
    perspectiveTransform = CATransform3DRotate(perspectiveTransform,  direction*M_PI / 2, 0.0f, 1.0f, 0.0f);
    //     cardController.view.layer.anchorPoint = CGPointMake(0.0, 0.0);
    self.view.layer.zPosition=500;
    self.view.layer.allowsEdgeAntialiasing = YES;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.view.layer.transform = perspectiveTransform;
    } completion:^(BOOL finished) {
        self.cardBackImage.hidden = isRotated;
        CATransform3D originalPerspectiveTransform = CATransform3DRotate(perspectiveTransform,  M_PI / 2, 0.0f, 1.0f, 0.0f);
        //CATransform3DIdentity;
        [UIView animateWithDuration:0.5  delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.view.layer.transform = originalPerspectiveTransform;
        }completion:^(BOOL finished) {
            self.view.layer.zPosition=0;
            isRotated = !isRotated;
        }];
    }];
}

-(void)flyOutView{
    self.view.layer.zPosition=10;
    CATransform3D rotationTransform = CATransform3DMakeTranslation(cardOutDistance.x, cardOutDistance.y,0);
    rotationTransform = CATransform3DRotate(rotationTransform,-M_PI/2, 0.0f, 0.0f, 0.1);
    if ([_delegate respondsToSelector:@selector(cardWillRemoved:)]){
        [_delegate performSelector:@selector(cardWillRemoved:)withObject:self];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.view.layer.transform = rotationTransform;
    } completion:^(BOOL finished) {
        if ([_delegate respondsToSelector:@selector(cardDidRemoved:)]){
            [_delegate performSelector:@selector(cardDidRemoved:)withObject:self];
        }
    }];
}

#pragma mark - gesture recognize

- (void)tapRecognize:(UIGestureRecognizer*)gestureRecognizer{
    [self rotateView];
}

- (void)swipeRecognize:(UIGestureRecognizer*)gestureRecognizer{
    [[LCItemStore sharedStore] skipItem:self.item];
    [self flyOutView];
}

@end
