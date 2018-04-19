//
//  GlobalFunctions.m
//  SQL'in
//
//  Created by Ethan Hess on 4/16/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "GlobalFunctions.h"

@implementation GlobalFunctions

+ (void)animateBorderWidth:(UIView *)view fromValue:(NSNumber *)fromValue toValue:(NSNumber *)toValue andDuration:(double)duration {
    
    CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    theAnimation.fromValue = fromValue;
    theAnimation.toValue = toValue;
    theAnimation.duration = duration;
    [view.layer addAnimation:theAnimation forKey:@"Width"];
    view.layer.borderWidth = [toValue floatValue];
}

+ (void)presentAlertWithTitle:(NSString *)title andText:(NSString *)text fromVC:(UIViewController *)theVC {
    
    UIAlertController *theAlert = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
    
    [theAlert addAction:okayAction];
    
    [theVC presentViewController:theAlert animated:YES completion:nil];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
