//
//  Constants.h
//  SQL'in
//
//  Created by Ethan Hess on 10/13/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

#import <Foundation/Foundation.h>

//Not sure if needed
#define DATABASE_PATH                               [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"SQLDatabase.sqlite"]

#define TABLE_NAME_USER                                 @"tbl_user"
#define USER_ID                                         @"id"
#define USER_NAME                                       @"user_name"
#define USER_PASSWORD                                   @"user_password"
#define USER_PERMISSION                                 @"user_permission"
#define USER_IMAGE_LOCATION                             @"image_loc"

@interface Constants : NSObject

@end
