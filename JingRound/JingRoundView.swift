//
//  JingRoundView.swift
//  JingFM-RoundEffect-Swift
//
//  Created by isaced on 14-6-11.
//  Copyright (c) 2014 Year isaced. All rights reserved.
//

import UIKit
import QuartzCore
import CoreGraphics

// Delegate
protocol JingRoundViewDelegate {
    func playStatuUpdate(playState:Bool)
}

// JingRoundView
class JingRoundView: UIView {
    
    var delegate:JingRoundViewDelegate?
    
    let rotationDuration:CFTimeInterval = 8.0
    
    var isPlay:Bool = false {
        didSet{
            if self.isPlay {
                startRotation()
            }else{
                pauseRotation()
            }
        }
    }

    var roundImage:UIImage!{
        didSet{
            roundImageView.image = roundImage
        }
    }
    
    var roundImageView:UIImageView!
    var playStateView:UIImageView!
    
    // init
    init(frame: CGRect) {
        super.init(frame: frame)
        initJingRound()
    }
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        
        initJingRound()
    }
    
    // init JingRound
    func initJingRound(){
        
        let center:CGPoint = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        
        //set JingRoundView
        self.clipsToBounds = true
        self.userInteractionEnabled = true
        
        self.layer.cornerRadius = center.x
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.borderWidth = 1.0
        
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowRadius = 2;
        self.layer.shadowOpacity = 0.6;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        
        //set roundImageView
        self.roundImageView = UIImageView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        self.roundImageView.center = center
        self.roundImageView.image = self.roundImage
        self.addSubview(self.roundImageView)
        
        //set play state
        var stateImage:UIImage;
        if self.isPlay {
            stateImage = UIImage(named: "start")
        }else{
            stateImage = UIImage(named: "pause")
        }
        
        self.playStateView = UIImageView(frame: CGRect(x: 0, y: 0, width: stateImage.size.width, height: stateImage.size.height))
        self.playStateView.center = center
        self.playStateView.image = stateImage
        self.addSubview(self.playStateView)

        //border
        var colorSpace:CGColorSpaceRef = CGColorSpaceCreateDeviceRGB();
        let bitmapInfo = CGBitmapInfo.fromRaw(CGImageAlphaInfo.PremultipliedFirst.toRaw())!
        var context:CGContextRef = CGBitmapContextCreate(nil, UInt(self.frame.size.width), UInt(self.frame.size.height), UInt(8), UInt(0), colorSpace, bitmapInfo)
        CFRelease(colorSpace);
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().colorWithAlphaComponent(0.7).CGColor);
        CGContextBeginPath(context);
        CGContextAddArc(context, center.x, center.y, center.x, 0, CGFloat(2 * M_PI), 0)
        CGContextClosePath(context);
        CGContextSetLineWidth(context, 15.0);
        CGContextStrokePath(context);


        // convert the context into a CGImageRef
        var image:CGImageRef = CGBitmapContextCreateImage(context);
        CGContextRelease(context);
        var image2:UIImage = UIImage(CGImage: image)
        var imgv:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        imgv.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        imgv.image = image2;
        self.addSubview(imgv)

        //Rotation
        var rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = M_PI * 2.0
        rotationAnimation.duration = self.rotationDuration;
        rotationAnimation.repeatCount = HUGE
        rotationAnimation.cumulative = false;
        rotationAnimation.removedOnCompletion = false; //No Remove
        self.roundImageView.layer.addAnimation(rotationAnimation, forKey: "rotation")
        
        //pause
        if !self.isPlay {
            self.layer.speed = 0.0;
        }
        
    }
    
    func startRotation() {
        //start Animation
        self.layer.speed = 1.0;
        self.layer.beginTime = 0.0;
        
        let pausedTime:CFTimeInterval = self.layer.timeOffset
        let timeSincePause:CFTimeInterval = self.layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        
        self.layer.beginTime = timeSincePause;
        
        //set ImgView
        self.playStateView.image = UIImage(named: "start")
        UIView.animateKeyframesWithDuration(0.6, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModePaced, animations: {
                self.playStateView.alpha = 1;
            }, completion: { (finished:Bool) -> () in
                if finished {
                    UIView.animateWithDuration(1.0, animations: {
                        self.playStateView.alpha = 0
                        })
                }
            })
    }
    
    func pauseRotation() {
        //set ImgView
        self.playStateView.image = UIImage(named: "pause")
        self.userInteractionEnabled = false;
        
        UIView.animateWithDuration(0.6, animations: {
            self.playStateView.alpha = 1
        }, completion: { (finished:Bool) -> () in
            if finished {
                self.userInteractionEnabled = true;
                UIView.animateWithDuration(1.0, animations: {
                    self.playStateView.alpha = 0
                    //pause
                    let pausedTime:CFTimeInterval = self.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
                    self.layer.speed = 0.0;
                    self.layer.timeOffset = pausedTime;
                })
            }
        })
    }
    
    func play() {
        self.isPlay = true
    }
    
    func pause() {
        self.isPlay = false
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        self.isPlay = !self.isPlay;
        self.delegate?.playStatuUpdate(self.isPlay)
    }
}
