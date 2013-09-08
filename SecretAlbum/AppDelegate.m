//
//  AppDelegate.m
//  SecretAlbum
//
//  Created by he chao on 13-9-7.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "PhotoAlbumViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    self.leftViewController = [[LeftMenuViewController alloc] init];
    self.leftViewController.view.frame = CGRectMake(0,
                                                    20,
                                                    rect.size.width,
                                                    rect.size.height-20);
    
    self.photoAlbumCtrler = [[PhotoAlbumViewController alloc] init];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ViewController" owner:self options:nil];
    self.navController = [nib objectAtIndex:0];
    [self.navController pushViewController:self.photoAlbumCtrler animated:NO];
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    
    [self.leftViewController setVisible:YES];

    
    // main view (nav)
    
//    [self.window addSubview:self.leftViewController.view];
//    [self.window addSubview:self.navController.view];
    
    self.loginViewCtrler = [[LoginViewController alloc] init];
    self.loginViewCtrler.view.frame = self.navController.view.frame;
    [self.window addSubview:self.loginViewCtrler.view];
    self.loginViewCtrler.isFirst = YES;
    //[self.navController presentModalViewController:login animated:NO];
    
    [AVOSCloud setApplicationId:@"kebqe6dp6m56fdr26ktwjkudydgyavnjqs06dza425lu7jdf"
                      clientKey:@"bnfpj0sutsxnoebw4bsil567ibap8ay0pllo4h58u9nno2o3"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//     LoginViewController* login = [[LoginViewController alloc] init];
//    login.view.frame = self.navController.view.frame;
    //[self.window addSubview:login.view];
    self.loginViewCtrler.isFirst = NO;
    [self.navController presentModalViewController:self.loginViewCtrler animated:NO];
    

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)makeLeftViewVisible {
    self.navController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navController.view.layer.shadowOpacity = 0.4f;
    self.navController.view.layer.shadowOffset = CGSizeMake(-12.0, 1.0f);
    self.navController.view.layer.shadowRadius = 7.0f;
    self.navController.view.layer.masksToBounds = NO;
    [self.leftViewController setVisible:YES];
}

- (void)restoreViewLocation{
    
    [self.photoAlbumCtrler restoreViewLocation];
    
}
@end
