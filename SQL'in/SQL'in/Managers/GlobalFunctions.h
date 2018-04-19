//
//  GlobalFunctions.h
//  SQL'in
//
//  Created by Ethan Hess on 4/16/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface GlobalFunctions : NSObject

+ (void)animateBorderWidth:(UIView *)view fromValue:(NSNumber *)fromValue toValue:(NSNumber *)toValue andDuration:(double)duration;

+ (void)presentAlertWithTitle:(NSString *)title andText:(NSString *)text fromVC:(UIViewController *)theVC;

+ (UIColor *)colorFromHexString:(NSString *)hexString; 

@end
