//
//  SettingController.m
//  RoseTactic
//
//  Created by 曹老师 on 2018/11/18.
//  Copyright © 2018 曹奕程. All rights reserved.
//

#import "SettingController.h"
#import "MyCollectController.h"
#import <AVFoundation/AVFoundation.h>


@interface SettingController () <AVAudioPlayerDelegate>

@property (strong, nonatomic) AVAudioPlayer *player;
@property (assign, nonatomic) BOOL isPlay;  // 是否正在播放音乐
@property (weak, nonatomic) IBOutlet UISlider *slider;  // 调节音量


@property (weak, nonatomic) IBOutlet UIButton *button1; // 我的收藏


@property (weak, nonatomic) IBOutlet UIButton *button2; // 清空缓存
@property (weak, nonatomic) IBOutlet UILabel *label2;


@property (weak, nonatomic) IBOutlet UIButton *button3; // 当前版本
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UIButton *button4; // 点赞



@end

@implementation SettingController


#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    _slider.alpha = 0;
    
    
}

- (AVAudioPlayer *)player {
    
    if (!_player) {
        
        NSString *urlPath = [[NSBundle mainBundle] pathForResource:@"bgm" ofType:@"mp3"];
        NSURL *url = [NSURL URLWithString:urlPath];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        _player.delegate = self;
        _player.volume = 0.3;
        [_player prepareToPlay];
    }
    return _player;
    
}


#pragma mark ========================================动作响应=============================================

- (IBAction)musicSwitch:(id)sender {
    
    _isPlay = !_isPlay;
    
    if (_isPlay) {
        
        [self.player play];
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:.35 animations:^{
            weakSelf.slider.alpha = 1;
        }];
        
    } else {
        
        [self.player pause];
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:.35 animations:^{
            weakSelf.slider.alpha = 0;
        }];
        
    }
    
}

- (IBAction)slider:(id)sender {
    
    self.player.volume = _slider.value;
    
}


- (IBAction)button1:(id)sender {
    
    MyCollectController *ctrl = [[MyCollectController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}
- (IBAction)button2:(id)sender {
    
    // 弹框提示是否执行
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"已经清除1.2MB缓存"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(self) weakSelf = self;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                
                                                weakSelf.label2.text = @"0.0 MB";
                                                
                                            }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)button3:(id)sender {
    
    // 弹框提示是否执行
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"当前版本已经是最新版本"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                
                                                
                                                
                                            }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)button4:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/CYC666"] options:nil completionHandler:nil];
}

#pragma mark ========================================网络请求=============================================


#pragma mark ========================================代理方法=============================================

#pragma mark - 播放结束
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    // 循环播放
    [player play];
    
    
}




































@end
