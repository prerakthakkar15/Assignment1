//
//  ServiceManagerClass.m
//  pterakTestAssignment
//
//  Created by Prerak Thakkar on 12/09/17.
//  Copyright © 2017 Prerak Thakkar. All rights reserved.
//

#import "ServiceManagerClass.h"
#import "Reachability.h"
#import "CoreDataBaseClass.h"
#import "AppDelegate.h"
#import "Constant.h"

@implementation ServiceManagerClass

-(void)fetchDataFromRSSFeed{
    if([self checkConnection]){
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [NSURL URLWithString:KCONST_STRURL];
        NSLog(@"URL = %@",url);
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"Response %@", responseJson);
            NSMutableArray *responseArray = [[NSMutableArray alloc]initWithArray:[responseJson        valueForKeyPath:@"feed.results"]];
            if(responseArray.count){
             [[CoreDataBaseClass sharedManager] deleteAllFeedsData];
            [[CoreDataBaseClass sharedManager] insertStationRecordInLocalDatabase:responseArray];
            if(self.DataReceivFromServerCallBack){
               self.DataReceivFromServerCallBack(YES);
            }
         }
        }];
        [dataTask resume];
    }
    
   
}

-(BOOL)checkConnection
{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    if(!networkStatus){
        dispatch_async(dispatch_get_main_queue(), ^{
            AppDelegate *appDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
            
            UIViewController *viewController = appDelegate.window.rootViewController;
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"No Internet Connection Available" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [viewController presentViewController:alertController animated:YES completion:nil];
            
        });
    }
    return networkStatus;
}

@end
