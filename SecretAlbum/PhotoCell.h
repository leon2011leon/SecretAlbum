//
//  PhotoCell.h
//  SecretAlbum
//
//  Created by he chao on 13-9-7.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoItemInfo.h"
#define kItemCount 3

@interface PhotoCell : UITableViewCell{
    AVImageView *imgPhoto[kItemCount];
    UIButton *btnPhoto[kItemCount];
}
@property (nonatomic, strong) PhotoItemInfo *photoInfo1,*photoInfo2,*photoInfo3;
@property (nonatomic, strong) id mainContent;

- (void)loadContent;

@end
