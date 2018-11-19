//
//  TabBarController.m
//  RoseTactic
//
//  Created by 曹老师 on 2018/11/18.
//  Copyright © 2018 曹奕程. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()



@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置分页的标签
    NSArray *titleName = @[@"鲜花",@"攻略",@"设置"];
    
    //设置
    self.tabBar.translucent = NO;
    for (int i = 0; i < self.viewControllers.count; i++)
    {
        
        UIViewController *vc = self.viewControllers[i];
        
        vc.title = titleName[i];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@-选中", titleName[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@-未选中", titleName[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        if (i == 0) {
            [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Item1_Color} forState:UIControlStateSelected];
        } else if (i == 1) {
            [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Item2_Color} forState:UIControlStateSelected];
        } else {
            [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Item3_Color} forState:UIControlStateSelected];
        }
        
    
        //设置title的偏移量:
        [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 1)];
        
    }
    
    
    
}



































@end
