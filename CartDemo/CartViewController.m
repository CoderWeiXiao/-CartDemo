//
//  CartViewController.m
//  CartDemo
//
//  Created by a on 17/3/24.
//  Copyright © 2017年 a. All rights reserved.
//


#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height

#define kEditBtnTag  100
#define kSelectedBtnTag 500

#import "CartViewController.h"
#import "CartTableViewCell.h"
#import "Shop.h"
#import "Goods.h"

@interface CartViewController ()<UITableViewDelegate,UITableViewDataSource,ClickCellBtnDeleget>

@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)UITableView* tableView;

@property(nonatomic,strong)UIButton* allSelectedBtn;
@property(nonatomic,strong)UILabel* allAmountLB;

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self modifyNaviBar];
    
    [self addFakeData];
    
    [self initTableView];
    
    [self initSettleView];
    
}

-(void)modifyNaviBar{
    
    UIButton* button=[[UIButton alloc]init];
    button.frame=CGRectMake(0, 0, 80, 30);
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(clickAllEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* editItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=editItem;
    
    self.navigationItem.title=@"购物车";
}


-(void)addFakeData{
     //假数据
    
    Shop* shop1=[Shop new];
    shop1.shop_name=@"汽车店";
    shop1.shop_id=@"1";
    shop1.goods=[NSMutableArray array];
    
    Goods* goods1=[Goods new];
    goods1.goods_name=@"汽车汽车";
    goods1.goods_id=@"1";
    goods1.goods_price=@"500";
    goods1.number=@"2";
    goods1.goods_attr=@"红色";
    goods1.goods_thumb=@"图片地址";
    [shop1.goods addObject:goods1];
    
    Goods* goods2=[Goods new];
    goods2.goods_name=@"跑车";
    goods2.goods_id=@"2";
    goods2.number=@"3";
    goods2.goods_price=@"1000";
    goods2.goods_attr=@"蓝色";
    goods2.goods_thumb=@"图片地址";
    [shop1.goods addObject:goods2];
    
    Goods* goods3=[Goods new];
    goods3.goods_name=@"摩托车";
    goods3.goods_id=@"3";
    goods3.number=@"1";
    goods3.goods_price=@"500";
    goods3.goods_attr=@"黑色";
    goods3.goods_thumb=@"图片地址";
    [shop1.goods addObject:goods3];
    
    Shop* shop2=[Shop new];
    shop2.shop_name=@"花店";
    shop2.shop_id=@"2";
    shop2.goods=[NSMutableArray array];
    
    Goods* goods4=[Goods new];
    goods4.goods_name=@"玫瑰";
    goods4.goods_id=@"4";
    goods4.goods_price=@"100";
    goods4.number=@"2";
    goods4.goods_attr=@"红色";
    goods4.goods_thumb=@"图片地址";
    [shop2.goods addObject:goods4];
    
    Shop* shop3=[Shop new];
    shop3.shop_name=@"数码3C";
    shop3.shop_id=@"3";
    shop3.goods=[NSMutableArray array];
    
    Goods* goods5=[Goods new];
    goods5.goods_name=@"iPhone 7";
    goods5.goods_id=@"5";
    goods5.goods_price=@"200";
    goods5.number=@"1";
    goods5.goods_attr=@"红色";
    goods5.goods_thumb=@"图片地址";
    [shop3.goods addObject:goods5];
    
    Goods* goods6=[Goods new];
    goods6.goods_name=@"三星";
    goods6.goods_id=@"6";
    goods6.goods_price=@"200";
    goods6.number=@"3";
    goods6.goods_attr=@"白色";
    goods6.goods_thumb=@"图片地址";
    [shop3.goods addObject:goods6];

    _dataArray=[NSMutableArray array];
    [_dataArray addObjectsFromArray:@[shop1,shop2,shop3]];
    
}

-(void)initTableView{
    
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64-40) style:UITableViewStyleGrouped];

    tableView.delegate=self;
    tableView.dataSource=self;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [tableView registerNib:[UINib nibWithNibName:@"CartTableViewCell" bundle:nil] forCellReuseIdentifier:@"GoodsCell"];
    
    _tableView=tableView;
    [self.view addSubview:_tableView];
    
}

