//
//  ViewController.m
//  CartDemo
//
//  Created by a on 17/3/24.
//  Copyright © 2017年 a. All rights reserved.
//

#import "ViewController.h"
#import "CartViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)clickBtn:(id)sender {
    CartViewController* vc=[CartViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
