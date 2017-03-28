//
//  Goods.h
//  CartDemo
//
//  Created by a on 17/3/24.
//  Copyright © 2017年 a. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject

@property(nonatomic,copy)NSString* goods_id;
@property(nonatomic,copy)NSString* goods_thumb;
@property(nonatomic,copy)NSString* goods_name;
@property(nonatomic,copy)NSString* goods_attr;
@property(nonatomic,copy)NSString* goods_price;
@property(nonatomic,copy)NSString* number;

@property(nonatomic,assign)BOOL selected;  //自定义属性，判断是否选中。
@property(nonatomic,assign)BOOL edit;  //自定义属性，判断是否编辑。


@end
