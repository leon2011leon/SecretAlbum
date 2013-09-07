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
    [btnCreatAblum addTarget:self action:@selector(createAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCreatAblum];
    
    UIButton* btnOpenAblum = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOpenAblum.frame = CGRectMake(0, 100, 200, 50);
    [btnOpenAblum setTitle:@"打开隐形相册" forState:UIControlStateNormal];
    [btnOpenAblum addTarget:self action:@selector(openAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOpenAblum];
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
                    

                }else{
                    [self presentModalViewController:[((AppDelegate*)[UIApplication sharedApplication].delegate) navController] animated:YES];
                }
                
            }else  if (alertView.tag == 101) {
                
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
    [prompt addSubview:textField];
    [prompt setTransform:CGAffineTransformMakeTranslation(0.0, -100.0)];  //可以调整弹出框在屏幕上的位置
    prompt.tag = 100;
    
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
