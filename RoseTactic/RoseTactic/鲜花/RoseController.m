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

@interface RoseController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *listView;


@end

@implementation RoseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"鲜花";
    self.view.backgroundColor = Background_Color;
    
    // 集合视图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth * 0.25, kScreenWidth * 0.25);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
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
    
}




#pragma mark ========================================生命周期========================================


#pragma mark ========================================动作响应=============================================


#pragma mark ========================================网络请求=============================================


#pragma mark ========================================代理方法=============================================
#pragma mark - 集合视图代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 74;
    
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RoseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoseCell" forIndexPath:indexPath];
    
    
    cell.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", indexPath.row + 1]];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    RoseDetialController *ctrl = [[RoseDetialController alloc] init];
    ctrl.row = indexPath.row;
    [self.navigationController pushViewController:ctrl animated:YES];
    
}




































@end
