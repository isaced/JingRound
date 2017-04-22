//
//  ViewController.m
//  JingFM-RoundEffect
//
//  Created by isaced on 13-6-6.
//  Copyright (c) 2013年 isaced. All rights reserved.
//  By isaced:http://www.isaced.com/

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    
    self.roundView.delegate = self;
    self.roundView.roundImage = [UIImage imageNamed:@"girl"];
    self.roundView.rotationSpeed = 3.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)playStatuUpdate:(BOOL)playState
{
    NSLog(@"%@...", playState ? @"Playing": @"Pause");
}

@end
