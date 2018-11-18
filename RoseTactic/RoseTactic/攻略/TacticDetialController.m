//
//  TacticDetialController.m
//  RoseTactic
//
//  Created by 曹老师 on 2018/11/18.
//  Copyright © 2018 曹奕程. All rights reserved.
//

#import "TacticDetialController.h"

@interface TacticDetialController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation TacticDetialController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *name = [NSString stringWithFormat:@"tactic%ld", _row + 1];
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"rtfd"];
    
    if (!path) {
        return;
    }
    
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
    
    
}






@end
