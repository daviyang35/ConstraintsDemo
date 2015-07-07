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
@property (strong,nonatomic) NSMutableArray *constraints;

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
    
    _constraints = [NSMutableArray array];
    
    [self.view addSubview:_redView];
    [self.view addSubview:_blueView];
    [self.view addSubview:_grayView];
    
    //[self setLayout];
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

- (void)viewWillLayoutSubviews
{
    for (NSArray* array in _constraints)
    {
        [self.view removeConstraints:array];
    }
    [_constraints removeAllObjects];
    [self setLayout];
}

- (void)setLayout
{
    [_redView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_blueView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_grayView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_redView,_blueView,_grayView);
    
    // 目标：
    // _redView 与 _blueView 宽度高度一致，左右间隔一个单位
    // _grayView 与 _redView 高度一致,左上右留一个单位间隙
    
    CGRect tabBarFrame = self.tabBarController.tabBar.frame;
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    
    NSNumber *statusBarHeight = [NSNumber numberWithFloat:statusBarFrame.size.height];
    NSNumber *tabBarHeight = [NSNumber numberWithFloat:tabBarFrame.size.height];
    

    NSDictionary *metrics = NSDictionaryOfVariableBindings(statusBarHeight,tabBarHeight);
    
    [_constraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"H:|-[_redView]-[_blueView(==_redView)]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [_constraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"H:|-[_grayView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [_constraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"V:|-statusBarHeight-[_redView]-[_grayView(==_redView)]-tabBarHeight-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    
    [_constraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"V:|-statusBarHeight-[_blueView(==_redView)]"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    for (NSArray * array in _constraints)
    {
        [self.view addConstraints:array];
    }
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

@end
