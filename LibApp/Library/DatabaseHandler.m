//
//  DatabaseHandler.m
//  iJoomer
//
//  Created by Nirav Patadiya on 04/05/15.
//
//

#import "DatabaseHandler.h"
#import "NSUtil.h"


#define DB_NAME						@"ijoomer.sqlite"

@implementation DatabaseHandler

static DatabaseHandler *database;
+ (DatabaseHandler*)sharedInstance
{
    //    if (dataProvider == nil) {
    database = [[super allocWithZone:NULL] init];
    //    }
    return database;
}

-(NSMutableArray*)getDataFromLocalDatabase:(NSString*)sqlQuery
{
    NSMutableArray *arrRecords =[[NSMutableArray alloc] init];

    @try
    {
        NSFileManager *fileManager =[NSFileManager defaultManager];
        //
                BOOL success;
        
                NSString * theDBPath = [DatabaseHandler getDBPath];
        
                success = [fileManager fileExistsAtPath:theDBPath];
                if(!success)
                {
                    NSLog(@"failed to find the file");
                }
                if(!(sqlite3_open([theDBPath UTF8String], &database)== SQLITE_OK))
                {
                    NSLog(@"Error opening database");
                }
        
                sqlQuery = [sqlQuery stringByReplacingOccurrencesOfString:@"#" withString:@"%"];
                const char *sql = [sqlQuery UTF8String];
        
        
                static sqlite3_stmt *statement;
                if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) !=SQLITE_OK)
                {
                    
                    NSLog(@"Database returned error %d: %s", sqlite3_errcode(database), sqlite3_errmsg(database));
                    NSLog(@"failed to prepare statement");
                }
        
                while (sqlite3_step(statement)== SQLITE_ROW)
                {
                    NSMutableDictionary *recordDetail = [[NSMutableDictionary alloc]init];
                    
                    // ---------  Get Column Name and its value from the statement object and add into Records Array  ----------
                    
                    for (int i=0; i<sqlite3_column_count(statement); i++)
                    {
                        const char *statementConstant = sqlite3_column_name(statement,i);
                        
                        NSString *columnName = [NSString stringWithCString:statementConstant encoding:NSUTF8StringEncoding];
                        
                        [recordDetail setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, i)] forKey:columnName];
                        
                    }
                    [arrRecords addObject:recordDetail];
                    
                }
                sqlite3_finalize(statement);
    }
    @catch (NSException *exception)
    {
        NSLog(@"Database Handler Get Datafrom Localdatbase Exception : %@",exception);
    }
    @finally
    {
        sqlite3_close(database);
    }
    return  arrRecords;
}



//-(void) insertCOnfigmenuData : (NSString *)menuid : (NSString *)menuposition : (NSString *)menuname : (NSMutableArray *)arrscreen : (NSMutableArray *)arrmenuitem
//{
//    [DatabaseHandler moveDatabase];
//    NSString *databasePath = [DatabaseHandler getDBPath];
//    
//    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
//    {
//        const char *sqlStatement = "INSERT INTO Menus (menuid, menuposition, menuname, screens, menuitem) VALUES (?, ?, ?, ?, ?);";
//        sqlite3_stmt *insert_statement = nil;
//        
//        if(sqlite3_prepare_v2(database, sqlStatement, -1, &insert_statement, NULL) == SQLITE_OK)
//        {
//            
//            sqlite3_bind_int(insert_statement, 0, [menuid intValue]);
//            sqlite3_bind_int(insert_statement, 1, [menuposition intValue]);
//            sqlite3_bind_text(insert_statement, 2, [menuname UTF8String], -1, SQLITE_TRANSIENT);
//            
//            NSData *dataFromArrscreen = [[NSData alloc] init];
//            dataFromArrscreen = [NSKeyedArchiver archivedDataWithRootObject:arrscreen];
//            sqlite3_bind_blob(insert_statement, 3, [dataFromArrscreen bytes], [dataFromArrscreen length], SQLITE_TRANSIENT);
//            
//            NSData *dataFromArrmenuitem = [[NSData alloc] init];
//            dataFromArrmenuitem = [NSKeyedArchiver archivedDataWithRootObject:arrmenuitem];
//            sqlite3_bind_blob(insert_statement, 4, [dataFromArrmenuitem bytes], [dataFromArrmenuitem length], SQLITE_TRANSIENT);
//            
//            if(sqlite3_step(insert_statement) == SQLITE_DONE)
//            {
//                NSLog(@"DATABASE: Adding: Success");
//            }
//            else
//            {
//                NSLog(@"DATABASE: Adding: Failed");
//            }
//        }
//        else
//        {
//            NSLog(@"Error. Could not add Waypoint.");
//        }
//        sqlite3_finalize(insert_statement);
//    }
//    sqlite3_close(database);
//}

