//
//  AHScrollButtonsView.h
//  CarPrice
//
//  Created by housl on 15/7/16.
//  Copyright (c) 2015年 ATHM. All rights reserved.
//

#define AH_BUTTON_WIDTH            50.0
#define AH_BUTTON_SPACE            4.0

#import <UIKit/UIKit.h>

@protocol AHScrollButtonsViewDelegate <NSObject>

-(void)didSelectedIndex:(NSUInteger)index;

@end

/**
 *  图片页面使用可滑动的按钮组合
 */
@interface AHScrollButtonsView : UIScrollView

@property(nonatomic,assign)id<AHScrollButtonsViewDelegate> sbDelegate;

-(void)resetButtonTitles:(NSArray *)titles buttonWidth:(float)width;

-(void)resetSelectedIndex:(NSUInteger)index;

-(NSUInteger)currentIndex;

@end

