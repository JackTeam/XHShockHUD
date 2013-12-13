//
//  UIView+XHCustomHUD.m
//  XHShockHUD
//
//  Created by 曾 宪华 on 13-12-13.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "UIView+XHCustomHUD.h"
#import <objc/runtime.h>

#define kIconError @"icon-error"
#define kIconSuccess @"icon-success"
#define kIconInfo @"icon-info"


@interface XHHUDView : UIView
@property (nonatomic, assign) XHHUDType hudType;
@property (nonatomic, copy) NSString *text;
@end

@implementation XHHUDView

#pragma mark - Propertys

- (void)_setupUIWithIcon:(NSString *)iconImageName {
    UIImage *iconImage = [UIImage imageWithContentsOfFile:XH_BUNDLE_IMAGE(iconImageName)];
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:iconImage];
    CGFloat padding = 18.7;
    CGRect iconImageViewFrame = iconImageView.frame;
    iconImageViewFrame.origin.x = CGRectGetWidth(self.frame) / 2.0 - CGRectGetWidth(iconImageViewFrame) / 2.0;
    iconImageViewFrame.origin.y = padding;
    iconImageView.frame = iconImageViewFrame;
    [self addSubview:iconImageView];
    
    [self _initalizerLabelWithUnderView:iconImageView];
}

- (void)_initalizerLabelWithUnderView:(UIView *)underView {
    CGFloat textLabelY = CGRectGetHeight(underView.frame) + underView.frame.origin.y;
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, textLabelY, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - textLabelY)];
    textLabel.text = self.text;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:textLabel];
}

- (void)_setupLoadingUI {
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicatorView startAnimating];
    CGFloat padding = 10;
    CGRect activityIndicatorViewFrame = activityIndicatorView.frame;
    activityIndicatorViewFrame.origin.x = CGRectGetWidth(self.frame) / 2.0 - CGRectGetWidth(activityIndicatorViewFrame) / 2.0;
    activityIndicatorViewFrame.origin.y = padding;
    activityIndicatorView.frame = activityIndicatorViewFrame;
    
    [self addSubview:activityIndicatorView];
    
    [self _initalizerLabelWithUnderView:activityIndicatorView];
}

- (void)setHudType:(XHHUDType)hudType {
    _hudType = hudType;
    switch (_hudType) {
        case kXHHUDError:
            [self _setupUIWithIcon:kIconError];
            break;
        case kXHHUDSuccess:
            [self _setupUIWithIcon:kIconSuccess];
            break;
        case kXHHUDInfo:
            [self _setupUIWithIcon:kIconInfo];
            break;
        case kXHHUDLoading:
            [self _setupLoadingUI];
            break;
        default:
            break;
    }
}

#pragma mark - HUDView left cycle init

- (void)_setup {
    self.backgroundColor = [UIColor clearColor];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    // 简便起见，这里把圆角半径设置为长和宽平均值的1/10
    CGFloat radius = (width + height) * 0.05;
    
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 移动到初始点
    CGContextMoveToPoint(context, radius, 0);
    
    // 绘制第1条线和第1个1/4圆弧
    CGContextAddLineToPoint(context, width - radius, 0);
    CGContextAddArc(context, width - radius, radius, radius, -0.5 * M_PI, 0.0, 0);
    
    // 绘制第2条线和第2个1/4圆弧
    CGContextAddLineToPoint(context, width, height - radius);
    CGContextAddArc(context, width - radius, height - radius, radius, 0.0, 0.5 * M_PI, 0);
    
    // 绘制第3条线和第3个1/4圆弧
    CGContextAddLineToPoint(context, radius, height);
    CGContextAddArc(context, radius, height - radius, radius, 0.5 * M_PI, M_PI, 0);
    
    // 绘制第4条线和第4个1/4圆弧
    CGContextAddLineToPoint(context, 0, radius);
    CGContextAddArc(context, radius, radius, radius, M_PI, 1.5 * M_PI, 0);
    
    // 闭合路径
    CGContextClosePath(context);
    // 填充半透明黑色(0.8 alpha)
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 0.8);
    CGContextDrawPath(context, kCGPathFill);
}

@end

@implementation UIView (XHCustomHUD)

static char UIViewHUD;

#pragma mark - getter / setter

- (void)setHudView:(XHHUDView *)hudView {
    [self willChangeValueForKey:@"hudView"];
    objc_setAssociatedObject(self, &UIViewHUD,
                             hudView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"hudView"];
}

- (XHHUDView *)hudView {
    return objc_getAssociatedObject(self, &UIViewHUD);
}

#pragma mark - Public api

- (void)showHUDWithText:(NSString *)text hudType:(XHHUDType)hudType animationType:(XHHUDAnimationType)animationType {
    [self showHUDWithText:text hudType:hudType animationType:animationType delay:0];
}

- (void)showHUDWithText:(NSString *)text hudType:(XHHUDType)hudType animationType:(XHHUDAnimationType)animationType delay:(NSTimeInterval)delay {
    [self showHUDWithText:text hudSize:CGSizeMake(100, 100) hudType:hudType animationType:animationType delay:delay];
}

- (void)showHUDWithText:(NSString *)text
                hudSize:(CGSize)hudSize
                hudType:(XHHUDType)hudType
          animationType:(XHHUDAnimationType)animationType
                  delay:(NSTimeInterval)delay {
    XHHUDView *hudView = [[XHHUDView alloc] initWithFrame:CGRectZero];
    
    CGRect hudViewFrame = hudView.frame;
    hudViewFrame.size = hudSize;
    hudView.frame = hudViewFrame;
    
    hudView.center = self.center;
    hudView.text = text;
    hudView.hudType = hudType;
    hudView.transform = CGAffineTransformMakeScale(1.45, 1.45);
    hudView.alpha = 0.0;
    [self addSubview:hudView];
    self.hudView = hudView;
    
    switch (animationType) {
        case kXHHUDFade:
            [self _fadeAnimationWithHUDView:hudView delay:delay];
            break;
        default:
            break;
    }
}

#pragma mark - 自定义 动画 欢迎大家来完善，加入更多的动画

- (void)_fadeAnimationWithHUDView:(XHHUDView *)hudView
                    delay:(NSTimeInterval)delay {
    void (^animations)() = ^{
        hudView.alpha = 1.0;
        hudView.transform = CGAffineTransformIdentity;
    };
    
    void (^completion)(BOOL finish) = ^(BOOL finishi) {
        if (delay) {
            [self dismissHUD:hudView delay:delay];
        }
    };
    
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone;
    [UIView animateWithDuration:0.3 delay:0 options:options animations:animations completion:completion];
}

- (void)dismissHUD:(XHHUDView *)hudView delay:(NSTimeInterval)delay {
    [UIView animateWithDuration:0.5 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
        hudView.alpha = .0f;
        hudView.transform = CGAffineTransformMakeScale(0.65, 0.65);
    } completion:^(BOOL finished) {
        [hudView removeFromSuperview];
    }];
}

@end
