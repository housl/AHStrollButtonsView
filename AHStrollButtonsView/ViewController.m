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

#import "YAGradientLayer.h"

@interface ViewController ()<UIScrollViewDelegate,AHScrollButtonsViewDelegate,YAScrollSegmentControlDelegate>
@property (nonatomic, strong) AHScrollButtonsView *sbView;

@property (nonatomic, strong)YAScrollSegmentControl *yaView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    float width = self.view.frame.size.width;
    self.sbView = [[AHScrollButtonsView alloc] initWithFrame:CGRectMake(0, 100, width, 40)];
    _sbView.backgroundColor = [UIColor grayColor];
    _sbView.delegate = self;
    [self.view addSubview:_sbView];
    
    _sbView.buttons = @[@"外观\n(200)",@"内饰",@"网友",@"座椅",@"外观\n(200)",@"内饰",@"网友",@"座椅"];
    [_sbView setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    [_sbView setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateNormal];
    [_sbView setBackgroundImage:[UIImage imageNamed:@"backgroundSelected"] forState:UIControlStateSelected];
    
    
    
    self.yaView = [[YAScrollSegmentControl alloc] initWithFrame:CGRectMake(0, 300, width, 50)];
    self.yaView.buttons = @[@"外观\n(200)",@"内饰内饰内饰",@"网友",@"座椅",@"外观\n(200)",@"内饰",@"网友",@"座椅"];
    _yaView.delegate = self;
    [_yaView setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    _yaView.gradientColor = [UIColor grayColor];
    
    _yaView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_yaView];
    
    
    YAGradientLayer *lay = [[YAGradientLayer alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 5)];
    [self.view addSubview:lay];
    lay.progress = 0.5;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        lay.progress = 0.2;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            lay.progress = 0.4;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                lay.progress = 0.6;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    lay.progress = 1.0;
                    
                });
                
            });
            
        });
        
    });
    
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
//    isOpen = !isOpen;
// 
//    float width = self.view.frame.size.width;
//    if (isOpen) {
//        self.sbView.frame = CGRectMake(0, 200, width, 40);
//        
//    }else{
//        self.sbView.frame = CGRectMake(0, 100, width-100, 40);
//    }
//    
//    NSLog(@"--didSelectedIndex---");
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
    self.yaView.frame = [self frameForTypebarAtOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    CGRect rect = self.yaView.frame;
    rect.origin.y-=100;
    self.sbView.frame = rect;
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
