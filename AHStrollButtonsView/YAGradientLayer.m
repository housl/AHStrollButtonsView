//
//  YAGradientLayer.m
//  YAScrollSegmentControl
//
//  Created by housl on 15/7/27.
//  Copyright (c) 2015年 jimmy. All rights reserved.
//

#import "YAGradientLayer.h"

@implementation YAGradientLayer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CAGradientLayer *layer = (id)[self layer];
        [layer setStartPoint:CGPointMake(0.0, 0.5)];
        [layer setEndPoint:CGPointMake(1.0, 0.5)];
        
        
        NSMutableArray *colors = [NSMutableArray array];
        for (NSInteger hue = 0; hue <= 360; hue += 5) {
            
            UIColor *color;
            color = [UIColor colorWithHue:1.0 * hue / 360.0
                               saturation:1.0
                               brightness:1.0
                                    alpha:1.0];
            [colors addObject:(id)[color CGColor]]; 
        } 
        [layer setColors:[NSArray arrayWithArray:colors]];
        
        
        self.maskLayer = [CALayer layer];
        [self.maskLayer setFrame:CGRectMake(0, 0, 0, frame.size.height)];
        [self.maskLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
        [layer setMask:self.maskLayer];
        
        [self performAnimation];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (Class)layerClass {
    return [CAGradientLayer class];
}


- (void)performAnimation {
    
    
    CAGradientLayer *layer = (id)[self layer];
    NSMutableArray *mutable = [[layer colors] mutableCopy];
    id lastColor = [mutable lastObject];
    [mutable removeLastObject];
    [mutable insertObject:lastColor atIndex:0];

    NSArray *shiftedColors = [NSArray arrayWithArray:mutable];

    
    
    [layer setColors:shiftedColors];
    
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setToValue:shiftedColors];
    [animation setDuration:0.08];
    [animation setRemovedOnCompletion:YES];
    [animation setFillMode:kCAFillModeForwards];
    [animation setDelegate:self];
    [layer addAnimation:animation forKey:@"animateGradient"];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    [self performAnimation];
}


- (void)setProgress:(CGFloat)value {
    if (_progress != value) {
        
        _progress = MIN(1.0, fabs(value));
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    
    CGRect maskRect = [self.maskLayer frame];
    maskRect.size.width = CGRectGetWidth([self bounds]) * self.progress;
    [self.maskLayer setFrame:maskRect];
}
@end
