//
//  CoreDataBaseClass.h
//  pterakTestAssignment
//
//  Created by Prerak Thakkar on 10/09/17.
//  Copyright © 2017 Prerak Thakkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataBaseClass : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+(CoreDataBaseClass*)sharedManager;
-(void)insertStationRecordInLocalDatabase:(NSArray *)arrFeedResults;
-(NSArray*)getStoredData;
@end
