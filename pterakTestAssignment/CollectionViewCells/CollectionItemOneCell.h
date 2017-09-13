//
//  CollectionItemOneCell.h
//  pterakTestAssignment
//
//  Created by Prerak Thakkar on 12/09/17.
//  Copyright © 2017 Prerak Thakkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionItemOneCell : UICollectionViewCell

@property(nonatomic,weak)IBOutlet UIImageView *imgView;
@property(nonatomic,weak)IBOutlet UILabel *lblArtistName;
@property(nonatomic,weak)IBOutlet UILabel *lblName;

-(void)configureCell:(NSDictionary*) dict;
@end
