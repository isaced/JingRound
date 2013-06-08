//
//  JingRoundView.h
//  JingFM-RoundEffect
//
//  Created by isaced on 13-6-6.
//  Copyright (c) 2013年 isaced. All rights reserved.
//  By isaced:http://www.isaced.com/

#import <UIKit/UIKit.h>

////////////
//delegate//
////////////
@protocol JingRoundViewDelegate <NSObject>

-(void) playStatuUpdate:(BOOL)playState;

@end


//////////////
//@interface//
//////////////
@interface JingRoundView : UIView

@property (assign, nonatomic) id<JingRoundViewDelegate> delegate;

//中心图像
@property (strong, nonatomic) UIImage *roundImage;

//是否播放
@property (assign, nonatomic) BOOL isPlay;

//转圈速度
@property (assign, nonatomic) float rotationDuration;


//开始播放
-(void) play;

//暂停
-(void) pause;

@end
