//
//  ORMessageView.m
//  ORMessageView
//
//  Created by 郭存 on 15-7-14.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "ORMessageView.h"

#define TimeShowInterval 0.5
#define TimeHideInterval 1
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface ORMessageView()

@property (nonatomic, strong) UIImageView  *bgView;
@property (nonatomic, strong) UILabel      *msgLabel;
@property (nonatomic, assign) NSInteger    disappearAfterTime;

@end

@implementation ORMessageView

// 单例
+ (ORMessageView *)sharedView
{
    static ORMessageView *msgView = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        msgView = [[ORMessageView alloc] init];
    });
    
    return msgView;
}

// 初始化,默认展示1.5 + 1秒
- (id)init
{
    if ([super init]) {
        self.alpha = 0.0;
        self.disappearAfterTime = 1;
        
        // 此处可以设定图片背景
        self.bgView.image = nil;
    }
    return self;
}

// 设置延迟时间,默认0.5秒的显示和1秒渐变消失时间,time为0的时候toast显示为1.5秒
+ (void)showMessage:(NSString *)message disappearAfterTime:(NSInteger)time
{
    [[self sharedView] showMessage:message animated:YES disappearAfterTime:time];
}

- (void)showMessage:(NSString *)message animated:(BOOL)animated disappearAfterTime:(NSInteger)time
{
    self.disappearAfterTime = time;
    [self showMessage:message animated:animated];
}

+ (void)showMessage:(NSString *)message
{
    [[self sharedView] showMessage:message animated:YES];
}

- (void)showMessage:(NSString *)message animated:(BOOL)animated
{
    self.msgLabel.text = message;
    
    UIView *view = [[UIApplication sharedApplication].windows lastObject];
    
    self.frame = view.bounds;
    self.userInteractionEnabled = YES;
    
    [view addSubview:self];
    
    if (animated) {
        [self showAnimation];
    }
}

// 显示动画
- (void)showAnimation
{
    [UIView animateWithDuration:TimeShowInterval animations:^{
        self.alpha = 0.8;
    }completion:^(BOOL finished) {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_disappearAfterTime * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self hide];
        });
    }];
}

- (void)hide
{
    [UIView animateWithDuration:TimeHideInterval animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -- 懒加载 --
- (UILabel *)msgLabel
{
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, ScreenH - 100, ScreenW - 80, 44)];
        _msgLabel.font = [UIFont systemFontOfSize:15.0f];
        _msgLabel.textAlignment = NSTextAlignmentCenter;
        _msgLabel.textColor = [UIColor whiteColor];
        _msgLabel.backgroundColor = [UIColor clearColor];
        _msgLabel.numberOfLines = 0;
        [self addSubview:_msgLabel];
    }
    return _msgLabel;
}

- (UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, ScreenH - 100, ScreenW - 40, 44)];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.layer.cornerRadius = 5;
        _bgView.clipsToBounds = YES;
        [self addSubview:_bgView];
    }
    return _bgView;
}

@end
