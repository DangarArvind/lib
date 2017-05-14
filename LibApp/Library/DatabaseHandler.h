//
//  DatabaseHandler.h
//  ijoomer
//
//  Created by Nirav on 5/4/15.
//  Copyright (c) 2015 tasol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseHandler : NSObject
{
    sqlite3 *database;
}
+(DatabaseHandler*)sharedInstance;
//-(void) insertCOnfigmenuData: (NSString *)menuid :(NSString *)menuposition : (NSString *)menuname : (NSMutableArray *)arrscreen : (NSMutableArray *)arrmenuitem;

+(void) moveDatabase;
+ (void) copyDatabaseIfNeeded;
+ (NSString *) getDBPath;
-(BOOL) deleteData: (NSString *)sqlQuery;
-(void) insertData: (NSString *)sqlQuery;
-(NSMutableArray*)getDataFromLocalDatabase:(NSString*)sqlQuery;
-(void)CreateTable:(NSString *)Query;
-(int)CheckTableExist:(NSString *)tablename;
-(int) CheckDataExist: (NSString *)sqlQuery;
-(int)DropTable: (NSString *)tablename;
-(BOOL)updateData: (NSString *)sqlQuery;
-(BOOL) insertData:(NSString *)tableName Keys:(NSArray *)arrKeys Values:(NSDictionary *)dictForValue;
@end
