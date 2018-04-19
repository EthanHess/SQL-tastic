//
//  Miscellaneous.h
//  SQL'in
//
//  Created by Ethan Hess on 3/8/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#ifndef Miscellaneous_h
#define Miscellaneous_h

#import <Foundation/Foundation.h>
@import UIKit;

@interface NSString (EthansAdditions)
+ (void)ethan;
@end;

@implementation NSString (EthansAdditions)
+ (void)ethan {
    NSLog(@"Ethan");
}
@end;

//struct Person {
//    NSString *name;
//    NSString *age;
//};

#endif /* Miscellaneous_h */
