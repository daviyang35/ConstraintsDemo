//
//  SecondViewController.m
//  ConstraintsDemo
//
//  Created by 杨大伟 on 15/7/4.
//  Copyright (c) 2015年 daviyang35. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (strong,nonatomic) UIView *blueView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _blueView = [[UIView alloc] init];
    _blueView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:_blueView];
    
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

/**
 *  将_redView设置为
    距离父视图左侧50px
    距离父视图顶部100px
    宽度大于等于150
    高度大于等于150
 使用constraintsWithVisualFormat
 */
-(void)setLayout
{
    
    [_blueView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // 使用宏创建一个字典
    // 下面的宏得到：{"self.view":self.view , "_blueView":_blueView }
    NSDictionary *views = NSDictionaryOfVariableBindings(_blueView);
    
    // V:|-[_blueView(>=150)]-20-|
    // H代表水平布局，V代表垂直布局，紧跟一个:
    // ||   代表父视图边界,可选出现
    // -    单独一个表示标准距离，通常是8px
    // -N-  两个夹着的数字，代替标准距离值，这里是20px
    // [_blueView] 中括号表示对象，必须是views参数里面指定的键字符串
    // (>=150)      中括号中的小括号表示对象尺寸优先级
    
    NSString *width = @"H:|-50-[_blueView(>=150)]";
    NSString *height = @"V:|-100-[_blueView(>=150)]";
    
    NSArray *widthConstraints = [NSLayoutConstraint constraintsWithVisualFormat:width
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views];
    
    NSArray *heightConstraints = [NSLayoutConstraint constraintsWithVisualFormat:height
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views];
    
    [self.view addConstraints:widthConstraints];
    [self.view addConstraints:heightConstraints];
}

@end
