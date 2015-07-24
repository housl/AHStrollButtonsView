//
//  ViewController.m
//  AHStrollButtonsView
//
//  Created by housl on 15/7/17.
//  Copyright (c) 2015年 housl. All rights reserved.
//

#import "ViewController.h"
#import "AHScrollButtonsView.h"

@interface ViewController ()<UIScrollViewDelegate,AHScrollButtonsViewDelegate>
@property (nonatomic, strong) AHScrollButtonsView *sbView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    float width = self.view.frame.size.width;
    self.sbView = [[AHScrollButtonsView alloc] initWithFrame:CGRectMake(0, 100, width-100, 40)];
    _sbView.backgroundColor = [UIColor grayColor];
    _sbView.delegate = self;
    _sbView.sbDelegate = self;
    [self.view addSubview:_sbView];
    
//    UIEdgeInsets inset = _sbView.contentInset;
//    inset.left = 100;
//    
//    CGPoint offset = _sbView.contentOffset;
//    offset.x = -50;
//    _sbView.contentOffset = offset;
//    _sbView.contentInset = inset;
    
    [_sbView resetButtonTitles:@[@"外观\n(200)",@"内饰",@"网友",@"座椅"] buttonWidth:60.];
//    [_sbView resetSelectedIndex:4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
static BOOL isOpen = NO;
-(void)didSelectedIndex:(NSUInteger)index
{
    isOpen = !isOpen;
 
    float width = self.view.frame.size.width;
    if (isOpen) {
        self.sbView.frame = CGRectMake(0, 200, width, 40);
        
    }else{
        self.sbView.frame = CGRectMake(0, 100, width-100, 40);
    }
    
    NSLog(@"--didSelectedIndex---");
}

@end
