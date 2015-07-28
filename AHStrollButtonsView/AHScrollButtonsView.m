//
//  AHScrollButtonsView.m
//  CarPrice
//
//  Created by housl on 15/7/16.
//  Copyright (c) 2015年 ATHM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHScrollButtonsView.h"


static const CGFloat defaultEdgeMargin = 10;
static const CGFloat defaultGradientOffset = 50;
static const CGFloat defaultGradientPercentage = 0.2;

@interface AHScrollButtonsView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *leftMask;
@property (nonatomic, strong) UIView *rightMask;

@property (nonatomic, strong) UIColor *buttonColor;
@property (nonatomic, strong) UIColor *buttonHighlightColor;
@property (nonatomic, strong) UIColor *buttonSelectedColor;

@property (nonatomic, strong) UIImage *buttonBackgroundImage;
@property (nonatomic, strong) UIImage *buttonHighlightedBackgroundImage;
@property (nonatomic, strong) UIImage *buttonSelectedBackgroundImage;

@property (nonatomic, strong) UIFont *buttonFont;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation AHScrollButtonsView

#pragma mark - init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    [self resetMaskView];
    [self updateGradientsForScrollView:self.scrollView];
    //    [self setSelectedIndex:self.selectedIndex];
    [self resetSelectedIndexNoDelegate:self.selectedIndex];
    self.backgroundColor = [UIColor colorWithPatternImage:self.buttonBackgroundImage];
    
    CGFloat maxX = 0;
    for (UIButton *button in self.scrollView.subviews) {
        if (![button isKindOfClass:[UIButton class]]) continue;
        if (CGRectGetMaxX(button.frame) > maxX) {
            maxX = CGRectGetMaxX(button.frame);
        }
    }
    
    if (maxX < self.frame.size.width) {
        self.scrollView.contentInset = UIEdgeInsetsMake(0, (self.frame.size.width - maxX) / 2, 0, 0);
    }
    
    float x = maxX;
    self.scrollView.contentSize = CGSizeMake(x, self.frame.size.height);
    
    if (x <= self.frame.size.width) {
        self.scrollView.contentInset = UIEdgeInsetsMake(0, (self.frame.size.width - x) / 2, 0, 0);
    } else {
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }
    
}

#pragma mark - 初始化view
- (void)setupView
{
    self.edgeMargin = defaultEdgeMargin;
    self.gradientScrollOffset = defaultGradientOffset;
    self.gradientPercentage = defaultGradientPercentage;
    self.gradientColor = [UIColor whiteColor];
    self.buttonColor = [UIColor blackColor];
    self.selectedIndex = 0;
    self.buttonFont = [UIFont systemFontOfSize:14];
    
    if (!self.scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        self.scrollView.tag = -1;
        [self addSubview:self.scrollView];
    }
}

- (void)resetMaskView
{
    if (self.leftMask) {
        [self.leftMask removeFromSuperview];
        self.leftMask = nil;
    }
    
    if (self.rightMask) {
        [self.rightMask removeFromSuperview];
        self.rightMask = nil;
    }
    
    self.leftMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height)];
    self.leftMask.userInteractionEnabled = NO;
    self.leftMask.backgroundColor = self.gradientColor;
    self.leftMask.alpha = 0;
    [self insertSubview:self.leftMask aboveSubview:self.scrollView];
    
    self.leftMask.layer.mask = [self gradientLayerForBounds:self.leftMask.bounds inVector:CGVectorMake(0.0, self.gradientPercentage) withColors:@[self.gradientColor, [UIColor clearColor]]];
    
    self.rightMask = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width / 2, self.frame.size.height)];
    self.rightMask.userInteractionEnabled = NO;
    self.rightMask.backgroundColor = self.gradientColor;
    self.rightMask.alpha = 0.7;
    [self insertSubview:self.rightMask aboveSubview:self.scrollView];
    
    self.rightMask.layer.mask = [self gradientLayerForBounds:self.rightMask.bounds inVector:CGVectorMake(1 - self.gradientPercentage, 1.0) withColors:@[[UIColor clearColor], self.gradientColor]];
}

