//
//  Demo1ViewController.m
//  ConstraintsDemo
//
//  Created by 杨大伟 on 15/7/4.
//  Copyright (c) 2015年 daviyang35. All rights reserved.
//

#import "Demo1ViewController.h"

@interface Demo1ViewController ()

@property (strong,nonatomic) UIView *redView;
@property (strong,nonatomic) UIView *blueView;
@property (strong,nonatomic) UIView *grayView;

@end

@implementation Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _redView = [[UIView alloc] init];
    _redView.backgroundColor = [UIColor redColor];
    
    _blueView = [[UIView alloc] init];
    _blueView.backgroundColor = [UIColor blueColor];
    
    _grayView = [[UIView alloc] init];
    _grayView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:_redView];
    [self.view addSubview:_blueView];
    [self.view addSubview:_grayView];
    
    [self setLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setLayout
{
    [_redView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_blueView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_grayView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_redView,_blueView,_grayView,self.view);
    
    // 目标：
    // _redVeiew 与 _blueView 宽度高度一致，左右间隔一个单位
    // _grayView 高度占可视区域50%,左右留一个单位间隙
    
    CGRect tabBarFrame = self.tabBarController.tabBar.frame;
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect screen = [self.view frame];
    
    NSNumber *screenHeight= [NSNumber numberWithFloat:(screen.size.height - statusBarFrame.size.height - tabBarFrame.size.height)/2];
    
    NSNumber *statusBarHeight = [NSNumber numberWithFloat:statusBarFrame.size.height];

    NSDictionary *metrics = NSDictionaryOfVariableBindings(screenHeight,statusBarHeight);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"H:|-[_redView(>=50)]-[_blueView(==_redView)]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"H:|-[_grayView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"V:|-statusBarHeight-[_redView(==screenHeight)]-[_grayView(==screenHeight)]"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"V:|-statusBarHeight-[_blueView(==_redView)]"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
}

@end
