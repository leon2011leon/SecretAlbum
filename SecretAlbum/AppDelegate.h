//
//  AppDelegate.h
//  SecretAlbum
//
//  Created by he chao on 13-9-7.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuViewController.h"
#import "LoginViewController.h"
#import "PhotoAlbumViewController.h"
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *viewController;

@property (strong, nonatomic) IBOutlet UINavigationController *navController;

@property (strong, nonatomic)  LeftMenuViewController*leftViewController;
@property (strong, nonatomic) AVUser *tempUser;
@property (strong, nonatomic) LoginViewController* loginViewCtrler;
@property (strong, nonatomic) PhotoAlbumViewController* photoAlbumCtrler;
- (void)makeLeftViewVisible;
- (void)restoreViewLocation;
@end
