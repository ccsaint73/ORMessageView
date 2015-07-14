//
//  ORViewController.m
//  ORMessageView
//
//  Created by 郭存 on 15-7-14.
//  Copyright (c) 2015年 lucius. All rights reserved.
//

#import "ORViewController.h"
#import "ORMessageView.h"

@interface ORViewController ()

@end

@implementation ORViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [ORMessageView showMessage:@"toast演示"];
}

@end
