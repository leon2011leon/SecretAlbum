//
//  LeftMenuViewController.m
//  SecretAlbum
//
//  Created by changlu on 13-9-7.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "AppDelegate.h"
#import "DDAlertPrompt.h"
#import <QuartzCore/QuartzCore.h>
#import "PhotoAlbumViewController.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

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
	// Do any additional setup after loading the view.
    UIButton* btnCreatAblum = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCreatAblum.frame = CGRectMake(0, 150, 200, 50);
    [btnCreatAblum setTitle:@"创建隐形相册" forState:UIControlStateNormal];
    btnCreatAblum.backgroundColor = [UIColor redColor];
    [btnCreatAblum addTarget:self action:@selector(createAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCreatAblum];
    
    UIButton* btnOpenAblum = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOpenAblum.frame = CGRectMake(0, 100, 200, 50);
    [btnOpenAblum setTitle:@"打开隐形相册" forState:UIControlStateNormal];
    btnOpenAblum.backgroundColor = [UIColor redColor];
    [btnOpenAblum addTarget:self action:@selector(openAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOpenAblum];
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)createAlbum{
    [(AppDelegate*)[UIApplication sharedApplication].delegate restoreViewLocation];
    
    DDAlertPrompt *prompt = [[DDAlertPrompt alloc] initWithTitle:@"创建相册" delegate:self cancelButtonTitle:@"取消"
                       otherButtonTitle:@"确定"];
    
    
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(27.0, 60.0, 230.0, 25.0)];
//    [textField setBackgroundColor:[UIColor whiteColor]];
//    [textField setPlaceholder:@"请输入相册密码"];
//    [prompt addSubview:textField];
//    [prompt setTransform:CGAffineTransformMakeTranslation(0.0, -100.0)];  //可以调整弹出框在屏幕上的位置
//    
//    UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(27.0, 95.0, 230.0, 25.0)];
//    [textField2 setBackgroundColor:[UIColor whiteColor]];
//    [textField2 setPlaceholder:@"请输入相册密码"];
//    [prompt addSubview:textField2];
//    [prompt setTransform:CGAffineTransformMakeTranslation(0.0, -200.0)];  //可以调整弹出框在屏幕上的位置
    
    prompt.tag = 100;
    
    [prompt show];
    
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            if (alertView.tag == 100) {
               DDAlertPrompt* view = (DDAlertPrompt*)alertView;
                if (![view.plainTextField.text isEqualToString:view.secretTextField.text]) {
                    UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:nil
                                                                     message:@"两次输入的密码不一致"
                                                                    delegate:self
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles: nil];
                    [prompt show];
                    

                }else{
                    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                    if (!appDelegate.tempUser) {
                        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:nil message:@"请先登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [myAlert show];
                        return;
                    }
                    AVObject *createObj = [AVObject objectWithClassName:@"album"];
                    [createObj setObject:[appDelegate.tempUser objectId] forKey:@"userid"];
                    [createObj setObject:view.plainTextField.text forKey:@"password"];
                    [createObj setObject:view.nameTextField.text forKey:@"albumname"];
                    [createObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (succeeded && !error) {
                            UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:nil message:@"创建相册成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [myAlert show];
                        }
                    }];
                    PhotoAlbumViewController* albumCtrler = [[PhotoAlbumViewController alloc] init];
                    albumCtrler.albumId = view.plainTextField.text;
                    albumCtrler.tempUser = appDelegate.tempUser;
                    [albumCtrler reloadImage];
                    
                    [self presentModalViewController:albumCtrler animated:YES];
                }
                
            }else  if (alertView.tag == 101) {
                
                AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                AVQuery*query = [AVQuery queryWithClassName:@"album"];
                [query whereKey:@"userid" equalTo:[appDelegate.tempUser objectId]];
                UITextField *textField = (UITextField*)[alertView viewWithTag:1000];
                [query whereKey:@"password" equalTo:textField.text];
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (error || objects.count == 0) {
                        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:nil message:@"无此相册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [myAlert show];
                    }else{
                        
                        PhotoAlbumViewController* albumCtrler = [[PhotoAlbumViewController alloc] init];
                        albumCtrler.albumId = [[objects objectAtIndex:0] objectId];
                        albumCtrler.tempUser = appDelegate.tempUser;
                        
                        [((AppDelegate*)[UIApplication sharedApplication].delegate).navController pushViewController:albumCtrler animated:NO];
                        
                        [((AppDelegate*)[UIApplication sharedApplication].delegate).window addSubview:((AppDelegate*)[UIApplication sharedApplication].delegate).navController.view];
                    }
                }];
                
 
            }
            break;
    }
}
-(void)openAlbum{
    [(AppDelegate*)[UIApplication sharedApplication].delegate restoreViewLocation];
    
    UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"输入密码"
                                                     message:@"\n\n"
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@"确定", nil];
    
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(27.0, 60.0, 230.0, 25.0)];
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setPlaceholder:@"请输入相册密码"];
    [textField setSecureTextEntry:YES];
    textField.layer.cornerRadius = 5;
    textField.tag = 1000;
    [prompt addSubview:textField];
    [prompt setTransform:CGAffineTransformMakeTranslation(0.0, -100.0)];  //可以调整弹出框在屏幕上的位置
    prompt.tag = 101;
    
    [prompt show];
    

    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setVisible:(BOOL)visible {
    self.view.hidden = !visible;
}
@end
