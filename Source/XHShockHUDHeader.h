//
//  XHShockHUDHeader.h
//  XHShockHUD
//
//  Created by 曾 宪华 on 13-12-13.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#ifndef XHShockHUD_XHShockHUDHeader_h
#define XHShockHUD_XHShockHUDHeader_h

#define XH_BUNDLE_IMAGE(_file) [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"XHShockHUD.bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.png", _file, ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2) ? @"@2x" : @""]]

typedef NS_ENUM(NSInteger, XHHUDType) {
    kXHHUDError = 0,
    kXHHUDSuccess,
    kXHHUDInfo,
    kXHHUDLoading
};

typedef NS_ENUM(NSInteger, XHHUDAnimationType) {
    kXHHUDFade = 0
};

#endif
