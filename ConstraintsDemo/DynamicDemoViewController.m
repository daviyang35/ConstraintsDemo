//
//  DynamicDemoViewController.m
//  ConstraintsDemo
//
//  Created by 杨大伟 on 15/7/12.
//  Copyright (c) 2015年 daviyang35. All rights reserved.
//

#import "DynamicDemoViewController.h"

@implementation DynamicDemoViewController

- (void)viewDidLoad
{
    self.navigationItem.title = @"Snap";
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
        [self.tabBarController.tabBar setHidden:NO];
}

@end
