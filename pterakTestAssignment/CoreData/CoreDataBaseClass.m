//
//  CoreDataBaseClass.m
//  pterakTestAssignment
//
//  Created by Prerak Thakkar on 10/09/17.
//  Copyright © 2017 Prerak Thakkar. All rights reserved.
//

#import "CoreDataBaseClass.h"
#import "Feeds.h"
#import "Constant.h"
@implementation CoreDataBaseClass
#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+(CoreDataBaseClass *)sharedManager
{
    static CoreDataBaseClass* coreDataSharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coreDataSharedManager = [[self alloc] init];
    });
    return coreDataSharedManager;
}

- (id)init {
    if (self = [super init]) {
        [self saveContext];
    }
    return self;
}


- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.prerak.testAssignment.pterakTestAssignment" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"pterakTestAssignment" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"pterakTestAssignment.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - 
#pragma mark Database Operation

-(void)insertStationRecordInLocalDatabase:(NSArray *)arrFeedResults{
    for (NSDictionary *feedDisc in arrFeedResults)
    {
        Feeds  *objFeeds = [NSEntityDescription insertNewObjectForEntityForName:@"Feeds" inManagedObjectContext:_managedObjectContext];
       
        if ([feedDisc valueForKey:KCONST_ARTISTNAME]) {
            objFeeds.artistName = [feedDisc valueForKey:KCONST_ARTISTNAME];
        }
        if ([feedDisc valueForKey:KCONST_ARTWORKURL100]) {
            objFeeds.artworkUrl100 = [feedDisc valueForKey:KCONST_ARTWORKURL100];
        }
        if ([feedDisc valueForKey:KCONST_NAME]) {
            objFeeds.name = [feedDisc valueForKey:KCONST_NAME];
        }

       
    }
    NSError *error = nil;
    // Save the object to persistent store
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

-(NSArray*)getStoredData{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Feeds"];
    [request setResultType:NSDictionaryResultType];
    //[request setReturnsDistinctResults:YES];
    NSEntityDescription *trackEntity = [NSEntityDescription entityForName:@"Feeds" inManagedObjectContext:context];
    NSArray *keys = [trackEntity properties];
    [request setPropertiesToFetch:keys];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    return results;
}


@end
