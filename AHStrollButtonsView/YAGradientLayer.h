//
//  YAGradientLayer.h
//  YAScrollSegmentControl
//
//  Created by housl on 15/7/27.
//  Copyright (c) 2015年 jimmy. All rights reserved.
//

//参考：
//http://www.cocoachina.com/industry/20140705/9039.html

#import <UIKit/UIKit.h>

@interface YAGradientLayer : UIView
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, assign) CGFloat progress;
@end
