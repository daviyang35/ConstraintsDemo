//
//  HelloViewController.m
//  ConstraintsDemo
//
//  Created by 杨大伟 on 15/7/4.
//  Copyright (c) 2015年 daviyang35. All rights reserved.
//

#import "HelloViewController.h"

@interface HelloViewController ()

@property (strong,nonatomic) UIView *redView;

@end

@implementation HelloViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _redView = [[UIView alloc] init];
    _redView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_redView];
    // 在添加约束前，子控件需要已经被添加到父控件中
    // 原因在约束添加规则
    [self setRedLayout];
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
 使用constraintWithItem逐条添加规则
 */
-(void)setRedLayout
{
    // 控件的常规大小
    CGRect viewFrame = CGRectMake(50, 100, 150, 150);
    
    // 使用Auto Layout
    // 禁止视图的AutoreszingMask转化为AutoLayout约束
    [_redView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // NSLayoutAttributeLeading 在常规情况下等价于 NSLayoutAttributeLeft
    // 当处于阿拉伯语等从右至左阅读文字时，NSLayoutAttributeLeading就等于NSLayoutAttributeRight
    
    // NSLayoutAttributeTrailing 同理
    
    // _redView.left == self.view.left*1 + 50
    NSLayoutConstraint *viewLeft = [NSLayoutConstraint constraintWithItem:_redView
                                                                attribute:NSLayoutAttributeLeading  // Leading等价于Left
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1
                                                                 constant:CGRectGetMinX(viewFrame)];
    
    // _redView.top == self.view.top*1 + 100
    NSLayoutConstraint *viewTop = [NSLayoutConstraint constraintWithItem:_redView
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1
                                                                constant:CGRectGetMinY(viewFrame)];
    
    // 设置控件的宽度和高度，尽量不要使用NSLayoutRelationEqual
    // 因为浮动相对布局中，使用固定值会带来许多潜在问题：
    /*
     * 根据内容决定宽度的视图，当内容改变时，外观尺寸无法做出正确的改变
     * 在本地化时，过长的文字无法显示，造成文字切断，或文字果断，宽度显得过宽，影响美观
     * 添加了多余的约束时，约束之间冲突，无法显示正确的布局
     */
    
    // 正确设置宽高度，有如下Tips：
    /*
     * 如果宽度和高度布局可以改变，使用固有内容尺寸设置约束（既size to fit size）
     * 如果宽度和高度布局不可以改变，改变约束的关系为 >=
     * 调整压缩优先级和内容抗压缩优先级
     */
    
    // 如果指定了Relation为：>= 或 <= ，将优先满足==
    // 既： height >= 150,该控件初始化时高度很可能为150，
    
    // _redView.height >= 0 + 150
    NSLayoutConstraint *viewHeight = [NSLayoutConstraint constraintWithItem:_redView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:CGRectGetHeight(viewFrame)];
    
    // _redView.width >= 0 + 150
    NSLayoutConstraint *viewWidth = [NSLayoutConstraint constraintWithItem:_redView
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1
                                                                  constant:CGRectGetWidth(viewFrame)];
    // 添加约束的规则：
    /*
     * 直接设置视图的宽度/高度时，添加到视图本身
     
     Tips：以下三条约束都存在父子关系，所以在添加约束前，子控件需要已经被添加到父控件，否则没法计算关系
     
     * 两个同层级间视图的约束，添加到它们共同的父视图上
     * 两个不同层级间视图的约束，添加到它们最近的共同父视图上
     * 两个有层级关系的视图的约束，添加到层次较高的视图（父视图）上
     *
     */
    
    [_redView addConstraints:@[viewWidth,viewHeight]];  // 这属于第一种情况，直接设置自己的宽高度
    [self.view addConstraints:@[viewTop,viewLeft]];     // 有共同的层级（父视图），设置给父视图
    
}

@end
