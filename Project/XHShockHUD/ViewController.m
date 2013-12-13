//
//  ViewController.m
//  XHShockHUD
//
//  Created by 曾 宪华 on 13-12-13.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "ViewController.h"
#import "XHShockHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"点击任何地方试试看", @"");
    
    self.view.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(_tapHandler:)];
    
    [self.view addGestureRecognizer:tap];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(_tapHandler:)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.image = [UIImage imageNamed:@"5_1280x800.jpeg"];
    imageView.userInteractionEnabled = YES;
    imageView.backgroundColor = [UIColor grayColor];
    [imageView addGestureRecognizer:tap];
    [self.view addSubview:imageView];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(_tapHandler:)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 210, 200, 100)];
    label.text = NSLocalizedString(@"试试在文字里面点击看看", @"");
    label.backgroundColor = [UIColor grayColor];
    label.textColor = [UIColor blackColor];
    [label addGestureRecognizer:tap];
    [self.view addSubview:label];
    
    // 只要是继承UIView的类，我们的HUD都可以在里面show出来，并且是你需要的，喜欢的，样式好的，欢迎大家来强大他
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIGesture 

- (void)_tapHandler:(UITapGestureRecognizer *)tap {
    UIView *tapLocalView = tap.view;
    CGPoint point = [tap locationInView:tapLocalView];
//    UILabel *damageLabel = [[UILabel alloc]  initWithFrame:CGRectMake(0, 0, 50.0, 20.0) ];
//    damageLabel.text = @"50";
//    damageLabel.textColor = [UIColor yellowColor];
//    damageLabel.center = point;
//    damageLabel.textAlignment = UITextAlignmentCenter;
//    [self.view showDamageHUD:damageLabel
//                    duration:1.5
//                  moveVector:CGPointMake(0,-75)];
    [self.view showHUDWithText:@"我爱你" hudType:kSuccess animationType:kFade delay:2.0];
    
}

@end
