//
//  JingRoundView.m
//  JingFM-RoundEffect
//
//  Created by isaced on 13-6-6.
//  Copyright (c) 2013年 isaced. All rights reserved.
//  By isaced:http://www.isaced.com/

#import "JingRoundView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#define kRotationDuration 8.0

@interface JingRoundView ()

@property (strong, nonatomic) UIImageView *roundImageView;
@property (strong, nonatomic) UIImageView *playStateView;

@end

@implementation JingRoundView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initJingRound];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initJingRound];
    }
    return self;
}

- (void) initJingRound {
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    
    // set JingRoundView
    self.clipsToBounds = YES;
    self.userInteractionEnabled = YES;
    
    self.layer.cornerRadius = center.x;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [[UIColor grayColor] CGColor];
    
    self.layer.shadowColor = UIColor.blackColor.CGColor;
    self.layer.shadowRadius = 2;
    self.layer.shadowOpacity = 0.6;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    
    // set roundImageView
    UIImage *roundImage = self.roundImage;
    self.roundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.roundImageView setCenter:center];
    [self.roundImageView setImage:roundImage];
    [self addSubview:self.roundImageView];
    
    // set play state
    UIImage *stateImage;
    if (self.isRotating) {
        stateImage = [UIImage imageNamed:@"start"];
    }else{
        stateImage = [UIImage imageNamed:@"pause"];
    }
    
    self.playStateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, stateImage.size.width, stateImage.size.height)];
    [self.playStateView setCenter:center];
    [self.playStateView setImage:stateImage];
    [self addSubview:self.playStateView];
    
    // border
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
#define kCGImageAlphaPremultipliedLast  (kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast)
#else
#define kCGImageAlphaPremultipliedLast  kCGImageAlphaPremultipliedLast
#endif
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(nil, self.frame.size.width, self.frame.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CFRelease(colorSpace);
    
    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7] CGColor]);
    CGContextBeginPath(context);
    CGContextAddArc(context, center.x, center.y, center.x , 0, 2 * M_PI, 0);
    CGContextClosePath(context);
    CGContextSetLineWidth(context, 15.0);
    CGContextStrokePath(context);
    
    
    // convert the context into a CGImageRef
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    UIImage* image2 = [UIImage imageWithCGImage:image];
    UIImageView *imgv =[[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width , self.frame.size.height)];
    imgv.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    imgv.image = image2;
    [self addSubview:imgv];
    
    //Rotation
    [self addRotationAnimation];
    
    _isRotating = YES;
}

- (void)addRotationAnimation {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = kRotationDuration;
    rotationAnimation.repeatCount = FLT_MAX;
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO; // No Remove
    [self.roundImageView.layer addAnimation:rotationAnimation forKey:@"jinground.rotation"];
}

#pragma mark Setter

- (void)setRoundImage:(UIImage *)aRoundImage {
    _roundImage = aRoundImage;
    self.roundImageView.image = self.roundImage;
}

- (void)setRotationSpeed:(float)rotationSpeed {
    _rotationSpeed = rotationSpeed;

    self.roundImageView.layer.timeOffset = [self.roundImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.roundImageView.layer.beginTime = CACurrentMediaTime();
    self.roundImageView.layer.speed = rotationSpeed;
}

#pragma mark Action

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_isRotating) {
        [self pause];
    }else{
        [self resume];
    }

    if ([self.delegate respondsToSelector:@selector(playStatuUpdate:)]) {
        [self.delegate playStatuUpdate:_isRotating];
    }
}

- (void)resume {
    CFTimeInterval pausedTime = [self.roundImageView.layer timeOffset];
    self.roundImageView.layer.speed = 1;
    self.roundImageView.layer.timeOffset = 0.0;
    self.roundImageView.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.roundImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.roundImageView.layer.beginTime = timeSincePause;
    
    [self setRotationSpeed:_rotationSpeed];
    
    _isRotating = YES;
    
    self.playStateView.image = [UIImage imageNamed:@"start"];
    [UIView animateWithDuration:0.25 animations:^{
        self.playStateView.alpha = 0.0;
    }];
}

- (void)pause {
    CFTimeInterval pausedTime = [self.roundImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.roundImageView.layer.speed = 0.0;
    self.roundImageView.layer.timeOffset = pausedTime;
    
    _isRotating = NO;
    
    self.playStateView.image = [UIImage imageNamed:@"pause"];
    [UIView animateWithDuration:0.25 animations:^{
        self.playStateView.alpha = 1.0;
    }];
}

@end