-(BOOL) insertData:(NSString *)tableName Keys:(NSArray *)arrKeys Values:(NSDictionary *)dictForValue
{
    @try
    {
        NSString *strKey = [arrKeys componentsJoinedByString:@","];
        NSMutableArray *arrKey = [[NSMutableArray alloc]initWithArray:arrKeys];
        id numbers[arrKey.count];
        for (int x = 0; x < arrKey.count; ++x)
            numbers[x] = @"?";
        NSString *strValue = [[NSArray arrayWithObjects:numbers count:arrKey.count] componentsJoinedByString:@","];
        
        
        
        NSString *sqlQuery=[NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@) VALUES (%@)",tableName,strKey,strValue];

        NSString *databasePath = [DatabaseHandler getDBPath];
        
        NSMutableArray *keyArray = [[NSMutableArray alloc] init];
        NSMutableArray *valueArray = [[NSMutableArray alloc] init];
        
        for (NSString *key in arrKey)
        {
            if ([dictForValue valueForKey:key])
            {
                [keyArray addObject:key];
                [valueArray addObject:@"?"];
            }
        }

        if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
        {
            const char *sqlStatement = [sqlQuery UTF8String];
            
            sqlite3_stmt *compiledStatement;
            
            if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
            {
                for (int i = 0; i < arrKeys.count; i++)
                {
                    if (![[dictForValue valueForKey:[arrKeys objectAtIndex:i]] isKindOfClass:[NSArray class]] && ![[dictForValue valueForKey:[arrKeys objectAtIndex:i]] isKindOfClass:[NSDictionary class]])
                    {
                        sqlite3_bind_text(compiledStatement, i+1, [[NSString stringWithFormat:@"%@",[dictForValue valueForKey:[arrKeys objectAtIndex:i]]] UTF8String], -1, SQLITE_TRANSIENT);
                    }
                    else
                    {
                        NSString *jsonStringofValue = [[dictForValue objectForKey:[arrKeys objectAtIndex:i]] JSONString];
                        sqlite3_bind_text(compiledStatement, i+1, [jsonStringofValue UTF8String], -1, SQLITE_TRANSIENT);
                    }
                }
                
                if(sqlite3_step(compiledStatement) == SQLITE_DONE)
                {
                    NSLog(@"DATA added successfully into Local Database");
                    return true;
                }
                else
                {
                    NSLog(@"DATABASE: Adding: Failed");
                    return false;
                }
            }
            else
            {
                NSLog(@"Error. Could not add Waypoint.");
                return  false;
            }
            sqlite3_finalize(compiledStatement);
        }
        else{
            return false;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Database Handler Insert Data Exception : %@",exception);
    }
    @finally {
        sqlite3_close(database);
    }
}

-(BOOL)updateData: (NSString *)sqlQuery
{
    @try
    {
        NSString *databasePath = [DatabaseHandler getDBPath];
        
        if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
        {
            const char *sqlStatement = [sqlQuery UTF8String];
            
            sqlite3_stmt *compiledStatement;
            
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
            {
                if(sqlite3_step(compiledStatement) == SQLITE_DONE)
                {
                    return true;
                    NSLog(@"DATA added successfully into Local Database");
                }
                else
                {
                    return  false;
                    NSLog(@"DATABASE: Adding: Failed");
                }
            }
            else
            {
                return  false;
                NSLog(@"Error. Could not add Waypoint.");
            }
            
            sqlite3_finalize(compiledStatement);
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"Database Handler Insert Data Exception : %@",exception);
    }
    @finally
    {
        sqlite3_close(database);
    }
}

-(void) insertData: (NSString *)sqlQuery
{
    @try
    {
        NSString *databasePath = [DatabaseHandler getDBPath];
        
        if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
        {
            const char *sqlStatement = [sqlQuery UTF8String];
            
            sqlite3_stmt *compiledStatement;
            
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
            {
                if(sqlite3_step(compiledStatement) == SQLITE_DONE)
                {
                    NSLog(@"DATA added successfully into Local Database");
                }
                else
                {
                    NSLog(@"DATABASE: Adding: Failed");
                }
            }
            else
            {
                NSLog(@"Error. Could not add Waypoint.");
            }
            
            sqlite3_finalize(compiledStatement);
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"Database Handler Insert Data Exception : %@",exception);
    }
    @finally
    {
        sqlite3_close(database);
    }
   
}

-(BOOL) deleteData : (NSString *)sqlQuery
{
    @try {
        
        NSString *path = [DatabaseHandler getDBPath];
        
        if (sqlite3_open([path UTF8String], &database) != SQLITE_OK)
        {
            // Even though the open failed, call close to properly clean up resources.
            sqlite3_close(database);
            NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
            // Additional error handling, as appropriate...
        }
        
        sqlite3_stmt *deleteStmt = nil;
        
        if(deleteStmt == nil)
        {
            const char *sql = [sqlQuery UTF8String];
            
            if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
            {
                NSAssert1(0, @"Error while  delete statement. '%s'", sqlite3_errmsg(database));
                return false;
            }
        }
        
        if (SQLITE_DONE != sqlite3_step(deleteStmt))
        {
            NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
            return false;
        }
        
        sqlite3_finalize(deleteStmt);
        return true;
        
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
        sqlite3_close(database);
    }
}

+ (void) copyDatabaseIfNeeded
{
    @try
    {
        //Using NSFileManager we can perform many file system operations.
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        NSString *dbPath = [DatabaseHandler getDBPath];
        BOOL success = [fileManager fileExistsAtPath:dbPath];
        
        if(!success) {
            
            NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_NAME];
            success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
            
            if (!success)
                NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"Database Handler Copy Database If Needed Exception : %@",exception);
    }
    @finally
    {
        
    }
}

