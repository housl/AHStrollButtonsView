//
//  ViewController.m
//  AHStrollButtonsView
//
//  Created by housl on 15/7/17.
//  Copyright (c) 2015年 housl. All rights reserved.
//

#import "ViewController.h"
#import "AHScrollButtonsView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    float width = self.view.frame.size.width;
    AHScrollButtonsView *sbView = [[AHScrollButtonsView alloc] initWithFrame:CGRectMake(0, 100, width, 40)];
    sbView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sbView];
    
    [sbView resetButtonTitles:@[@"外观\n(200)",@"内饰",@"网友",@"座椅",@"挂饰",@"其他",@"评测",@"图解"] buttonWidth:60.];
    [sbView resetSelectedIndex:4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
