//
//  JingRoundView.h
//  JingFM-RoundEffect
//
//  Created by isaced on 13-6-6.
//  Copyright (c) 2013年 isaced. All rights reserved.
//  By isaced:http://www.isaced.com/

#import <UIKit/UIKit.h>

@protocol JingRoundViewDelegate <NSObject>

-(void) playStatuUpdate:(BOOL)playState;

@end

@interface JingRoundView : UIView

@property (weak, nonatomic) id<JingRoundViewDelegate> delegate;

/// 中心图像
@property (strong, nonatomic) UIImage *roundImage;

/// 是否播放
@property (assign, nonatomic, readonly) BOOL isRotating;

/// 转圈速度
@property (assign, nonatomic) float rotationSpeed;


/// 继续播放
- (void)resume;

/// 暂停
- (void)pause;

@end
