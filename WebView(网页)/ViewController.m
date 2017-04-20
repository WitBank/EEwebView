//
//  ViewController.m
//  WebView(网页)
//
//  Created by Easy on 2017/3/23.
//  Copyright © 2017年 Easy. All rights reserved.
//

#import "ViewController.h"

#import "RootWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeContactAdd];
    bt.center = self.view.center;
    [self.view addSubview:bt];
    
    [bt addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick{
    [self.navigationController pushViewController:[[RootWebViewController alloc] init] animated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
