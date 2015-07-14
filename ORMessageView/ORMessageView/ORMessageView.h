//
//  ORMessageView.h
//  ORMessageView
//
//  Created by 郭存 on 15-7-14.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ORMessageView : UIView

+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message disappearAfterTime:(NSInteger)time;

@end
