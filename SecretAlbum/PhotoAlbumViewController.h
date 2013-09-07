//
//  PhotoAlbumViewController.h
//  SecretAlbum
//
//  Created by changlu on 13-9-7.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WildcardGestureRecognizer.h"
#import "QBImagePickerController.h"
#import "AGAlertViewWithProgressbar.h"
@interface PhotoAlbumViewController : UINavigationController<UIGestureRecognizerDelegate,touchesDelegate,UIActionSheetDelegate,QBImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    CGPoint touchBeganPoint;
    BOOL homeViewIsOutOfStage;
    NSMutableArray * _array,*arrayPhotos;
    
    AGAlertViewWithProgressbar *alertViewWithProgressbar;
    
}

- (IBAction)leftBarBtnTapped:(id)sender;
- (void)restoreViewLocation;
@end
