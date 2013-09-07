//
//  PhotoItemInfo.h
//  SecretAlbum
//
//  Created by changlu on 13-9-7.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoItemInfo : NSObject

@property (nonatomic, strong) UIImage *imgOrigin,*imgThumbnail;
@property (nonatomic, strong) NSString *strOriginName,*strThumbnailName;
@property (nonatomic, strong) AVFile *fileOrigin,*fileThumbnail;

@end
