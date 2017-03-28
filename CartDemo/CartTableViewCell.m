//
//  CartTableViewCell.m
//  CartDemo
//
//  Created by a on 17/3/24.
//  Copyright © 2017年 a. All rights reserved.
//

#import "CartTableViewCell.h"

@interface CartTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbIV;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;

@property (weak, nonatomic) IBOutlet UIView *goodsView;

@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *firstAttrLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;

@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UILabel *secaAttrLB;


@end

@implementation CartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setGoods:(Goods *)goods{
    _goods=goods;
    
    _thumbIV.image=[UIImage imageNamed:@"goods_thumb.png"];
    _nameLB.text=goods.goods_name;
    _firstAttrLB.text=goods.goods_attr;
    _secaAttrLB.text=goods.goods_attr;
    _priceLB.text=goods.goods_price;
    _numberLB.text=goods.number;
    _numberTF.text=goods.number;
    
    if (goods.edit) {
        _editView.hidden=NO;
        _goodsView.hidden=YES;
    }else{
        _editView.hidden=YES;
        _goodsView.hidden=NO;
    }
    
    if(goods.selected){
        _selectedBtn.selected=YES;
    }else{
        _selectedBtn.selected=NO;
    }
    
}

- (IBAction)clickReduceBtn:(UIButton*)sender {
    sender.selected=!sender.selected;
    if ([_goods.number integerValue]==1) {
        return;
    }
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(clickCellBtn:goods:type:)]) {
        [self.delegate clickCellBtn: _shop goods:_goods type:ClickTypeReduce];
    }
}

- (IBAction)clickAddBtn:(UIButton*)sender {
    sender.selected=!sender.selected;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(clickCellBtn:goods:type:)]) {
        [self.delegate clickCellBtn: _shop goods:_goods type:ClickTypeAdd];
    }
}

- (IBAction)clickDeleteBtn:(UIButton*)sender {
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(clickCellBtn:goods:type:)]) {
        [self.delegate clickCellBtn: _shop goods:_goods type:ClickTypeDelete];
    }
}

- (IBAction)clickSelectBtn:(UIButton*)sender {
    sender.selected=!sender.selected;
    if (sender.selected) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(clickCellBtn:goods:type:)]) {
            [self.delegate clickCellBtn: _shop goods:_goods type:ClickTypeSelect];
        }
    }else{
        if (self.delegate&&[self.delegate respondsToSelector:@selector(clickCellBtn:goods:type:)]) {
            [self.delegate clickCellBtn: _shop goods:_goods type:ClickTypeUnselect];
        }
    }
   
}
@end
