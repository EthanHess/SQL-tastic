//
//  Node.h
//  SQL'in
//
//  Created by Ethan Hess on 3/7/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) NSObject *object;

@property (nonatomic, strong) Node *left;
@property (nonatomic, strong) Node *right;
@property (nonatomic, strong) Node *parent;

@property (nonatomic, assign) SEL compareMethod;

- (void)logDescription;
- (BOOL)isLeftChild;

@end
