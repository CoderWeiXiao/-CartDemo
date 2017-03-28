//
//  CartTableViewCell.h
//  CartDemo
//
//  Created by a on 17/3/24.
//  Copyright © 2017年 a. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"
#import "Shop.h"

typedef enum{
    ClickTypeSelect,  //选中
    ClickTypeUnselect,  //取消选中
    ClickTypeAdd,      //加
    ClickTypeReduce,   //减
    ClickTypeDelete,    //删除
}ClickType;


@protocol ClickCellBtnDeleget <NSObject>
-(void)clickCellBtn:(Shop*)shop goods:(Goods*)goods type:(ClickType)type;
@end

@interface CartTableViewCell : UITableViewCell
@property(nonatomic,strong)Goods* goods;
@property(nonatomic,strong)Shop* shop;

@property(nonatomic,weak)id<ClickCellBtnDeleget> delegate;
@end
