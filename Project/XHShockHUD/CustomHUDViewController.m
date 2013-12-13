//
//  CustomHUDViewController.m
//  XHShockHUD
//
//  Created by 曾 宪华 on 13-12-13.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "CustomHUDViewController.h"

@interface CustomHUDViewController ()

@end

@implementation CustomHUDViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *buttonTitles = [NSArray arrayWithObjects:@"2秒后消失的错误提示", @"2秒后消失的成功提示", @"2秒后消失的普通信息提示", @"2秒后消失的Loading提示", @"不消失，让你手动控制消失", nil];
    
    CGFloat padding = 10;
    CGFloat buttonHeight = 35;
    for (NSString *buttonTitle in buttonTitles) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:1.000 green:0.341 blue:0.399 alpha:1.000]];
        [button setTintColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger index = [buttonTitles indexOfObject:buttonTitle];
        button.tag = index;
        button.frame = CGRectMake(padding, padding + ((buttonHeight + padding) * index), CGRectGetWidth(self.view.frame) - (padding * 2), buttonHeight);
        [self.view addSubview:button];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Handler

- (void)buttonClicked:(UIButton *)sender {
    NSString *hudString = NSLocalizedString(@"提示内容", @"");
    if (sender.tag > 3) {
        [self.view showHUDWithText:hudString hudType:kXHHUDInfo animationType:kXHHUDFade];
    } else {
        [self.view showHUDWithText:hudString hudType:sender.tag animationType:kXHHUDFade delay:2];
    }
}

@end
