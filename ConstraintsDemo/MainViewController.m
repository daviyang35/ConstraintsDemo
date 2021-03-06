//
//  MainViewController.m
//  ConstraintsDemo
//
//  Created by 杨大伟 on 15/7/4.
//  Copyright (c) 2015年 daviyang35. All rights reserved.
//

#import "MainViewController.h"
#import "HelloViewController.h"
#import "SecondViewController.h"
#import "Demo1ViewController.h"
#import "DynamicViewController.h"
#import "DynamicAnimatorTableViewController.h"

@interface MainViewController ()

@property (strong,nonatomic)    HelloViewController *helloViewController;
@property (strong,nonatomic)    SecondViewController *secondViewController;
@property (strong,nonatomic)    Demo1ViewController *demo1ViewController;
@property (strong,nonatomic)    DynamicAnimatorTableViewController *dynamicViewController;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    _helloViewController = [[HelloViewController alloc] init];
    _secondViewController = [[SecondViewController alloc] init];
    _demo1ViewController = [[Demo1ViewController alloc] init];
    _dynamicViewController = [[DynamicAnimatorTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    self.viewControllers = @[_helloViewController,_secondViewController,_demo1ViewController,[self addControllerWithNavigationController:_dynamicViewController]];

    NSArray *titleArray = @[@"Item",@"VFL",@"Demo1",@"Dynamic"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        item.title = titleArray[idx];
    }];
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

- (UINavigationController*)addControllerWithNavigationController:(UIViewController*)viewController
{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navigationController.delegate = viewController;
    return navigationController;
}

@end
