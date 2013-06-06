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

@property (strong, nonatomic) UIImage *roundImage;
@property (assign, nonatomic) BOOL isPlay;
@property (assign, nonatomic) float rotationDuration;


-(void) play;
-(void) pause;

@end
