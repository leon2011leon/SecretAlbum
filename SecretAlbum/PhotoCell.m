//
//  PhotoCell.m
//  SecretAlbum
//
//  Created by he chao on 13-9-7.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        for (int i = 0; i < kItemCount; i++) {
            imgPhoto[i] = [[AVImageView alloc] initWithFrame:CGRectMake(15+100*i, 10, 90, 90)];
            [self addSubview:imgPhoto[i]];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadContent{
    imgPhoto[0].file = self.photoInfo1.fileThumbnail;
    [imgPhoto[0] loadInBackground];
    if (self.photoInfo2 != nil) {
        imgPhoto[1].file = self.photoInfo2.fileThumbnail;
        [imgPhoto[1] loadInBackground];
        imgPhoto[1].hidden = NO;
    }
    else {
        imgPhoto[1].hidden = YES;
    }
    
    if (self.photoInfo3 != nil) {
        imgPhoto[2].file = self.photoInfo3.fileThumbnail;
        [imgPhoto[2] loadInBackground];
        imgPhoto[2].hidden = NO;
    }
    else {
        imgPhoto[2].hidden = YES;
    }
}

@end
