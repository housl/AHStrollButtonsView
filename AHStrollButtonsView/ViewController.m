//
//  ViewController.m
//  AHStrollButtonsView
//
//  Created by housl on 15/7/17.
//  Copyright (c) 2015年 housl. All rights reserved.
//

#import "ViewController.h"
#import "AHScrollButtonsView.h"
#import "YAScrollSegmentControl.h"

@interface ViewController ()<UIScrollViewDelegate,AHScrollButtonsViewDelegate,YAScrollSegmentControlDelegate>
@property (nonatomic, strong) AHScrollButtonsView *sbView;

@property (nonatomic, strong)YAScrollSegmentControl *yaView;

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

    
    self.yaView = [[YAScrollSegmentControl alloc] initWithFrame:CGRectMake(0, 300, width, 50)];
    self.yaView.buttons = @[@"外观\n(200)",@"内饰",@"网友",@"座椅",@"外观\n(200)",@"内饰",@"网友",@"座椅"];
    _yaView.delegate = self;
    _yaView.buttonHighlightColor = [UIColor redColor];
    _yaView.buttonSelectedColor = [UIColor redColor];
    _yaView.gradientColor = [UIColor grayColor];
    [_yaView setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
//    [_yaView setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateNormal];
//    [_yaView setBackgroundImage:[UIImage imageNamed:@"backgroundSelected"] forState:UIControlStateSelected];
    
    _yaView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_yaView];
    
    
    
    
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


- (void)didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"Button selected at index: %lu", (long)index);
}



#pragma mark - Layout
- (void)viewWillLayoutSubviews {
    
    // Super
    [super viewWillLayoutSubviews];
    
    [self layoutVisiblePages];
}

- (void)layoutVisiblePages {
    self.yaView.frame = [self frameForTypebarAtOrientation:self.interfaceOrientation];
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

- (CGRect)frameForTypebarAtOrientation:(UIInterfaceOrientation)orientation
{
    CGSize size = self.view.bounds.size;
    CGFloat y = size.height - 40;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone &&
        UIInterfaceOrientationIsLandscape(orientation))
    {

    }

    
    if((orientation == UIDeviceOrientationLandscapeRight) || (orientation == UIDeviceOrientationLandscapeLeft)){
    
        return CGRectMake(0, 200, size.width, 50);
    }else if(orientation == UIDeviceOrientationPortrait){
        return CGRectMake(0, 300, size.width, 50);
    }
    
    
    return CGRectIntegral(CGRectMake(0, y, self.view.bounds.size.width, 40));
}

@end
