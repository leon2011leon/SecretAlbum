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
            imgPhoto[i].userInteractionEnabled = YES;
            [self addSubview:imgPhoto[i]];
            
            btnPhoto[i] = [UIButton buttonWithType:UIButtonTypeCustom];
            btnPhoto[i].tag = i;
            [btnPhoto[i] addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            btnPhoto[i].frame = imgPhoto[i].bounds;
            [imgPhoto[i] addSubview:btnPhoto[i]];
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
    imgPhoto[0].image = [UIImage imageNamed:@"default_small"];
    imgPhoto[1].image = [UIImage imageNamed:@"default_small"];
    imgPhoto[2].image = [UIImage imageNamed:@"default_small"];
    imgPhoto[0].file = self.photoInfo1.fileThumbnail;
    [imgPhoto[0] loadInBackground];
    if (self.photoInfo2 != nil) {
        
        imgPhoto[1].file = self.photoInfo2.fileThumbnail;
        [imgPhoto[1] loadInBackground];
        imgPhoto[1].hidden = NO;
        btnPhoto[1].hidden = NO;
    }
    else {
        imgPhoto[1].hidden = YES;
        btnPhoto[1].hidden = YES;
    }
    
    if (self.photoInfo3 != nil) {
        imgPhoto[2].file = self.photoInfo3.fileThumbnail;
        [imgPhoto[2] loadInBackground];
        imgPhoto[2].hidden = NO;
        btnPhoto[2].hidden = NO;
    }
    else {
        imgPhoto[2].hidden = YES;
        btnPhoto[2].hidden = YES;
    }
}

- (void)clickBtn:(UIButton *)sender{
    NSInteger index = sender.tag;
    if (self.mainContent) {
        [self.mainContent performSelector:@selector(showFull:) withObject:index==0?self.photoInfo1:(index==1?self.photoInfo2:self.photoInfo3)];
    }
}

@end
