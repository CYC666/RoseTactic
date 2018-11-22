//
//  MyCollectController.m
//  RoseTactic
//
//  Created by 曹老师 on 2018/11/18.
//  Copyright © 2018 曹奕程. All rights reserved.
//

#import "MyCollectController.h"
#import "TacticCell.h"
#import "TacticDetialController.h"

@interface MyCollectController () <UITableViewDelegate, UITableViewDataSource> {
    
}

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation MyCollectController

#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    _dataArray = [NSMutableArray array];
    _listTableView.alpha = 0;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Tactic" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    NSArray *items = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    // 文件写入
    NSString *collectStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"collect"];
    if (collectStr) {
        
        NSArray * list = [collectStr componentsSeparatedByString:@"|"];
        
        for (int i = 0; i < list.count; i++) {
            
            NSString *content = list[i];
            NSDictionary *dic = items[content.integerValue - 1];
            [_dataArray addObject:dic];
            
        }
        
    }

    [UIView animateWithDuration:.35 animations:^{
        _listTableView.alpha = 1;
    }];
    [_listTableView reloadData];
    
    // 创建视图
    [self creatSubViewsAction];
    
    
    
}

#pragma mark ========================================私有方法=============================================

#pragma mark - 创建视图
- (void)creatSubViewsAction {
    
    // 表视图
    _listTableView.backgroundColor = [UIColor clearColor];
    _listTableView.rowHeight = 80;
    _listTableView.estimatedRowHeight = 0;
    _listTableView.estimatedSectionFooterHeight = 0;
    _listTableView.estimatedSectionHeaderHeight = 0;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.alwaysBounceVertical = YES;
    [_listTableView registerNib:[UINib nibWithNibName:@"TacticCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"TacticCell"];
    [self.view addSubview:_listTableView];
    
    if(@available(iOS 11.0, *)){
        _listTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

#pragma mark ========================================动作响应=============================================


#pragma mark ========================================网络请求=============================================

#pragma mark ========================================代理方法=============================================

#pragma mark - 表视图代理方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TacticCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TacticCell"
                                                       forIndexPath:indexPath];
    
    NSDictionary *dic = _dataArray[indexPath.row];
    
    cell.label1.text = dic[@"title"];
    cell.label2.text = dic[@"from"];
    cell.icon.image = [UIImage imageNamed:dic[@"image"]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = _dataArray[indexPath.row];
    TacticDetialController *ctrl = [[TacticDetialController alloc] init];
    ctrl.title = dic[@"title"];
    ctrl.content = dic[@"content"];
    [self.navigationController pushViewController:ctrl animated:YES];
    
    
    
}


#pragma mark ========================================通知================================================










@end
