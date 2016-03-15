//
//  UIView+XHShockHUD.m
//  XHShockHUD
//
//  Created by 曾 宪华 on 13-12-13.
//  Copyright (c) 2013年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "UIView+XHShockHUD.h"

@implementation UIView (XHShockHUD)

- (void)showShockHUD:(UIView*)hudView
            duration:(NSTimeInterval)duration
          moveVector:(CGPoint)moveVector
{
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone;
    NSTimeInterval delay = 0.0;
    
    [self showShockHUD:hudView
       backgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0    alpha:0.0]
              duration:duration
                 delay:delay
               options:options
            moveVector:moveVector];
}

- (void)showShockHUD:(UIView*)hudView
     backgroundColor:(UIColor *)backgroundColor
            duration:(NSTimeInterval)duration
          moveVector:(CGPoint)moveVector {
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone;
    NSTimeInterval delay = 0.0;
    
    [self showShockHUD:hudView backgroundColor:backgroundColor duration:duration delay:delay options:options moveVector:moveVector];
}

- (void)showShockHUD:(UIView*)hudView
     backgroundColor:(UIColor *)backgroundColor
            duration:(NSTimeInterval)duration
               delay:(NSTimeInterval)delay
             options:(UIViewAnimationOptions)options
          moveVector:(CGPoint)moveVector
{
    CGPoint endPoint = CGPointMake(hudView.center.x + moveVector.x, hudView.center.y + moveVector.y);
    
    [self showShockHUD:hudView
       backgroundColor:backgroundColor
              duration:duration
                 delay:delay
               options:options
            animations:^{
                 hudView.center = endPoint;
                 hudView.alpha = 0.0;
             }
             completion:nil];
}

- (void)showShockHUD:(UIView*)hudView
     backgroundColor:(UIColor *)backgroundColor
            duration:(NSTimeInterval)duration
               delay:(NSTimeInterval)delay
             options:(UIViewAnimationOptions)options
          animations:(void (^)(void))animations
          completion:(void (^)(BOOL))completion
{
    hudView.backgroundColor = backgroundColor;
    hudView.hidden = NO;
    
    [self addSubview:hudView];
    
    [UIView animateWithDuration:duration
                          delay:delay
                        options:options
                     animations:animations
                     completion:^(BOOL finished){
                         if(completion){
                             completion(finished);
                         }
                         if (finished) {
                             [hudView removeFromSuperview];
                         }
                     }];
}

@end
