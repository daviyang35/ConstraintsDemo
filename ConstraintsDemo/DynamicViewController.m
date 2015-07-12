//
//  DynamicViewController.m
//  ConstraintsDemo
//
//  Created by 杨大伟 on 15/7/10.
//  Copyright (c) 2015年 daviyang35. All rights reserved.
//

#import "DynamicViewController.h"

@interface DynamicViewController ()

@property (strong,nonatomic)    UIView * ball;
@property (strong,nonatomic)    UIDynamicAnimator *animator;
@property (assign,nonatomic)    BOOL bNeedReset;

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _ball = [[UIView alloc] init];
    _ball.frame = CGRectMake(100, 100, 50, 50);
    _ball.backgroundColor = [UIColor redColor];
    //_ball.transform = CGAffineTransformRotate(_ball.transform, 60);
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _bNeedReset = FALSE;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTap)]];
    
    [self.view addSubview:_ball];
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

- (void)userTap
{
    if (_bNeedReset)
    {
        [_animator removeAllBehaviors];
        _ball.frame = CGRectMake(100, 100, 50, 50);
        //_ball.transform = CGAffineTransformRotate(_ball.transform, 60);
        _bNeedReset = NO;
    }
    else
    {
        _bNeedReset = YES;
        [_animator removeAllBehaviors];
        
        /*
        // 重力
        UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[_ball]];
        [_animator addBehavior:gravityBehavior];
        
        //
        UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_ball]];
        // 将参考系的边界作为边界
        //collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        // 自己设置的边界，在TabBar之上
        CGFloat height = self.tabBarController.tabBar.frame.size.height;
        [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(0, 0, height, 0)];
        [_animator addBehavior:collisionBehavior];
         //*/
        
        CGRect rectScreen = [[UIScreen mainScreen] bounds];
        CGSize tabBarSize = self.tabBarController.tabBar.frame.size;
        
        // attachedToAnchor 锚点坐标
        UIAttachmentBehavior * behavior = [[UIAttachmentBehavior alloc]initWithItem:_ball
                                                                   attachedToAnchor:CGPointMake(rectScreen.size.width/2, rectScreen.size.height - tabBarSize.height-_ball.frame.size.height/2)];
        behavior.damping = 1;
        behavior.frequency=4;
        //
        behavior.length = 20;
        [_animator addBehavior:behavior];
        
    }
}

@end
