//
//  AlgorithmViewController.m
//  SQL'in
//
//  Created by Ethan Hess on 3/6/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "AlgorithmViewController.h"
#import "Miscellaneous.h"
#import "GraphNode.h"

typedef void (^CompletionBlock)();

@interface AlgorithmViewController ()

@end

@implementation AlgorithmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)performActionWithCompletion:(CompletionBlock)completionBlock {
    completionBlock();
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSMutableArray *numbersArray = [[NSMutableArray alloc]initWithArray:@[@1, @8, @10, @88, @54, @34, @23]];
    [self quickSortArray:numbersArray];
    
    [self fizzBuzzWithNumber:100 andComplete:^(NSString *completion) {
        [self performActionWithCompletion:^{
            [self setUpHashTable];
        }];
    }];
}

- (NSArray *)arrayToHash {
    return @[@{@"1": @"A"}, @{@"2": @"B"}, @{@"3": @"C"}, @{@"4": @"D"}, @{@"5": @"E"}, @{@"6": @"F"}, @{@"7": @"G"}, @{@"8": @"H"}, @{@"9": @"I"}, @{@"10": @"J"}, @{@"11": @"K"}, @{@"12": @"L"}];
}

- (void)setUpHashTable { //Hash tables rule because they're O(1) (lookup functions), unless of course a collision happens
    
    NSHashTable *myHashtable = [NSHashTable
                                hashTableWithOptions:NSPointerFunctionsCopyIn];
    
    //Map table may be better for newer iOS versions
    
    for (int i = 0; i < [self arrayToHash].count; i++) {
        NSDictionary *dict = [self arrayToHash][i];
        NSString *value = dict[[NSString stringWithFormat:@"%i", i]];
        [myHashtable setValue:value forKey:[NSString stringWithFormat:@"%i", i + 1]];
    }
    
    NSLog(@"--- MY HASHTABLE %@ ---", myHashtable);
}

//Code credit (although I changed a few things) http://www.knowstack.com/sorting-algorithms-in-objective-c/

//Quick Sort

- (NSArray *)quickSortArray:(NSMutableArray *)arrayToSort {
    
    if (arrayToSort.count < 1) {
        return @[];
    }
    
    NSMutableArray *lesserHalfArray = [[NSMutableArray alloc]init];
    NSMutableArray *greaterHalfArray = [[NSMutableArray alloc]init];
    
    int randomPivot = arc4random() % arrayToSort.count;
    NSNumber *pivotValue = [arrayToSort objectAtIndex:randomPivot];
    [arrayToSort removeObjectAtIndex:randomPivot];
    
    for (NSNumber *number in arrayToSort) {
        
        //TODO increment iteration count here?
        
        if (number < pivotValue) {
            [lesserHalfArray addObject:number];
        }
        if (number > pivotValue) {
            [greaterHalfArray addObject:number];
        }
    }
    
    NSMutableArray *sortedArray = [[NSMutableArray alloc]init];
    [sortedArray addObjectsFromArray:[self quickSortArray:lesserHalfArray]];
    [sortedArray addObject:pivotValue];
    [sortedArray addObjectsFromArray:[self quickSortArray:greaterHalfArray]];
    
    return sortedArray;
}

//Merge Sort

- (NSArray *)mergeSortWithArray:(NSArray *)arrayToSort {
    
    if (arrayToSort.count < 2) {
        return @[];
    }
    
    long middle = arrayToSort.count / 2;
    NSRange left = NSMakeRange(0, middle);
    NSRange right = NSMakeRange(middle, arrayToSort.count - middle);
    NSArray *rightArray = [arrayToSort subarrayWithRange:right];
    NSArray *leftArray = [arrayToSort subarrayWithRange:left];
    
    NSArray *result = [self mergeArraysWithLeftArray:[self mergeSortWithArray:leftArray] rightArray:[self mergeSortWithArray:rightArray]];
    
    return result;
}

