//
//  TacticController.m
//  RoseTactic
//
//  Created by 曹老师 on 2018/11/18.
//  Copyright © 2018 曹奕程. All rights reserved.
//

#import "TacticController.h"
#import "TacticCell.h"
#import "TacticDetialController.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"

@interface TacticController () <UITableViewDelegate, UITableViewDataSource> {
 
    NSMutableArray *dataArray;   // 数据列表
    NSInteger currentPage;
    
}

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation TacticController

#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"攻略";
    dataArray = [NSMutableArray array];
    
   
    
    // 创建视图
    [self creatSubViewsAction];
    
    
    
}

#pragma mark ========================================私有方法=============================================

#pragma mark - 创建视图
- (void)creatSubViewsAction {
    
    // 表视图
    _listTableView.alpha = 0;
    _listTableView.backgroundColor = [UIColor clearColor];
    _listTableView.rowHeight = 80;
    _listTableView.estimatedRowHeight = 0;
    _listTableView.estimatedSectionFooterHeight = 0;
    _listTableView.estimatedSectionHeaderHeight = 0;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerNib:[UINib nibWithNibName:@"TacticCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"TacticCell"];
    [self.view addSubview:_listTableView];
    
    if(@available(iOS 11.0, *)){
        _listTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadListAction:NO];
    
    _listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadListAction:NO];
        
        [_listTableView.mj_header endRefreshing];
        
    }];
    
    
    _listTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self loadListAction:YES];
        
        [_listTableView.mj_footer endRefreshing];
    }];
    
    
}

#pragma mark ========================================动作响应=============================================


#pragma mark ========================================网络请求=============================================



#pragma mark - 获取列表
- (void)loadListAction:(BOOL)isfooter {
    
    if (isfooter) {
        currentPage ++;
    } else {
        currentPage = 1;
        [dataArray removeAllObjects];
    }
    
    [SVProgressHUD showWithStatus:@"加载数据中"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Tactic" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    NSArray *items = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    NSInteger count = dataArray.count;
    for (int i = 0; i < 5; i++) {
        
        if (dataArray.count >= 14) {
            [_listTableView.mj_footer endRefreshingWithNoMoreData];
            break;
        } else {
            [dataArray addObject:items[i+count]];
        }
        
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:.35 animations:^{
            _listTableView.alpha = 1;
        }];
        [_listTableView reloadData];
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    });
    
}


#pragma mark ========================================代理方法=============================================

#pragma mark - 表视图代理方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
    
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
    
    NSDictionary *dic = dataArray[indexPath.row];
    
    cell.label1.text = dic[@"title"];
    cell.label2.text = dic[@"from"];
    cell.icon.image = [UIImage imageNamed:dic[@"image"]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = dataArray[indexPath.row];
    TacticDetialController *ctrl = [[TacticDetialController alloc] init];
    ctrl.title = dic[@"title"];
    ctrl.content = dic[@"content"];
    [self.navigationController pushViewController:ctrl animated:YES];
    
    
    
}


#pragma mark ========================================通知================================================







































@end
