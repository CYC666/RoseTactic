//
//  RoseDetialController.m
//  RoseTactic
//
//  Created by 曹老师 on 2018/11/18.
//  Copyright © 2018 曹奕程. All rights reserved.
//

#import "RoseDetialController.h"

@interface RoseDetialController ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;


@end

@implementation RoseDetialController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"属性";
    self.view.backgroundColor = Background_Color;
    
    _icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%lda", _row+1]];
    
    
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