+ (NSString *) getDBPath
{
    //Search for standard documents using NSSearchPathForDirectoriesInDomains
    //First Param = Searching the documents directory
    //Second Param = Searching the Users directory and not the System
    //Expand any tildes and identify home directories.
    
    @try
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
        NSString *documentsDir = [paths objectAtIndex:0];
        NSLog(@"Database path :- %@",documentsDir);
        return [documentsDir stringByAppendingPathComponent:DB_NAME];
    }
    @catch (NSException *exception)
    {
        NSLog(@"Database Handler getDBPath Excpetion : %@",exception);
    }
    @finally
    {
        
    }
}

+(void) moveDatabase
{
   
    @try
    {
        BOOL success;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"NewDB"]) {
            [fileManager removeItemAtPath:writableDBPath error:nil];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"NewDB"];
        }
        
        success = [fileManager fileExistsAtPath:writableDBPath];
        
        if (success)
        {
            return;
        }
        
        // The writable database does not exist, so copy the default to the appropriate location.
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_NAME];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        NSLog(@"DB Moved");
        
        if (!success)
        {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"Database Handler Move Database Exception : %@",exception);
    }
    @finally
    {
        
    }
    
}

-(void)CreateTable :(NSString *)compname tablename:(NSString *)tablename datadict:(NSDictionary *)datadict
{
    
    @try
    {
        NSString *databasePath = [DatabaseHandler getDBPath];
        
        if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
        {
            NSArray *arrallkey = [datadict allKeys];
            
            for (int i = 0; i < [arrallkey count]; i++)
            {
                
                if ([[datadict objectForKey:[arrallkey objectAtIndex:i]] isKindOfClass:[NSArray class]])
                {
                    NSLog(@"nsarray : %@",[datadict objectForKey:[arrallkey objectAtIndex:i]]);
                }
                else if ([[datadict objectForKey:[arrallkey objectAtIndex:i]] isKindOfClass:[NSDictionary class]])
                {
                    
                    NSLog(@"nsdictionary : %@",[datadict objectForKey:[arrallkey objectAtIndex:i]]);
                }
                else
                {
                    // do somthing
                    NSLog(@"string : %@",[datadict objectForKey:[arrallkey objectAtIndex:i]]);
                }
            }
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"Database Handler Create table Exception : %@",exception);
    }
    @finally
    {
        sqlite3_close(database);
    }
}