-(void)initSettleView{
    UIView* view= [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH-40, kScreenW, 40)];
    
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    [button setImage:[UIImage imageNamed:@"灰圈.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"红圈.png"] forState:UIControlStateSelected];
    
    [button addTarget:self action:@selector(clickAllSelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    _allSelectedBtn=button;
    [view addSubview:button];
    
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+20, 10, 100, 20)];
    label.textColor=[UIColor redColor];
    label.font=[UIFont systemFontOfSize:14];
    _allAmountLB=label;
    [view addSubview:label];
    
    UIButton* settleBtn=[[UIButton alloc]init];
    settleBtn.frame=CGRectMake(kScreenW-100,5,80,30);
    [settleBtn setTitle:@"结算" forState:UIControlStateNormal];
    [settleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [settleBtn setBackgroundColor:[UIColor redColor]];
    [settleBtn addTarget:self action:@selector(clickSettleBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:settleBtn];
    
    [self.view addSubview:view];
}

#pragma mark - TableDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Shop* shop=_dataArray[section];
    return shop.goods.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CartTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"GoodsCell" forIndexPath:indexPath];
    
    Shop* shop=_dataArray[indexPath.section];
    Goods* goods=shop.goods[indexPath.row];

    cell.shop=shop;
    cell.goods=goods;
    cell.delegate=self;
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view=[UIView new];
    view.frame=CGRectMake(0, 0, kScreenW, 40);
    
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    [button setImage:[UIImage imageNamed:@"灰圈.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"红圈.png"] forState:UIControlStateSelected];
    button.tag=section+kSelectedBtnTag;
    [button addTarget:self action:@selector(clickSectionSelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+20, 10, 100, 20)];
    label.textColor=[UIColor blackColor];
    label.font=[UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    UIButton* eidtbutton=[[UIButton alloc]init];
    eidtbutton.frame=CGRectMake(kScreenW-100,5,80,30);
    [eidtbutton setTitle:@"编辑" forState:UIControlStateNormal];
    [eidtbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [eidtbutton setTitle:@"确定" forState:UIControlStateSelected];
    [eidtbutton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    eidtbutton.tag=section+kEditBtnTag;
    [eidtbutton addTarget:self action:@selector(clickSectionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:eidtbutton];
    
    Shop* shop=_dataArray[section];
    if (shop.selected) {
        button.selected=YES;
    }else{
        button.selected=NO;
    }
    
    if (shop.edit) {
        eidtbutton.selected=YES;
    }else{
        eidtbutton.selected=NO;
    }
    label.text=shop.shop_name;
    
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma clickCellBtnDelegate
-(void)clickCellBtn:(Shop *)shop goods:(Goods *)goods type:(ClickType)type{
    switch (type) {
        case ClickTypeAdd:
        {
            //加
            
            //先请求网络(此处省略)，成功后goods数量加1。 刷新tableView， 计算总价格。
            NSInteger number=[goods.number integerValue];
            number++;
            goods.number=[NSString stringWithFormat:@"%ld",number];
            [self caculateAmount];
            [_tableView reloadData];
        }
            break;
        case ClickTypeReduce:
        {
            //减,同上
            NSInteger number=[goods.number integerValue];
            number--;
            goods.number=[NSString stringWithFormat:@"%ld",number];
            [self caculateAmount];
            [_tableView reloadData];
        }
            break;
        case ClickTypeDelete:
        {
            //删除, 请求数据。注意当shop只有一个商品的时候，删除该shop
            if (shop.goods.count==1) {
                [_dataArray removeObject:shop];
            }else{
                if ([shop.goods containsObject:goods]) {
                    [shop.goods removeObject:goods];
                }
            }
            [self caculateAmount];
            [_tableView reloadData];
        }
            break;
        case ClickTypeSelect:
        {
            //选中
            goods.selected=YES;
            [self caculateAmount];
            [_tableView reloadData];
            
            //未完成逻辑： shop中全部选中，shop选中。  所有shop选中，下边总按钮选中。
        }
            break;
        case ClickTypeUnselect:
        {
            //取消选中
            goods.selected=NO;
            shop.selected=NO;
            _allSelectedBtn.selected=NO;
            
            [self caculateAmount];
            [_tableView reloadData];
        }
            break;
        default:
            break;
    }
}

//全部编辑
-(void)clickAllEditBtn:(UIButton*)btn{
    btn.selected=!btn.selected;
    for (Shop* shop in _dataArray) {
        shop.edit=btn.selected;
        for (Goods* goods in shop.goods) {
            goods.edit=shop.edit;
        }
    }
    [_tableView reloadData];
}
//全部选中
-(void)clickAllSelectedBtn:(UIButton*)btn{
    btn.selected=!btn.selected;
    for (Shop* shop in _dataArray) {
        shop.selected=btn.selected;
        for (Goods* goods in shop.goods) {
            goods.selected=shop.selected;
        }
    }
    [self caculateAmount];
    [_tableView reloadData];
}
//分区选中
-(void)clickSectionSelectedBtn:(UIButton*)btn{
    btn.selected=!btn.selected;
    Shop* shop=_dataArray[btn.tag-kSelectedBtnTag];  // 这里用tag来传递数据。
    shop.selected=btn.selected;
    for (Goods* goods in shop.goods) {
        goods.selected=shop.selected;
    }
    [self caculateAmount];
    [_tableView reloadData];
    
    //未处理逻辑： 分区选中和不选中，全选按钮是否选中。
}

//分区编辑
-(void)clickSectionEditBtn:(UIButton*)btn{
    btn.selected=!btn.selected;
    Shop* shop=_dataArray[btn.tag-kEditBtnTag];  // 这里用tag来传递数据。
    shop.edit=btn.selected;
    for (Goods* goods in shop.goods) {
        goods.edit=shop.edit;
    }
    [_tableView reloadData];
}

//结算按钮
-(void)clickSettleBtn{
    NSMutableArray* array=[NSMutableArray array];
    for (Shop* shop in _dataArray) {
        if (shop.selected) {
            [array addObject:shop];
        }else{
            
            Shop* newShop=nil;
            for (Goods* goods in shop.goods) {
                if (goods.selected) {
                    if (!newShop) {
                        newShop=[Shop new];
                        newShop.shop_name=shop.shop_name;
                        newShop.shop_id=shop.shop_id;
                        newShop.goods=[NSMutableArray array];
                    }
                    [newShop.goods addObject:goods];
                }
            }
            if (newShop) {
                [array addObject:newShop];
            }
        }
    }
    
    if (array.count==0) {
        NSLog(@"没有选择商品");
        return;
    }else{
        NSLog(@"%@",array);
    }
    
}


#pragma mark - 工具方法
-(void)caculateAmount{
    CGFloat allAmount=0.0;
    for (Shop* shop in _dataArray) {
        for (Goods* goods in shop.goods) {
            if (goods.selected) {
                allAmount+=[goods.goods_price floatValue]*[goods.number integerValue];
            }
        }
    }
    _allAmountLB.text=[NSString stringWithFormat:@"￥%.2lf",allAmount];
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
