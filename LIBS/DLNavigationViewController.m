//
//  DLNavigationViewController.m
//  DLNavigationTransition
//
//  Created by lxy on 16/5/17.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "DLNavigationViewController.h"

@interface DLNavigationViewController ()    <UINavigationBarDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation DLNavigationViewController


- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    //self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBar.translucent = NO;
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    self.pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:self.pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;

    
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    if ((![[NSUserDefaults standardUserDefaults] boolForKey:@"orCeHua"])) {
        return NO;
    }
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"orShouCang"]) {
//        return NO;
//    }
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"orShouCang"]) {
        return NO;
    }
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"readHistory"]) {
        return NO;
    }
    return YES;
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

@end
