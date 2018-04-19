//
//  User.h
//  SQL'in
//
//  Created by Ethan Hess on 8/12/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@import UIKit;

typedef enum {
    
    Permission_User = 0,
    Permission_Admin,
    
} Permission;

@interface User : NSObject

//Properties

@property (readwrite, nonatomic) int idString;

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *imagePath;

//Enum
@property (readwrite, nonatomic) Permission *userPermissions;

//Methods

- (id)initAdmin;
- (id)initUser:(NSString *)username password:(NSString *)password;
- (id)setProfileImage:(UIImage *)image;

@end
