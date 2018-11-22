//
//  RoseController.m
//  RoseTactic
//
//  Created by 曹老师 on 2018/11/18.
//  Copyright © 2018 曹奕程. All rights reserved.
//

#import "RoseController.h"
#import "RoseCell.h"
#import "RoseDetialController.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"

@interface RoseController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    
    NSMutableArray *dataArray;   // 数据列表
    NSInteger currentPage;
    
}

@property (weak, nonatomic) IBOutlet UICollectionView *listView;


@end

@implementation RoseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"鲜花";
    self.view.backgroundColor = Background_Color;
    dataArray = [NSMutableArray array];
    
    // 集合视图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth * 0.25, kScreenWidth * 0.25);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _listView.alpha = 0;
    _listView.collectionViewLayout = layout;
    _listView.backgroundColor = [UIColor clearColor];
    [_listView registerNib:[UINib nibWithNibName:@"RoseCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"RoseCell"];
    _listView.delegate = self;
    _listView.dataSource = self;
    
    
    if(@available(iOS 11.0, *)){
        _listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadListAction:NO];
    
    _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadListAction:NO];
        
        [_listView.mj_header endRefreshing];
        
    }];
    
    
    _listView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self loadListAction:YES];
        
        [_listView.mj_footer endRefreshing];
    }];
    
}




#pragma mark ========================================生命周期========================================


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
    
    NSInteger count = dataArray.count;
    for (int i = 0; i < 10; i++) {
        
        if (dataArray.count >= 74) {
            [_listView.mj_footer endRefreshingWithNoMoreData];
            break;
        } else {
            [dataArray addObject:[NSString stringWithFormat:@"%ld", i+1+count]];
        }
        
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:.35 animations:^{
            _listView.alpha = 1;
        }];
        [_listView reloadData];
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    });
    
}

#pragma mark ========================================代理方法=============================================
#pragma mark - 集合视图代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
//    return 74;
    return dataArray.count;
    
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RoseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoseCell" forIndexPath:indexPath];
    
    
    cell.icon.image = [UIImage imageNamed:dataArray[indexPath.row]];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    RoseDetialController *ctrl = [[RoseDetialController alloc] init];
    ctrl.row = indexPath.row;
    [self.navigationController pushViewController:ctrl animated:YES];
    
}




































@end
