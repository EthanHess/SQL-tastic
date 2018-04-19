//
//  NetworkingViewController.m
//  SQL'in
//
//  Created by Ethan Hess on 3/3/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "NetworkingViewController.h"

@interface NetworkingViewController ()

@end

@implementation NetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)operationQueues {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    NSOperation *operationOne = [[NSOperation alloc]init];
    [operationOne setCompletionBlock:^{
        NSLog(@"Op one!");
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"Operation Queue Fun!");
    }];
    
    NSInvocationOperation *ivOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocation) object:nil];
    
    NSInvocationOperation *ivOperationTwo = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationEnd) object:nil];
    
    NSBlockOperation *blockOp = [NSBlockOperation blockOperationWithBlock:^{
        
    }];
    
    [queue addOperation:operationOne];
    [queue addOperation:ivOperation];
    [queue addOperation:ivOperationTwo];
    [queue addOperation:blockOp];
}

- (void)invocation {
    
}

- (void)invocationEnd {
    
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
