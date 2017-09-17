//
//  CollectionItemOneCell.m
//  pterakTestAssignment
//
//  Created by Prerak Thakkar on 12/09/17.
//  Copyright © 2017 Prerak Thakkar. All rights reserved.
//

#import "CollectionItemOneCell.h"
#import "Constant.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+WebCache.h"

@implementation CollectionItemOneCell
-(void)awakeFromNib {
    [super awakeFromNib];
  }

-(void)configureCell:(NSDictionary*)dict{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.lblName setText:[dict valueForKey:KCONST_NAME]];
    [self.lblArtistName setText:[dict valueForKey:KCONST_ARTISTNAME]];
    NSString *strImageURl = [dict valueForKey:KCONST_ARTWORKURL100];
    NSURL *url = [NSURL URLWithString:strImageURl];
    [self.imgView sd_setShowActivityIndicatorView:YES];
    [self.imgView sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"images.jpeg"]];
    
}

@end
