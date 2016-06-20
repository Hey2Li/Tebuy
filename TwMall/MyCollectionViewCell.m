//
//  MyCollectionViewCell.m
//  TwMall
//
//  Created by TaiHuiTao on 16/6/15.
//  Copyright © 2016年 TaiHuiTao. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
    }
    return self;
}
- (void)creatSubView{
    self.imageView = [UIImageView new];
    self.imageView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-50);
    }];
    
    UILabel *detailLabel = [UILabel new];
    detailLabel.textColor = [UIColor blackColor];
    detailLabel.text = @"商品名称";
    [self addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_left);
        make.right.equalTo(self.imageView.mas_right);
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    self.label = detailLabel;
}
@end
