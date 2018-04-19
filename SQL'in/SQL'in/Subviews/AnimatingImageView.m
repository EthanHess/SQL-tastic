//
//  AnimatingImageView.m
//  SQL'in
//
//  Created by Ethan Hess on 4/16/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "AnimatingImageView.h"

@interface AnimatingImageView ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AnimatingImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithRed:7.0f/255.0f green:107.0f/255.0f blue:128.0f/255.0f alpha:1.0]];
        
        [self configureLayer];
    
        //[self setNeedsLayout];
    }
    return self;
}

- (void)configureLayer {
    
    self.layer.masksToBounds = YES;
    self.outerLayer = [CAShapeLayer layer];
    self.outerLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.outerLayer.lineWidth = 3.0;
    self.outerLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer insertSublayer:self.outerLayer atIndex:(unsigned int)self.layer.sublayers.count];
    
    [self setUpTimer];
}

- (void)setUpTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeBorder) userInfo:nil repeats:YES];
}

- (void)dealloc {
    [self.timer invalidate];
}

- (void)changeBorder {
    
    CGFloat oneValue = arc4random_uniform(255)/255.0;
    CGFloat twoValue = arc4random_uniform(255)/255.0;
    CGFloat threeValue = arc4random_uniform(255)/255.0;
    
    self.outerLayer.strokeColor = [[self randomColorWithRed:oneValue green:twoValue blue:threeValue]CGColor];
}

//Don't call this directly, do via setNeedsLayout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateRadius:self.bounds];
}

- (void)updateRadius:(CGRect)rect {
    
    self.layer.cornerRadius = MAX(CGRectGetHeight(rect), CGRectGetWidth(rect)) / 2.0f;
    
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGRect zeroRectWithSize = { CGPointZero, rect.size };
    CGPathAddEllipseInRect(circlePath, NULL, zeroRectWithSize);
    _outerLayer.path = circlePath;
    
    CGPathRelease(circlePath);
}

- (UIColor *)randomColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
