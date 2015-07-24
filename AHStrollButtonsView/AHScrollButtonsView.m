//
//  AHScrollButtonsView.m
//  CarPrice
//
//  Created by housl on 15/7/16.
//  Copyright (c) 2015年 ATHM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHScrollButtonsView.h"

@interface AHScrollButtonsView ()

@property(assign, nonatomic)NSInteger buttonNumber;
@property(assign, nonatomic)NSInteger currentButtonIndex;
@property(assign, nonatomic)CGFloat buttonWidth;
@property(assign, nonatomic)CGFloat buttonHeight;
@property(assign, nonatomic)CGFloat buttonSpace;
@property (nonatomic, strong) NSMutableArray   *buttonTitles;
@property (nonatomic, assign) NSUInteger    selectedIndex;

@property (nonatomic, strong) UIColor   *sColor;
@property (nonatomic, strong) UIColor   *nColor;

@end

@implementation AHScrollButtonsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.buttonHeight = frame.size.height;
        self.buttonWidth = AH_BUTTON_WIDTH;
        self.buttonSpace = AH_BUTTON_SPACE;
        self.buttonTitles = [[NSMutableArray alloc] initWithCapacity:5];
        
        self.nColor = [UIColor blackColor];
        self.sColor = [UIColor colorWithRed:235/255.0 green:97/255.0 blue:0/255.0 alpha:1.0];
        
        [self setShowsHorizontalScrollIndicator:NO];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(void)resetScrollView
{
    for (UIView *one in self.subviews) {
        [one removeFromSuperview];
    }
}

-(void)resetSelectedIndex:(NSUInteger)index
{
    self.selectedIndex = index;
    [self moveToButtonWithIndex:index];
    
    for (UIView *one in self.subviews) {
        if ([one isKindOfClass:[UIButton class]]) {
            UIButton *abtn = (UIButton *)one;
            [abtn setTitleColor:_nColor forState:UIControlStateNormal];
        }
    }
    
    UIButton *seleBtn = (UIButton *) [self viewWithTag:self.selectedIndex+10000];
    if (seleBtn) {
        [seleBtn setTitleColor:_sColor
                      forState:UIControlStateNormal];
    }
}

-(NSUInteger)currentIndex
{
    return self.selectedIndex;
}

-(void)moveToButtonWithIndex:(NSUInteger)butInedex
{
    return;
    NSUInteger tmp = butInedex > 0 ? butInedex : 0;
    tmp = tmp > self.buttonNumber ? self.buttonNumber : tmp;
    float xx = self.frame.size.width * tmp* ((self.buttonWidth+_buttonSpace) / self.frame.size.width) - self.buttonWidth;
    [self scrollRectToVisible:CGRectMake(xx, 0, self.frame.size.width, self.frame.size.height) animated:YES];
}

-(void)resetButtonTitles:(NSArray *)titles buttonWidth:(float)width
{
    
    
    if (!titles || titles.count == 0) {
        return;
    }
    
    if (width <= 0.0) {
        width = 60;
    }
    
    [self resetScrollView];
    self.buttonWidth = width;
    
    [self.buttonTitles removeAllObjects];
    [self.buttonTitles addObjectsFromArray:titles];
    
    self.buttonNumber = titles.count;
    
    BOOL isFull = YES;
    float gapWidth = 0.0;
    
    CGFloat contentWidth = self.buttonNumber * (self.buttonWidth + _buttonSpace) - _buttonSpace;
    if (contentWidth <= self.frame.size.width) {
        gapWidth = (self.frame.size.width - contentWidth)/2;
        isFull = NO;
        contentWidth = self.frame.size.width;
        
    }
    
    [self setContentSize:CGSizeMake(contentWidth+1, self.frame.size.height)];
    
    for (int i = 0; i < self.buttonNumber; ++i) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but addTarget:self action:@selector(buttonDownHandle:) forControlEvents:UIControlEventTouchUpInside];
        but.tag = i + 10000;
        CGFloat x = i * (self.buttonWidth + _buttonSpace);
        [but setFrame:CGRectMake(x + gapWidth, 0, self.buttonWidth, _buttonHeight)];
        but.titleLabel.numberOfLines = 0;
        but.titleLabel.textAlignment = NSTextAlignmentCenter;
        but.titleLabel.font = [UIFont systemFontOfSize:13];
        if(i == self.selectedIndex){
            [but setTitleColor:_sColor
                      forState:UIControlStateNormal];
        }else{
            [but setTitleColor:_nColor forState:UIControlStateNormal];
        }
        [but setBackgroundColor:[UIColor clearColor]];
        NSString *name = [NSString stringWithFormat:@"%@", self.buttonTitles[i]];
        [but setTitle:name
             forState:UIControlStateNormal];
        [self addSubview:but];
    }
}

-(void)buttonDownHandle:(UIButton *)sender
{
    
    UIButton *lastbtn = (UIButton *) [self viewWithTag:self.selectedIndex+10000];
    if (lastbtn) {
        [lastbtn setTitleColor:_nColor forState:UIControlStateNormal];
    }
    [sender setTitleColor:_sColor
                 forState:UIControlStateNormal];
    self.selectedIndex = sender.tag - 10000;
    [self moveToButtonWithIndex:self.selectedIndex];
    
    if ([self.sbDelegate respondsToSelector:@selector(didSelectedIndex:)]) {
        [self.sbDelegate didSelectedIndex:self.selectedIndex];
    }
}

-(void)resetSelectedColor:(UIColor *)scolor normalColor:(UIColor *)ncolor
{
    self.sColor = scolor;
    self.nColor = ncolor;
    
    for (UIView *one in self.subviews) {
        if ([one isKindOfClass:[UIButton class]]) {
            UIButton *abtn = (UIButton *)one;
            [abtn setTitleColor:_nColor forState:UIControlStateNormal];
        }
    }
    
    UIButton *seleBtn = (UIButton *) [self viewWithTag:self.selectedIndex+10000];
    if (seleBtn) {
        [seleBtn setTitleColor:_sColor
                      forState:UIControlStateNormal];
    }
    
    
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:self.buttonTitles.count];
    for (NSString *str in self.buttonTitles) {
        [arr addObject:str];
    }
    
    [self resetButtonTitles:arr buttonWidth:self.buttonWidth];
    
}



@end