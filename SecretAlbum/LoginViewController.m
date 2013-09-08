//
//  LoginViewController.m
//  SecretAlbum
//
//  Created by changlu on 13-9-7.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "PhotoAlbumViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cover"]];
	// Do any additional setup after loading the view.
    [self loadLoginViewDetail];
    
}



- (void)loadLoginViewDetail
{

//    m_scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height - 44)];
//    [m_scrollview setScrollEnabled:YES];
//    [self.view addSubview:m_scrollview];
//    [m_scrollview setContentSize:CGSizeMake(320, self.view.frame.size.height - 44)];
    
//    UIImageView* bg_imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 17, 300, 89)];
//    [bg_imageview setImage:[[UIImage imageNamed:@"table_single.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
//    bg_imageview.tag = 101;
//    [self.view addSubview:bg_imageview];

    
    
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    UIView *vi2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    
    fieldEmail = [[UITextField alloc] initWithFrame:CGRectMake(30, 150, 260, 40)];
    fieldEmail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"intput_bg"]];
    fieldEmail.font = [UIFont systemFontOfSize:14];
    fieldEmail.keyboardType = UIKeyboardTypeDefault;
    fieldEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //垂直居中
    fieldEmail.placeholder = @"邮箱(必填)";
    fieldEmail.text = @"test";
    fieldEmail.leftView = vi;
    fieldEmail.leftViewMode = UITextFieldViewModeAlways;
    //    [[fieldEmail textInputTraits] setValue:[UIColor colorWithRed:155/255.0 green:214/255.0 blue:95/255.0 alpha:1.0]
    //                                                 forKey:@"insertionPointColor"];
    fieldEmail.delegate = self;
    [self.view addSubview:fieldEmail];
    
    fieldPass = [[UITextField alloc] initWithFrame:CGRectMake(30, 215, 260, 40)];
    fieldPass.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"intput_bg"]];
    fieldPass.font = [UIFont systemFontOfSize:14];
    fieldPass.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //垂直居中
    fieldPass.secureTextEntry = YES;
    fieldPass.keyboardType = UIKeyboardTypeDefault;
    fieldPass.delegate = self;
    fieldPass.placeholder = @"密码(必填)";
    fieldPass.text = @"12345678";
    fieldPass.leftView = vi2;
    fieldPass.leftViewMode = UITextFieldViewModeAlways;
    //    [[fieldPass textInputTraits] setValue:[UIColor colorWithRed:155/255.0 green:214/255.0 blue:95/255.0 alpha:1.0]
    //                                    forKey:@"insertionPointColor"];
    [self.view addSubview:fieldPass];
    
//    UILabel* labelline = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 300, 1)];
//    labelline.backgroundColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0];
//    [bg_imageview addSubview:labelline];

    
    
    UIButton* buttonLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonLogin setFrame:CGRectMake(0, 0, 227, 50)];
    buttonLogin.center = CGPointMake(160, fieldPass.frame.origin.y+fieldPass.frame.size.height+60);
    [buttonLogin setBackgroundImage:[[UIImage imageNamed:@"login"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]  forState:UIControlStateNormal];
    buttonLogin.tag = 102;
    [buttonLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonLogin addTarget:self action:@selector(LoginDone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonLogin];
    //m_scrollview.backgroundColor = [UIColor clearColor];
    //self.view.backgroundColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0];
    
	// Do any additional setup after loading the view.
}

#pragma mark textfielddelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //[m_scrollview setFrame:CGRectMake(0, 44, 320, self.view.frame.size.height - 44 - 216)];
    //    [m_scrollview setContentSize:CGSizeMake(320, self.frame.size.height - 44)];
    
}

#pragma mark buttonEvents
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([fieldPass isFirstResponder]) {
        [fieldPass resignFirstResponder];
    }
    if ([fieldEmail isFirstResponder]) {
        [fieldEmail resignFirstResponder];
    }
    //[m_scrollview setFrame:CGRectMake(0, 44, 320, self.view.frame.size.height - 44)];
}

//利用正则表达式验证

-(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}


-(void)LoginDone{
    

    
    
    if ([fieldEmail.text length]== 0) {

        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"邮箱不得为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
        return ;
    }
    
//    if (![self isValidateEmail:fieldEmail.text]) {
//        
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的邮箱输入错误，请重新输入" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alert show];
//        return ;
//    }
    
    if ([fieldPass.text length] == 0) {

        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不得为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return ;
    }
    [fieldEmail resignFirstResponder];
    [fieldPass resignFirstResponder];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"正在登录";
    [HUD show:YES];
    
    
    [AVUser logInWithUsernameInBackground:fieldEmail.text password:fieldPass.text block:^(AVUser *user, NSError *error) {
        
        if (user) {
            //Open the wall
            NSLog(@"%@",user);
            tempUser = user;
            ((AppDelegate*)[UIApplication sharedApplication].delegate).tempUser = user;
//            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Login success" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//            [myAlertView show];
            if (self.isFirst) {
                
                NSString *strPassword = @"123456";
                NSString *strUserID = [tempUser objectId];
                
                AVQuery*query = [AVQuery queryWithClassName:@"album"];
                [query whereKey:@"userid" equalTo:[user objectId]];
                [query whereKey:@"password" equalTo:fieldPass.text];
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    [HUD hide:YES];
                    if (!error) {
                        AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                        PhotoAlbumViewController* albumCtrler = [[PhotoAlbumViewController alloc] init];
                        delegate.photoAlbumCtrler.albumId = [[objects objectAtIndex:0] objectId];
                        delegate.photoAlbumCtrler.tempUser = user;
                        [delegate.photoAlbumCtrler reloadImage];
                        [delegate.loginViewCtrler.view removeFromSuperview];
                        [delegate.window addSubview:delegate.leftViewController.view];
                        [delegate.window addSubview:delegate.navController.view];
                        
                    }
                }];
 
            }else{
                [HUD hide:YES];
                [self dismissModalViewControllerAnimated:YES];
            }
            //[self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
        } else {
            [HUD hide:YES];
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
