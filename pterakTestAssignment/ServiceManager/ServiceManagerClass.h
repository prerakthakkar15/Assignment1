//
//  ServiceManagerClass.h
//  pterakTestAssignment
//
//  Created by Prerak Thakkar on 12/09/17.
//  Copyright © 2017 Prerak Thakkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceManagerClass : NSObject
- (void) fetchDataFromRSSFeed;
@property (nonatomic, copy) void (^DataReceivFromServerCallBack)(BOOL dataReceiVed);

@end
