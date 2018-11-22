//
//  RoseDetialController.m
//  RoseTactic
//
//  Created by 曹老师 on 2018/11/18.
//  Copyright © 2018 曹奕程. All rights reserved.
//

#import "RoseDetialController.h"
#import "SVProgressHUD.h"

@interface RoseDetialController ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;


@end

@implementation RoseDetialController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"属性";
    self.view.backgroundColor = Background_Color;
    
    
    [SVProgressHUD showWithStatus:@"加载详情中"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        _icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%lda", _row+1]];
        [SVProgressHUD dismiss];
    });
    
    
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
