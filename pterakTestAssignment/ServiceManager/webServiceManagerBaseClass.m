//
//  webServiceManagerBaseClass.m
//  pterakTestAssignment
//
//  Created by Prerak Thakkar on 10/09/17.
//  Copyright © 2017 Prerak Thakkar. All rights reserved.
//

#import "webServiceManagerBaseClass.h"
#import "Reachability.h"
#import "AppDelegate.h"
//typedef void (^ServerResponseSuccessBlock)(BOOL sussuss);

@interface webServiceManagerBaseClass()
//<NSURLSessionDelegate, NSURLSessionTaskDelegate>
//@property (nonatomic, strong) NSURLSession *urlSession;
@end

@implementation webServiceManagerBaseClass
//-(void)sendRequestWithURL:(NSString *)strURl requestStartHandler:(void(^)(NSString* requestTag))startHandler completedRequestHandler:(void(^)(NSDictionary* responseDict,NSError* error))completedHandler finishRequestWithErrorHandler:(void(^)(NSError *error))errorHandler {
//    startRequestHandler = startHandler;
//    completedRequestHandler = completedHandler;
//    finishRequestWithErrorHandler = errorHandler;
//    if([self checkConnection]){
//        
//        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
//        
//        sessionConfig.timeoutIntervalForRequest = 60;
//        sessionConfig.timeoutIntervalForResource = 60;
//        
//        self.urlSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
//        NSURL *url = [NSURL URLWithString:strURl];
//        NSLog(@"url=%@",url);
//        
//       [[NSURLCache sharedURLCache] removeAllCachedResponses];
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//       [request setHTTPMethod:@"GET"];
//       
//        NSURLSessionDataTask *postDataTask = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            NSLog(@"error=%@",error.localizedDescription);
//            
//            if(error != nil){
//                finishRequestWithErrorHandler(error);
//            }else{
//                if (data.length > 0 && error == nil)
//                {
//                    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//                    
//                    completedRequestHandler(responseDict,error);
//                }
//            }
//            
//        }];
//        
//        [postDataTask resume];
//        
//        startRequestHandler(self.requestTag);
//    }
//    else{
//        NSError *error;
//        completedRequestHandler(nil,error);
//    }
//}

-(void)fetchDataFromRSSFeed{
    if([self checkConnection]){
    NSString *strRequestUrl = @"https://rss.itunes.apple.com/api/v1/us/apple-music/top-songs/100/non-explicit.json";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:strRequestUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", json);
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
