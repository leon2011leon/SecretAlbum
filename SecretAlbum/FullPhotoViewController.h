//
//  FullPhotoViewController.h
//  SecretAlbum
//
//  Created by he chao on 13-9-7.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVScrollPageViewController.h"

@interface FullPhotoViewController : UIViewController<UIScrollViewDelegate>{
    AVImageView *_photo,*_top,*_bottom;
    UIButton *_btnClose,*_btnDownload;
    UILabel *_lbTitle;
    CVScrollPageViewController *pageViewController;
    UIImage *selImage;
}

@property (nonatomic,strong) NSString * str;
@property (nonatomic,strong) NSArray *arrayPic;
@property (nonatomic,assign) int selIndex;

@end