#pragma mark - 颜色

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state
{
    for (UIButton *button in self.scrollView.subviews) {
        if (![button isKindOfClass:[UIButton class]]) continue;
        
        [button setBackgroundImage:image forState:state];
    }
    
    if (state == UIControlStateNormal) {
        self.buttonBackgroundImage = image;
        self.backgroundColor = [UIColor colorWithPatternImage:image];
    } else if (state == UIControlStateHighlighted) {
        self.buttonHighlightedBackgroundImage = image;
    } else if (state == UIControlStateSelected) {
        self.buttonSelectedBackgroundImage = image;
    }
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    for (UIButton *button in self.scrollView.subviews) {
        if (![button isKindOfClass:[UIButton class]]) continue;
        
        [button setTitleColor:color forState:state];
    }
    
    if (state == UIControlStateNormal) {
        self.buttonColor = color;
    } else if (state == UIControlStateHighlighted) {
        self.buttonHighlightColor = color;
    } else if (state == UIControlStateSelected) {
        self.buttonSelectedColor = color;
    }
}

- (void)setFont:(UIFont *)font
{
    for (UIButton *button in self.scrollView.subviews) {
        if (![button isKindOfClass:[UIButton class]]) continue;
        
        button.titleLabel.font = font;
    }
    
    self.buttonFont = font;
}

-(void)resetSelectedIndex:(NSUInteger)selectedIndex
{
    [self resetSelectedIndexNoDelegate:selectedIndex];
}

-(void)resetSelectedIndexNoDelegate:(NSUInteger)selectedIndex
{
    
    if ([self.scrollView viewWithTag:selectedIndex] &&
        [[self.scrollView viewWithTag:selectedIndex] isKindOfClass:[UIButton class]])
    {
        _selectedIndex = selectedIndex;
        
        UIButton *activeButton = (UIButton *)[self.scrollView viewWithTag:selectedIndex];
        
        if (1) {
            UIButton *sender = activeButton;
            
            if (sender.tag == self.selectedIndex && sender.selected) {
                [self scrollItemVisible:sender];
                
                return;
            }
            
            for (UIButton *button in self.scrollView.subviews) {
                if (![button isKindOfClass:[UIButton class]]) continue;
                button.selected = NO;
            }
            
            sender.selected = YES;
            
            //        if ([self.delegate respondsToSelector:@selector(didSelectedIndex:)]) {
            //            [self.delegate didSelectedIndex:sender.tag];
            //        }
            
            _selectedIndex = sender.tag;
            
            [self scrollItemVisible:sender];
        }
        
    }
    
}

//刷新按钮
- (void)setButtons:(NSArray *)buttons
{
    _buttons = buttons;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat x = 0;
    for (NSInteger i = 0; i < self.buttons.count; i++) {
        NSString *title = self.buttons[i];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, 20, self.frame.size.height)];
        button.titleLabel.numberOfLines = 0;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = i;
        [button setTitleColor:self.buttonColor forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
        [button sizeToFit];
        
        int sysVersion = [[[UIDevice currentDevice] systemVersion] intValue];
        BOOL isIOS7__ = sysVersion >= 7;
        
        if(!isIOS7__){
            if ([title rangeOfString:@"\n"].location != NSNotFound) {
                CGRect rect = button.frame;
                rect.size.width = rect.size.width/2;
                button.frame = rect;
            }
        }
        
        
        if (self.buttonFont) {
            button.titleLabel.font = self.buttonFont;
        }
        
        if (self.buttonHighlightColor) {
            [button setTitleColor:self.buttonHighlightColor forState:UIControlStateHighlighted];
        }
        
        if (self.buttonSelectedColor) {
            [button setTitleColor:self.buttonSelectedColor forState:UIControlStateSelected];
        }
        
        if (self.buttonBackgroundImage) {
            [button setBackgroundImage:self.buttonBackgroundImage forState:UIControlStateNormal];
        }
        if (self.buttonSelectedBackgroundImage) {
            [button setBackgroundImage:self.buttonSelectedBackgroundImage forState:UIControlStateSelected];
        }
        if (self.buttonHighlightedBackgroundImage) {
            [button setBackgroundImage:self.buttonHighlightedBackgroundImage forState:UIControlStateHighlighted];
        }
        
        button.frame = (CGRect){button.frame.origin, {button.frame.size.width + (self.edgeMargin * 2), self.frame.size.height}};
        x = CGRectGetMaxX(button.frame);
        
        [self.scrollView addSubview:button];
    }
    
    self.scrollView.contentSize = CGSizeMake(x, self.frame.size.height);
    
    if (x <= self.frame.size.width) {
        self.scrollView.contentInset = UIEdgeInsetsMake(0, (self.frame.size.width - x) / 2, 0, 0);
    } else {
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }
    
    [self updateGradientsForScrollView:self.scrollView];
    
    [self resetSelectedIndexNoDelegate:self.selectedIndex];
}