-(int) CheckDataExist: (NSString *)sqlQuery
{
    int rows = 0;
    @try
    {
        NSFileManager *fileManager =[NSFileManager defaultManager];
        
        BOOL success;
        
        NSString * theDBPath = [DatabaseHandler getDBPath];
        
        success = [fileManager fileExistsAtPath:theDBPath];
        if(!success)
        {
            NSLog(@"failed to find the file");
        }
        if((sqlite3_open([theDBPath UTF8String], &database)== SQLITE_OK))
        {
            
            const char *sql = [sqlQuery UTF8String];
            
            static sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    rows ++;
                }
                //                rows = sqlite3_column_int(statement, 0);
                NSLog(@"SQLite Rows: %i", rows);
            }
            else
            {
                NSLog(@"failed to prepare statement");
            }
            sqlite3_finalize(statement);
        }
    }
    @catch (NSException *e)
    {
        NSLog(@"An Exception occured at %@", [e reason]);
    }
    @finally
    {
         sqlite3_close(database);
    }
   
    return rows;
}

-(void)CreateTable:(NSString *)Query
{
   
    @try
    {
        NSString *databasePath = [DatabaseHandler getDBPath];
        const char *sqlStr = [Query UTF8String];
        static sqlite3_stmt *statement;
        
        if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
        {
            if(sqlite3_prepare_v2(database, sqlStr, -1, &statement, NULL) != SQLITE_OK)
            {
                NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
            }
            
            sqlite3_exec(database, sqlStr, NULL, NULL, NULL);
        }
        sqlite3_finalize(statement);
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
         sqlite3_close(database);
    }
}

-(int)CheckTableExist:(NSString *)tablename
{
    int flag = 0;
    @try
    {
        
        NSFileManager *fileManager =[NSFileManager defaultManager];
        
        BOOL success;
        
        NSString * theDBPath = [DatabaseHandler getDBPath];
        
        success = [fileManager fileExistsAtPath:theDBPath];
        if(!success)
        {
            NSLog(@"failed to find the file");
        }
        if(!(sqlite3_open([theDBPath UTF8String], &database)== SQLITE_OK))
        {
            NSLog(@"Error opening database");
        }
        
        const char *sql = [[NSString stringWithFormat:@"SELECT name FROM sqlite_master WHERE type='table' AND name='%@'",tablename] UTF8String];
        
        static sqlite3_stmt *statement;
        
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) !=SQLITE_OK)
        {
            NSLog(@"failed to prepare statement");
        }
        
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            flag = 1;
        }
        sqlite3_finalize(statement);
    }
    @catch (NSException *e)
    {
        NSLog(@"An Exception occured at %@", [e reason]);
    }
    @finally
    {
        sqlite3_close(database);
    }
    return flag;
}

-(int)DropTable: (NSString *)tablename
{
    int flag = 1;
    
    @try
    {
        
        NSFileManager *fileManager =[NSFileManager defaultManager];
        
        BOOL success;
        
        NSString * theDBPath = [DatabaseHandler getDBPath];
        
        success = [fileManager fileExistsAtPath:theDBPath];
        if(!success)
        {
            NSLog(@"failed to find the file");
        }
        if(!(sqlite3_open([theDBPath UTF8String], &database)== SQLITE_OK))
        {
            NSLog(@"Error opening database");
        }
        
        const char *sql = [[NSString stringWithFormat:@"drop table if exists '%@'",tablename] UTF8String];
        
        static sqlite3_stmt *statement;
        
        char *errorMsg = NULL;
        
        if(sqlite3_exec(database, sql, NULL, NULL, &errorMsg) != SQLITE_OK) {
            NSLog(@"Error DROP TABLE IF EXISTS rows: %s", errorMsg);
            sqlite3_free(errorMsg);
        }
        sqlite3_finalize(statement);
    }
    @catch (NSException *e)
    {
        NSLog(@"An Exception occured at %@", [e reason]);
    }
    @finally
    {
        sqlite3_close(database);
    }
    return flag;
}

@end
