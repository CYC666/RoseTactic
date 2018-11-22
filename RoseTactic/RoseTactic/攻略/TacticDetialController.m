//
//  TacticDetialController.m
//  RoseTactic
//
//  Created by 曹老师 on 2018/11/18.
//  Copyright © 2018 曹奕程. All rights reserved.
//

#import "TacticDetialController.h"
#import "SVProgressHUD.h"

@interface TacticDetialController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation TacticDetialController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 导航栏右边的添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImage:[UIImage imageNamed:@"未收藏"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    NSString *name = [NSString stringWithFormat:@"tactic%@", _content];
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"rtfd"];
    
    if (!path) {
        return;
    }
    
    [SVProgressHUD showWithStatus:@"加载攻略详情中"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSAttributedString *string = [[NSAttributedString alloc] initWithFileURL:[NSURL fileURLWithPath:path]
                                                                         options:nil
                                                              documentAttributes:nil
                                                                           error:nil];
        
        
        
        _textView.backgroundColor = [UIColor clearColor];
        _textView.attributedText  = string;
        _textView.editable        = NO;
        _textView.selectable      = NO;
        _textView.bounces         = YES;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.showsVerticalScrollIndicator   = NO;

        [SVProgressHUD dismiss];
    });
    
    
}


#pragma mark - 收藏
- (void)collectButtonAction:(UIButton *)button {
    
    // 文件写入
    NSString *collectStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"collect"];
    if (collectStr) {
        collectStr = [NSString stringWithFormat:@"%@|%@", collectStr, _content];
    } else {
        collectStr = _content;
    }
    [[NSUserDefaults standardUserDefaults] setValue:collectStr forKey:@"collect"];
    
    [SVProgressHUD showSuccessWithStatus:@"添加收藏成功"];
    [SVProgressHUD dismissWithDelay:1.5];
    [button setImage:[UIImage imageNamed:@"已收藏"] forState:UIControlStateNormal];
    
    
}



@end
