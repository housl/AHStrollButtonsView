//
//  AHScrollButtonsView.h
//  CarPrice
//
//  Created by housl on 15/7/16.
//  Copyright (c) 2015年 ATHM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AHScrollButtonsViewDelegate <NSObject>

@required
- (void)didSelectedIndex:(NSInteger)index;

@end


@interface AHScrollButtonsView : UIControl

@property (nonatomic, strong) NSArray *buttons;

@property (nonatomic, assign)  CGFloat edgeMargin;
@property (nonatomic, assign)  CGFloat gradientScrollOffset;
@property (nonatomic, assign)  CGFloat gradientPercentage;
@property (nonatomic, strong)  UIColor *gradientColor;



@property (nonatomic, assign) id <AHScrollButtonsViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;
/**
 *  设置颜色
 *
 *  @param color
 *  @param state
 */
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state;
- (void)setFont:(UIFont *)font;     

//获取当前选中的index
-(NSUInteger)currentIndex;

//重新设置index
-(void)resetSelectedIndex:(NSUInteger)index;

@end
