//
//  UIView+XHShockHUD.h
//  XHShockHUD
//
//  Created by 曾 宪华 on 13-12-13.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XHShockHUD)

- (void)showShockHUD:(UIView*)hudView
            duration:(NSTimeInterval)duration
          moveVector:(CGPoint)moveVector;

- (void)showShockHUD:(UIView*)hudView
     backgroundColor:(UIColor *)backgroundColor
            duration:(NSTimeInterval)duration
          moveVector:(CGPoint)moveVector;

- (void)showShockHUD:(UIView*)hudView
     backgroundColor:(UIColor *)backgroundColor
            duration:(NSTimeInterval)duration
               delay:(NSTimeInterval)delay
             options:(UIViewAnimationOptions)options
          moveVector:(CGPoint)moveVector;

- (void)showShockHUD:(UIView*)hudView
     backgroundColor:(UIColor *)backgroundColor
            duration:(NSTimeInterval)duration
               delay:(NSTimeInterval)delay
             options:(UIViewAnimationOptions)options
          animations:(void (^)(void))animations
          completion:(void (^)(BOOL))completion;

@end
