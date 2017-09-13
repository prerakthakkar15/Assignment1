//
//  Feeds+CoreDataProperties.h
//  pterakTestAssignment
//
//  Created by Prerak Thakkar on 12/09/17.
//  Copyright © 2017 Prerak Thakkar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Feeds.h"

NS_ASSUME_NONNULL_BEGIN

@interface Feeds (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *artistName;
@property (nullable, nonatomic, retain) NSString *artworkUrl100;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
