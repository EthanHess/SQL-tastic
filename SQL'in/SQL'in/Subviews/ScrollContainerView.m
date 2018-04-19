//
//  ScrollContainerView.m
//  SQL'in
//
//  Created by Ethan Hess on 8/23/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

#import "ScrollContainerView.h"

@interface ScrollContainerView ()

@end

@implementation ScrollContainerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.labelArray = [[NSMutableArray alloc]init];
        self.viewArray = [[NSMutableArray alloc]init];
    }
    
    return self;
}

//Observe and remove observer when no longer needed

- (void)observe {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationWrapper:) name:@"viewTapped" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)notificationWrapper:(NSNotification *)notification {
    
    NSString *index = notification.userInfo[@"index"];
    [self labelSelectedAtIndex:index];
}

- (void)viewTapped:(UITapGestureRecognizer *)sender {
    [self.delegate scrollIndexSelected:sender.view.tag];
}

- (void)cleanScrollView {
    for (UIView *theView in [self.scrollView subviews]) {
        [theView removeFromSuperview];
    }
}

//Todo, use animating image view

- (void)setUpScrollViewWithArray:(NSArray *)array {
    
    if (self.scrollView == nil) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width * 2, self.frame.size.height);
        [self addSubview:self.scrollView];
    }
    
    [self cleanScrollView];
    
    int X = 0;
    
    for (int i = 0; i < array.count - 1; i ++) {
        
        float dimension = self.frame.size.height - 10;
        
        UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(X, 5, dimension, dimension)];
        containerView.tag = i;
        containerView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *theTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
        [containerView addGestureRecognizer:theTap];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, dimension - 10, dimension - 10)];
        imageView.layer.cornerRadius = imageView.frame.size.width / 2;
        imageView.layer.borderColor = [[UIColor darkGrayColor]CGColor];
        imageView.layer.borderWidth = 1;
        imageView.layer.masksToBounds = YES;
        imageView.backgroundColor = [self colorArray][i];
        
        UILabel *theLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, dimension - 10, dimension, 10)];
        theLabel.text = [self textArray][i];
        
        [containerView addSubview:imageView];
        [containerView addSubview:theLabel];
        
        [self.scrollView addSubview:containerView];
        
        //Increment x to populate scroll view horizontally
        
        X = X + dimension;
    }
}

//Just to test UI, although UIColors are not the best looking

- (NSArray *)colorArray {
    return @[[UIColor redColor], [UIColor blueColor], [UIColor greenColor], [UIColor yellowColor], [UIColor blackColor]];
}

- (NSArray *)textArray {
    return @[@"One", @"Two", @"Three", @"Four", @"Five"];
}

- (void)labelSelectedAtIndex:(NSString *)index {
    
    NSInteger value = [index integerValue];
    
    NSLog(@"SELECTED INDEX %ld", (long)index);
    
    for (UIView *theView in self.viewArray) {
        if (theView.tag == value) {
            theView.hidden = NO;
        } else {
            theView.hidden = YES;
        }
    }
    
    for (UILabel *theLabel in self.labelArray) {
        if (theLabel.tag == value) {
            theLabel.textColor = [UIColor whiteColor];
        } else {
            theLabel.textColor = [UIColor lightGrayColor];
        }
    }
}

@end