-(NSUInteger)currentIndex
{
    return self.selectedIndex;
}

#pragma mark - 按钮事件

- (void)buttonSelect:(UIButton *)sender
{
    if (sender.tag == self.selectedIndex && sender.selected) return;
    
    for (UIButton *button in self.scrollView.subviews) {
        if (![button isKindOfClass:[UIButton class]]) continue;
        button.selected = NO;
    }
    
    sender.selected = YES;
    
    _selectedIndex = sender.tag;
    [self scrollItemVisible:sender];
    
    [self performSelector:@selector(notificationDelegate:) withObject:sender afterDelay:0.0];
}

-(void)notificationDelegate:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectedIndex:)]) {
        [self.delegate didSelectedIndex:sender.tag];
    }
}

#pragma mark - scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateGradientsForScrollView:scrollView];
}

- (void)updateGradientsForScrollView:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x < self.gradientScrollOffset) {
        CGFloat alpha = scrollView.contentOffset.x / self.gradientScrollOffset;
        self.leftMask.alpha = alpha;
    } else {
        self.leftMask.alpha = 1;
    }
    
    if (scrollView.contentOffset.x + scrollView.frame.size.width > scrollView.contentSize.width - self.gradientScrollOffset) {
        CGFloat alpha = (scrollView.contentSize.width - (scrollView.contentOffset.x + scrollView.frame.size.width)) / self.gradientScrollOffset;
        self.rightMask.alpha = alpha;
    } else {
        self.rightMask.alpha = 1;
    }
}

#pragma mark - 演变色

- (CAGradientLayer *)gradientLayerForBounds:(CGRect)bounds inVector:(CGVector)vector withColors:(NSArray *)colors
{
    CAGradientLayer *mask = [CAGradientLayer layer];
    mask.locations = [NSArray arrayWithObjects:
                      [NSNumber numberWithFloat:vector.dx],
                      [NSNumber numberWithFloat:vector.dy],
                      nil];
    
    mask.colors = [NSArray arrayWithObjects:
                   (__bridge id)((UIColor *)colors.firstObject).CGColor,
                   (__bridge id)((UIColor *)colors.lastObject).CGColor,
                   nil];
    
    mask.frame = bounds;
    mask.startPoint = CGPointMake(0, 0);
    mask.endPoint = CGPointMake(1, 0);
    
    return mask;
}

- (void)scrollItemVisible:(UIButton *)item
{
    CGRect frame = item.frame;
    if (item != self.scrollView.subviews.firstObject && item != self.scrollView.subviews.lastObject) {
        CGFloat min = CGRectGetMinX(item.frame);
        CGFloat max = CGRectGetMaxX(item.frame);
        
        
        if (min < self.scrollView.contentOffset.x) {
            frame = (CGRect){{item.frame.origin.x - 25, item.frame.origin.y}, item.frame.size};
        } else if (max > self.scrollView.contentOffset.x + self.scrollView.frame.size.width) {
            frame = (CGRect){{item.frame.origin.x + 25, item.frame.origin.y}, item.frame.size};
        }
    }
    
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

@end