- (NSArray *)mergeArraysWithLeftArray:(NSArray *)leftArray rightArray:(NSArray *)rightArray {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    int rightIndex = 0;
    int leftIndex = 0;
    
    while (leftIndex < leftArray.count && rightIndex < rightArray.count) {
        if ([[leftArray objectAtIndex:leftIndex]intValue] < [[rightArray objectAtIndex:rightIndex]intValue]) {
            [result addObject:[leftArray objectAtIndex:leftIndex++]];
        } else {
            [result addObject:[rightArray objectAtIndex:rightIndex++]];
        }
    }
    
    NSRange leftRange = NSMakeRange(leftIndex, leftArray.count - leftIndex);
    NSRange rightRange = NSMakeRange(rightIndex, rightArray.count - rightIndex);
    NSArray *newRight = [rightArray subarrayWithRange:rightRange];
    NSArray *newLeft = [leftArray subarrayWithRange:leftRange];
    newLeft = [result arrayByAddingObjectsFromArray:newLeft];
    
    return [newLeft arrayByAddingObjectsFromArray:newRight];
}

//Binary Search (In reality just use an NSSet to see if object is contained in said collection)

- (void)performBinaryWithArray:(NSArray *)arrayParameter andNumber:(NSNumber *)number {
    
    NSUInteger minIndex = 0;
    NSUInteger maxIndex = arrayParameter.count - 1;
    NSUInteger midIndex = arrayParameter.count / 2; //be careful with odd numbers
    
    NSNumber *minIndexValue = arrayParameter[minIndex];
    NSNumber *midIndexValue = arrayParameter[midIndex];
    NSNumber *maxIndexValue = arrayParameter[maxIndex];
    
    if (number > maxIndexValue || number < minIndexValue) {
        return;
    }
    
    if (number < midIndexValue) {
        NSArray *subArray = [arrayParameter subarrayWithRange:NSMakeRange(midIndex, arrayParameter.count / 2)];
        [self performBinaryWithArray:subArray andNumber:number];
    } else if (number > minIndexValue) {
        NSArray *subArray = [arrayParameter subarrayWithRange:NSMakeRange(midIndex + 1, arrayParameter.count / 2)];
        [self performBinaryWithArray:subArray andNumber:number];
    } else {
        NSLog(@"");
    }
}

- (void)depthFirstSearch { //No arguments, we'll just look at basic Algorithm
    
    NSMutableArray *stack = [[NSMutableArray alloc]init]; //can subclass, call it stack.
    
    id rootNode = nil;
    
    NSMutableSet *visitedNodes = [NSMutableSet setWithObject:rootNode];
    [stack addObject:rootNode];
    
    while (stack.count > 0) {
        GraphNode *node = stack.lastObject;
        NSSet *linkedNodes = node.linkedNodes;
        
        if (!linkedNodes) {
            [stack removeLastObject];
            continue;
        }
        if ([self seeIfEveryNodeHasBeenVisited:linkedNodes fromVisitedNodesSet:visitedNodes]) {
            [stack removeLastObject];
            continue;
        }
        
        GraphNode *theNode = linkedNodes.anyObject;
        
        if ([visitedNodes containsObject:theNode]) {
            [visitedNodes addObject:theNode];
            [stack addObject:theNode];
            continue;
        }
    }
}

- (BOOL)seeIfEveryNodeHasBeenVisited:(NSSet *)linkedNodes fromVisitedNodesSet:(NSMutableSet *)visitedNodesSet {
    for (GraphNode *node in linkedNodes) {
        if (![visitedNodesSet containsObject:node])
            return NO;
    }
    return YES;
}

//Fibonacci

- (void)fibonaccify {
    
    
}

//Big O linear (Pass it an array of 10 and it's fast, pass it an array of 100,000, not so much)

- (void)logArray:(NSArray *)array {
    for (int i = 0; i < array.count; i++) {
        NSLog(@"HEY %d", i);
    }
}

- (void)fizzBuzzWithNumber:(int)number andComplete:(void (^)(NSString *completion))completionString {
    
    for (int i = 1; i <= number; i++) {
        if (!(i % 6)) {
            if (!(i % 10)) {
                NSLog(@"FZBZ");
            } else {
                NSLog(@"FZ");
            }
        }
        else if (!(i % 10)) {
            NSLog(@"BZ");
        } else {
            NSLog(@"%i", i);
        }
    }
    
    completionString(@"FizzBuzz done");
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
