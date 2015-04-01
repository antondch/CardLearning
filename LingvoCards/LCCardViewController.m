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

    CGPoint cardOutDistance;
    int order;
}
@property (weak, nonatomic) IBOutlet UIButton *soundBtn;
@property (weak, nonatomic) IBOutlet UIButton *learnBtn;
@property (weak, nonatomic) IBOutlet UILabel *enLabel;
@property (weak, nonatomic) IBOutlet UILabel *transcriptionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *cardBackImage;
@property (weak, nonatomic) IBOutlet UITextField *ruText;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeRecognizer;
@property (nonatomic) BOOL isRotated;

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
    self.soundBtn.hidden = !isActive;
    self.learnBtn.hidden = !isActive;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.userInteractionEnabled = NO;
    self.enLabel.text =  self.item.en;
    self.transcriptionLabel.text = self.item.transcription;
    [self.enLabel updateConstraints];
    NSLog(@"text: %@",self.enLabel.text);
        NSLog(@"en: %@",self.item.en);
        NSLog(@"transcription: %@",self.item.transcription);
    self.isRotated = NO;
    
    CGSize appSize = [[UIScreen mainScreen] bounds].size;
    CGSize cardSize = self.view.bounds.size;
    cardOutDistance.x = -appSize.width/2-cardSize.height/2;
    cardOutDistance.x = -appSize.width/2-cardSize.height/2;
    cardOutDistance.y = appSize.height/2+cardSize.width/2;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRecognize:)];
    [self.view addGestureRecognizer:tapRecognizer];
    self.swipeRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRecognize:)];
    self.swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:self.swipeRecognizer];
}


#pragma mark - rotation

- (void)setIsRotated:(BOOL)isRotated{
    _isRotated = isRotated;
    if(isRotated){
        self.swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    }else{
        self.swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    }
}

- (void)rotateView{
    self.item.wasKeeked = YES;
    int direction = 1;
    if(self.isRotated){
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
        self.cardBackImage.hidden = self.isRotated;
        CATransform3D itemsRevertTransform = CATransform3DIdentity;
        itemsRevertTransform = CATransform3DRotate(self.enLabel.layer.transform, direction*M_PI , 0.0f, 1.0f, 0.0f);
        self.enLabel.layer.transform = itemsRevertTransform;
        self.learnBtn.layer.transform = itemsRevertTransform;
        self.transcriptionLabel.hidden = !self.isRotated;
        self.soundBtn.hidden = !self.isRotated;
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

-(void)flyOutView{
    int direction = 1;
    if(self.isRotated){
        direction = -1;
    }
    self.view.layer.zPosition=10;
    CATransform3D rotationTransform = CATransform3DIdentity;
    rotationTransform = CATransform3DTranslate(self.view.layer.transform, direction*cardOutDistance.x, cardOutDistance.y,0);
    rotationTransform = CATransform3DRotate(rotationTransform,direction*-M_PI/2, 0.0f, 0.0f, 0.1);
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
