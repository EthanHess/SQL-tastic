//
//  DatabaseManager.h
//  SQL'in
//
//  Created by Ethan Hess on 8/12/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "UserInformation.h"
#import "User.h"

static sqlite3 *theDatabase = nil;
static sqlite3_stmt *theStatement = nil;

static NSString *const DB_STRING = @"SQL_DATABASE";

@interface DatabaseManager : NSObject

+ (DatabaseManager *)sharedInstance;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password;
- (void)initialize;
- (void)close;

- (BOOL)makeTabels;
- (BOOL)insertUserData:(User *)userObject;

- (void)makeCopy;

- (User *)getUserDataByUsername:(NSString *)username;
- (User *)getUserDataWithIdString:(int)userID;
- (User *)getUserDataWithPermission:(int)permission;

- (NSMutableArray *)getUserInfo:(NSString *)queryString;

- (BOOL)deleteUserDataByID:(int)userID;
- (BOOL)deleteUserDataByUsername:(int)username;
- (BOOL)deleteUserInfo:(NSString *)userID;

- (BOOL)updateUserData:(NSString *)username password:(NSString *)password permission:(int)permission oldUsername:(NSString *)oldUsername imagePath:(NSString *)imagePath;

- (BOOL)insertAdminData;

- (BOOL)updateUserInfo:(UserInformation *)userInfo;
- (BOOL)insertUserInfo:(UserInformation *)userInfo;

- (UserInformation *)getUserInfo;

//TODO: More functions to insertValues?


@end
