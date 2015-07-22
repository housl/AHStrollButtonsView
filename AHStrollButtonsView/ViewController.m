//
//  ViewController.m
//  AHStrollButtonsView
//
//  Created by housl on 15/7/17.
//  Copyright (c) 2015年 housl. All rights reserved.
//

#import "ViewController.h"
#import "AHScrollButtonsView.h"

@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    float width = self.view.frame.size.width;
    AHScrollButtonsView *sbView = [[AHScrollButtonsView alloc] initWithFrame:CGRectMake(0, 100, width, 40)];
    sbView.backgroundColor = [UIColor grayColor];
    sbView.delegate = self;
    [self.view addSubview:sbView];
    
    UIEdgeInsets inset = sbView.contentInset;
    inset.left = 100;
    
    CGPoint offset = sbView.contentOffset;
    offset.x = -50;
    sbView.contentOffset = offset;
    sbView.contentInset = inset;
    
    [sbView resetButtonTitles:@[@"外观\n(200)",@"内饰",@"网友",@"座椅",@"挂饰",@"其他",@"评测",@"图解"] buttonWidth:60.];
//    [sbView resetSelectedIndex:4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIEdgeInsets inset =  scrollView.contentInset;
    NSLog(@"%@",NSStringFromUIEdgeInsets(inset));
    
    CGPoint point = scrollView.contentOffset;
    NSLog(@"%@",NSStringFromCGPoint(point));
    
}

@end
