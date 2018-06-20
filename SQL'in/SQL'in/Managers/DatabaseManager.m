//
//  DatabaseManager.m
//  SQL'in
//
//  Created by Ethan Hess on 8/12/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

#import "DatabaseManager.h"
#import "Constants.h"

@implementation DatabaseManager

+ (DatabaseManager *)sharedInstance {
    static DatabaseManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [DatabaseManager new];
    });
    
    return sharedInstance;
    
}

- (void)makeCopy {
    
    //manages files on local system
    NSFileManager *theFileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [pathArray objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:DB_STRING];
    
    BOOL doesExist = [theFileManager fileExistsAtPath:databasePath];
    
    if (!doesExist) {
        NSString *defaultPath = [[[NSBundle mainBundle]resourcePath]stringByAppendingString:DB_STRING];
        doesExist = [theFileManager copyItemAtPath:defaultPath toPath:databasePath error:&error];
        
        if (!doesExist) {
            NSAssert1(0, @"ERROR CREATING DATABASE %@", error.localizedDescription);
        }
    }
    [self initialize];
}

- (void)initialize {
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDirectory = [pathArray objectAtIndex:0];
    
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:DB_STRING];
    
    if (sqlite3_open([databasePath UTF8String], &theDatabase) != SQLITE_OK)
    {
        sqlite3_close(theDatabase);
        theDatabase = nil;
        return;
    }
    
    [self makeTables];
}

- (void)close {
    
    if (theDatabase) {
        sqlite3_close(theDatabase);
    }
    if (theStatement) {
        sqlite3_finalize(theStatement);
    }
}

- (void)makeTables {
    
    //change query string?
    NSString *queryString = [NSString stringWithFormat:@"create table if not exists %@(\
                             %@ integer primary key autoincrement, \
                             %@ text, \
                             %@ text, \
                             %@ integer, \
                             %@ text)",
                             TABLE_NAME_USER,
                             USER_ID,
                             USER_NAME,
                             USER_PASSWORD,
                             USER_PERMISSION,
                             USER_IMAGE_LOCATION];
    
    int success = sqlite3_exec(theDatabase, [queryString UTF8String], nil, nil, nil);
    BOOL didSucceed = success == SQLITE_OK;
    
    if (didSucceed == NO) {
        NSLog(@"Query failed!");
    }
    
    [self addColumn:USER_IMAGE_LOCATION toTable:TABLE_NAME_USER];
    
    
}

- (void)addColumn:(NSString *)columnName toTable:(NSString *)table {
    
    sqlite3_stmt *selectStatement;
    
    NSString *sqlStatement = [NSString stringWithFormat:@"select %@ from %@", columnName, table];
    
    if (sqlite3_prepare_v2(theDatabase, [sqlStatement UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
        NSLog(@"Table: %@, already contains column: %@",table, columnName);
    } else {
        NSLog(@"Adding columng: %@, to table: %@",columnName, table);
        
        NSString *addStatement = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@", table, columnName];
        
        sqlite3_prepare_v2(theDatabase, [addStatement UTF8String], -1, &selectStatement, NULL);
        
        //Make sure everything went okay
        
        if(sqlite3_step(selectStatement) == SQLITE_DONE)
        {
            NSLog(@"YES!");
        } else {
            NSLog(@"NOPE!");
        }
        sqlite3_finalize(selectStatement);
    }
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password {
    
}

//BEGIN TEST (TODO IMPLEMENT)

- (User *)getUserDataByUsername:(NSString *)username {
    
    User *userObject;
    return userObject;
}

- (User *)getUserDataWithIdString:(int)userID {
    
    User *userObject;
    return userObject;
}

- (User *)getUserDataWithPermission:(int)permission {
    
    User *userObject;
    return userObject;
}

//END TEST

- (BOOL)insertUserData:(User *)userObject {
    return YES;
}

@end
