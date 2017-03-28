//
//  Shop.h
//  CartDemo
//
//  Created by a on 17/3/24.
//  Copyright © 2017年 a. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Goods.h"

@interface Shop : NSObject
@property(nonatomic,copy)NSString* shop_name;
@property(nonatomic,copy)NSString* shop_id;
@property(nonatomic,strong)NSMutableArray* goods;

@property(nonatomic,assign)BOOL selected;  //自定义属性，判断是否选中。
@property(nonatomic,assign)BOOL edit;  //自定义属性，判断是否编辑。

@end
