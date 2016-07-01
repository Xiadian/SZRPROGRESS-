//
//  ViewController.m
//  SZRHUD
//
//  Created by XiaDian on 16/6/21.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "ViewController.h"
#import "SZRHUD.h"

@interface ViewController ()
@property(nonatomic,strong)SZRHUD*dd;
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)btn:(id)sender {
    [_dd removeFromSuperview];
    _dd=[[SZRHUD alloc]init];
    _dd.frame=CGRectMake(100, 100, 200, 200);
    _dd.endProgress=0.85;
    [self.view addSubview:_dd];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
