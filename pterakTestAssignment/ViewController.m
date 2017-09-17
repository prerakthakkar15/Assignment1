//
//  ViewController.m
//  pterakTestAssignment
//
//  Created by Prerak Thakkar on 10/09/17.
//  Copyright © 2017 Prerak Thakkar. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"
#import "CoreDataBaseClass.h"
#import "ServiceManagerClass.h"
#import "CollectionItemOneCell.h"
#import "Constant.h"
#import "SVProgressHUD.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray *localStoredDataArray;
}
@property(nonatomic,weak)IBOutlet UICollectionView *collectionView;

@end

static NSString * const reuseIdentifier = @"Cell";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Initialise];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    }

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Initialisation Methods

- (void)Initialise{
    self.title = @"Rss iTunes Feed";
    ServiceManagerClass *objServiceManager = [[ServiceManagerClass alloc]init];
    [objServiceManager fetchDataFromRSSFeed];
    [SVProgressHUD show];
    //CallBack to check whether data is Available/received from server or not
    objServiceManager.DataReceivFromServerCallBack=^(BOOL isDataReceived){
        if(isDataReceived){
            // if data received from server and Inserted in coredata
            [self fetchLocalData];
        }
        else{
            //No Data Available
            [self showNoDataAvailableAlert];
            [SVProgressHUD show];
        }
    };
}

-(void)fetchLocalData{
    localStoredDataArray = [[NSMutableArray alloc]initWithArray: [[CoreDataBaseClass sharedManager] getStoredData]];
    NSLog(@"LocakData = %@",localStoredDataArray);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        [SVProgressHUD dismiss];
    });
   
}

- (void) showNoDataAvailableAlert{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"No Data Available" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    });
}

#pragma mark -
#pragma mark Button Action

-(IBAction)refresh:(id)sender{
    [self Initialise];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return localStoredDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *) collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell
    CollectionItemOneCell *cell = (CollectionItemOneCell *) [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionItemOneCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell configureCell:[localStoredDataArray objectAtIndex:indexPath.row]];
    [cell.lblArtistName preferredMaxLayoutWidth];
    [cell.lblName preferredMaxLayoutWidth];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
          return CGSizeMake(DEVICE_WIDTH-2, DEVICE_WIDTH-2);
    }else{
          return CGSizeMake((DEVICE_WIDTH/2)-2, (DEVICE_WIDTH/2)-2);
    }
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
    
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
            return UIEdgeInsetsMake(1, 1, 1, 1);
}


#pragma mark -
#pragma mark UICollectionViewDelegate

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */



@end
