//
//  XHUIKitViewController.m
//  XHShockHUD
//
//  Created by 曾 宪华 on 13-12-13.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "XHUIKitViewController.h"
#import "UIView+XHShockHUD.h"

@interface XHUIKitViewController ()
@end

@implementation XHUIKitViewController

#pragma mark - Left cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"点击任何地方试试看", @"");
    self.view.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(_tapHandler:)];
    
    [self.view addGestureRecognizer:tap];
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
    UILabel *damageLabel = [[UILabel alloc]  initWithFrame:CGRectMake(0, 0, 50.0, 20.0) ];
    damageLabel.text = @"50";
    damageLabel.textColor = [UIColor yellowColor];
    damageLabel.center = point;
    damageLabel.textAlignment = UITextAlignmentCenter;
    [self.view showShockHUD:damageLabel
                    duration:1.5
                  moveVector:CGPointMake(0, -75)];
}

@end
