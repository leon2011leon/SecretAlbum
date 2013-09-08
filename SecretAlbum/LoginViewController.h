//
//  LoginViewController.h
//  SecretAlbum
//
//  Created by changlu on 13-9-7.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate >
{
    UITableView* m_tableView;
    UITextField* fieldEmail;
    UITextField* fieldPass;
    
    UIScrollView* m_scrollview;
    
    AVUser *tempUser;
}
@property(nonatomic)BOOL isFirst;
@end
