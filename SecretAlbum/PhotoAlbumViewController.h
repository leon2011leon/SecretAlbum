//
//  PhotoAlbumViewController.h
//  SecretAlbum
//
//  Created by changlu on 13-9-7.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WildcardGestureRecognizer.h"

@interface PhotoAlbumViewController : UINavigationController<UIGestureRecognizerDelegate,touchesDelegate>
{
    CGPoint touchBeganPoint;
    BOOL homeViewIsOutOfStage;
}
- (IBAction)leftBarBtnTapped:(id)sender;
@end
