//
//  BlocksViewController.m
//  SQL'in
//
//  Created by Ethan Hess on 8/13/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

#import "BlocksViewController.h"

@interface BlocksViewController ()

//Blocks should be copy when they are properties because by default they are on the stack. Copy moves them to the heap (so you can use it later)

@property (nonatomic, copy) NSArray *(^stringArray)(NSString *);
@property (nonatomic, copy) float (^acceptStringReturnFloat)(NSString *);
@property (nonatomic, copy) void (^someBlock)(int);

@end

@implementation BlocksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)blockExamples { //If block holds a strong reference to self, cast self as weak
    
    int (^multiplyNumbers)(int, int) = ^(int one, int two) {
        int returnInt = one * two;
        return returnInt;
    };
    
    multiplyNumbers(8, 9);
}

- (void)showingOff {
    
    void (^fancyHelloWorld)() = ^{
        NSLog(@"Hello world!");
    };
    
    fancyHelloWorld();
}

- (NSArray *)shuffleArray:(NSArray *)array {
    
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:array];
    NSUInteger count = [newArray count];
    
    for (NSUInteger i = 0; i < count; i++) {
        NSInteger remaining = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t)remaining);
        [newArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    
    return newArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
