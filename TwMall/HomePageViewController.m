//
//  HomePageViewController.m
//  TwMall
//
//  Created by TaiHuiTao on 16/6/13.
//  Copyright © 2016年 TaiHuiTao. All rights reserved.
//

#import "HomePageViewController.h"
#import "UIView+Toast.h"
#import "MyCollectionViewCell.h"
#import "LTHttpManager.h"

@interface HomePageViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableDictionary *mutableDic;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, assign) CGFloat topViewHeight;
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HomePageViewController
@synthesize imageView;
@synthesize myTableView;
@synthesize myCollectionView;

- (NSMutableDictionary *)mutableDic{
    if (!_mutableDic) {
        _mutableDic = [NSMutableDictionary dictionary];
    }
    return _mutableDic;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"台汇淘";
    [self initWithView];
    //[self loadData];
    [self initWithNavi];
}

- (void)initWithNavi{
}
- (void)loadData{
    [LTHttpManager testHttpPost:^(LTHttpResult result, NSString *message, id data) {
        if (result == LTHttpResultSuccess) {
            self.mutableDic = [NSMutableDictionary dictionaryWithDictionary:data];
            [self.view makeToast:self.mutableDic[@"error_msg"]];
            [imageView sd_setImageWithURL:self.mutableDic[@"1indexPhoto"] placeholderImage:[UIImage imageNamed:@"newhome"]];
            [myTableView reloadData];
        }else{
            [self.view makeToast:message];
        }
    }];
    [LTHttpManager GetTestRequest:^(LTHttpResult result, NSString *message, id data) {
        if (result == LTHttpResultSuccess) {
            [self.dataArray addObjectsFromArray:data[@"data"]];
            [myCollectionView reloadData];
        }else{
            [self.view makeToast:message];
        }
    }];
}
- (void)initWithView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 130);
    
    myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:layout];
    myCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myCollectionView];
//    [myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.top.equalTo(self.view.mas_top);
//        make.bottom.equalTo(self.view.mas_bottom);
//    }];
    myCollectionView.delegate = self;
    myCollectionView.dataSource = self;
    [myCollectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"CEll"];
    [myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
//    myTableView = [UITableView new];
//    [self.view addSubview:myTableView];
//    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.top.equalTo(self.view.mas_top);
//        make.bottom.equalTo(self.view.mas_bottom);
//    }];
//    myTableView.delegate = self;
//    myTableView.dataSource = self;
//    
//    _topViewHeight = SCREEN_HEIGHT/2;
//    imageView = [[UIImageView new]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _topViewHeight)];;
//    myTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
//    [myTableView.tableHeaderView addSubview:imageView];
}
#pragma mark -- CollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = [myCollectionView dequeueReusableCellWithReuseIdentifier:@"CEll" forIndexPath:indexPath];
    if (self.dataArray.count > 0) {
        [cell.imageView sd_setImageWithURL:self.dataArray[indexPath.row][@"images"]];
        cell.label.text = self.dataArray[indexPath.row][@"name"];
    }
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(100, SCREEN_WIDTH/3);
//}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 50;
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        if (!reusableView) {
            reusableView = [[UICollectionReusableView alloc]init];
        }
        reusableView.backgroundColor = [UIColor blueColor];
        return reusableView;
        
    }
    
    UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
    if (!footView) {
        footView = [UICollectionReusableView new];
        footView.backgroundColor = [UIColor greenColor];
    };
    return footView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 100);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        CGFloat newHeight = ABS((offsetY)-_topViewHeight);
        CGFloat scale = newHeight/_topViewHeight;
        CGFloat newWidth = SCREEN_WIDTH * scale;
        imageView.frame = CGRectMake((SCREEN_WIDTH - newWidth)/2, offsetY, newWidth, newHeight);
    }
}
#pragma mark -- tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
