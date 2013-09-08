//
//  LoginViewController.h
//  SecretAlbum
//
//  Created by changlu on 13-9-7.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MBProgressHUDDelegate>
{
    UITableView* m_tableView;
    UITextField* fieldEmail;
    UITextField* fieldPass;
    
    UIScrollView* m_scrollview;
    
    AVUser *tempUser;
    MBProgressHUD *HUD;
}
@property(nonatomic)BOOL isFirst;
@end
