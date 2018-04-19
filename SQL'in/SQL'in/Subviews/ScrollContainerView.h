//
//  ScrollContainerView.h
//  SQL'in
//
//  Created by Ethan Hess on 8/23/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollContainerDelegate <NSObject>

@required
- (void)scrollIndexSelected:(NSInteger)index;
@end

@interface ScrollContainerView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, strong) NSMutableArray *labelArray;

@property (weak, nonatomic) id <ScrollContainerDelegate> delegate;

- (void)setUpScrollViewWithArray:(NSArray *)array;

@end
