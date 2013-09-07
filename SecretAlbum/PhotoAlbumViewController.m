//
//  PhotoAlbumViewController.m
//  SecretAlbum
//
//  Created by changlu on 13-9-7.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import "PhotoAlbumViewController.h"
#import "AppDelegate.h"
#import "WildcardGestureRecognizer.h"
#import "PhotoItemInfo.h"
#import "PhotoCell.h"
#import "FullPhotoViewController.h"
//#import "QBImagePickerController.h"


#define kTriggerOffSet 100.0f
@interface PhotoAlbumViewController ()

@end

@implementation PhotoAlbumViewController

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
    
    
    _array = [[NSMutableArray alloc] init];
    
    UISwipeGestureRecognizer* swipeGestureRecog = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    [swipeGestureRecog setNumberOfTouchesRequired:1];
    swipeGestureRecog.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeGestureRecog.delegate = self;
    [self.navigationController.view addGestureRecognizer:swipeGestureRecog];
    
    
    
    
    swipeGestureRecog = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    [swipeGestureRecog setNumberOfTouchesRequired:1];
    swipeGestureRecog.direction = UISwipeGestureRecognizerDirectionRight;
    swipeGestureRecog.delegate = self;
    [self.view addGestureRecognizer:swipeGestureRecog];
    
    
//    
//    WildcardGestureRecognizer * tapInterceptor = [[WildcardGestureRecognizer alloc] init];
//    tapInterceptor.delegate = self;
//    tapInterceptor.touchesDelegate = self;
//    
//    [self.view addGestureRecognizer:tapInterceptor];
    
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(gestureRecognizerDidPan:)];
    panGesture.cancelsTouchesInView = YES;
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 1;
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    
    self.view.backgroundColor = [UIColor redColor];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    
    UIButton *btnReg = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReg.frame = CGRectMake(10, 70, 100, 40);
    [btnReg setTitle:@"注册" forState:UIControlStateNormal];
    [btnReg setBackgroundColor:[UIColor blackColor]];
    [btnReg addTarget:self action:@selector(clickRegBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnReg];
    
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLogin.frame = CGRectMake(10, 170, 100, 40);
    [btnLogin setTitle:@"登陆" forState:UIControlStateNormal];
    [btnLogin setBackgroundColor:[UIColor blackColor]];
    [btnLogin addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    
    UIButton *btnCreate = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCreate.frame = CGRectMake(150, 170, 100, 40);
    [btnCreate setTitle:@"创建" forState:UIControlStateNormal];
    [btnCreate setBackgroundColor:[UIColor blackColor]];
    [btnCreate addTarget:self action:@selector(clickCreateBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCreate];
    
    UIButton *btnGetAlbum = [UIButton buttonWithType:UIButtonTypeCustom];
    btnGetAlbum.frame = CGRectMake(150, 270, 100, 40);
    [btnGetAlbum setTitle:@"获取相册" forState:UIControlStateNormal];
    [btnGetAlbum addTarget:self action:@selector(clickGetAlbumBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnGetAlbum];
    
    UIButton *btnCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCamera.frame = CGRectMake(10, 270, 100, 40);
    [btnCamera setTitle:@"上传照片" forState:UIControlStateNormal];
    [btnCamera setBackgroundColor:[UIColor blackColor]];
    [btnCamera addTarget:self action:@selector(clickCameraBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCamera];
    
    UIButton *btnPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPhoto.frame = CGRectMake(10, 370, 100, 40);
    [btnPhoto setTitle:@"查询" forState:UIControlStateNormal];
    [btnPhoto setBackgroundColor:[UIColor blackColor]];
    [btnPhoto addTarget:self action:@selector(reloadImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPhoto];
    
}

- (void)clickRegBtn{
    AVUser *user = [AVUser user];
    user.username = @"test";
    user.password = @"12345678";
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Signup success" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [myAlertView show];
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}

- (void)clickLoginBtn{
    [AVUser logInWithUsernameInBackground:@"test" password:@"12345678" block:^(AVUser *user, NSError *error) {
        if (user) {
            //Open the wall
            NSLog(@"%@",user);
            tempUser = user;
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Login success" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [myAlertView show];
            //[self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}

- (void)clickCreateBtn{
    if (!tempUser) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:nil message:@"请先登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [myAlert show];
        return;
    }
    AVObject *createObj = [AVObject objectWithClassName:@"album"];
    [createObj setObject:[tempUser objectId] forKey:@"userid"];
    [createObj setObject:@"123456" forKey:@"password"];
    [createObj setObject:@"私密照片名称" forKey:@"albumname"];
    [createObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:nil message:@"创建相册成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [myAlert show];
        }
    }];
}

- (void)clickGetAlbumBtn{
    NSString *strPassword = @"123456";
    NSString *strUserID = [tempUser objectId];
    
    AVQuery*query = [AVQuery queryWithClassName:@"album"];
    [query whereKey:@"userid" equalTo:strUserID];
    [query whereKey:@"password" equalTo:strPassword];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"%@",objects);
            albumId = [[objects objectAtIndex:0] objectId];
            NSLog(@"%@",albumId);
        }
    }];
}

- (void)clickCameraBtn{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选择", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController * c = [[UIImagePickerController alloc] init];
            c.delegate = self;
            c.sourceType = UIImagePickerControllerSourceTypeCamera;
            //c.allowsEditing = YES;
            [self presentViewController:c animated:YES completion:nil];
        }
            break;
        case 1:
        {
            QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.filterType = QBImagePickerFilterTypeAllPhotos;
            imagePickerController.showsCancelButton = YES;
            imagePickerController.fullScreenLayoutEnabled = YES;
            imagePickerController.allowsMultipleSelection = YES;
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController] ;
            [self presentViewController:navigationController animated:YES completion:NULL];
        }
            break;
            
        default:
            break;
    }
}




#pragma mark - QBImagePickerControllerDelegate

- (void)imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    if([imagePickerController isKindOfClass:[QBImagePickerController class]])
    {
        if (imagePickerController.allowsMultipleSelection) {
            for (id sub in info) {
                UIImage * i = [sub[@"UIImagePickerControllerOriginalImage"] copy];
                if(i.size.width > 640)
                {
                    i = [self scaleImage:i toScale:640/i.size.width];
                }
                
                PhotoItemInfo *info = [[PhotoItemInfo alloc] init];
                info.imgOrigin = i;
                info.imgThumbnail = [self thumbnailImage:i];
                
                [_array addObject:info];
            }
            
            NSLog(@"Selected %d photos", [info count]);
            
            
        }
    }
    else
    {
        UIImage * i = [info[@"UIImagePickerControllerOriginalImage"] copy];
        if(i.size.width > 640)
        {
            i = [self scaleImage:i toScale:640/i.size.width];
        }
        PhotoItemInfo *info = [[PhotoItemInfo alloc] init];
        info.imgOrigin = i;
        info.imgThumbnail = [self thumbnailImage:i];
        
        [_array addObject:info];
        
    }
    
    [self postImage];
    //[self reloadImages];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"Cancelled");
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString *)descriptionForSelectingAllAssets:(QBImagePickerController *)imagePickerController
{
    return @"全选";
}

- (NSString *)descriptionForDeselectingAllAssets:(QBImagePickerController *)imagePickerController
{
    return @"全不选";
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos
{
    return [NSString stringWithFormat:@"照片%d张", numberOfPhotos];
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfVideos:(NSUInteger)numberOfVideos
{
    return [NSString stringWithFormat:@"视频%d个", numberOfVideos];
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos numberOfVideos:(NSUInteger)numberOfVideos
{
    return [NSString stringWithFormat:@"照片%d张、视频%d个", numberOfPhotos, numberOfVideos];
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)thumbnailImage:(UIImage *)image{
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    [image drawInRect:CGRectMake(0, 0, 100, 100)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}



- (void)postImage{
    alertViewWithProgressbar = [[AGAlertViewWithProgressbar alloc] initWithTitle:@"正在上传" message:@"0%" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    alertViewWithProgressbar.progress = 10;
    [alertViewWithProgressbar show];
    if (_array.count>0) {
        [self uploadImage:[_array objectAtIndex:0] index:0];
    }
    //    for (int i = 0; i < _array.count; i++) {
    //        [self uploadImage:[_array objectAtIndex:i]];
    //    }
}

- (void)uploadImage:(PhotoItemInfo *)item index:(int)i{
    NSData *img1 = UIImagePNGRepresentation(item.imgOrigin);
    NSData *img2 = UIImagePNGRepresentation(item.imgThumbnail);
    AVFile *imageFile = [AVFile fileWithName:@"origin" data:img1];
    AVFile *imageFile2 = [AVFile fileWithName:@"thumbnail" data:img2];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error == nil) {
            [imageFile2 saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                AVObject *obj = [AVObject objectWithClassName:@"photo"];
                [obj setObject:imageFile forKey:@"originurl"];
                [obj setObject:imageFile2 forKey:@"thumbnailurl"];
                [obj setObject:albumId forKey:@"albumID"];
                [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        if (i<[_array count]-1) {
                            [self uploadImage:[_array objectAtIndex:i+1] index:i+1];
                        }
                        else {
                            [self reloadImage];
                            [_array removeAllObjects];
                        }
                    }
                }];
            } progressBlock:^(int percentDone) {
                
            }];
        }
    } progressBlock:^(int percentDone) {
        
    }];
    /*
     NSData *imageData = UIImagePNGRepresentation(image);
     AVFile *imageFile = [AVFile fileWithName:@"demo" data:imageData];
     AVFile *imageFile2 = [AVFile fileWithName:@"demosmall" data:imageData];
     
     //[imageFile save];
     
     AVObject *obj = [AVObject objectWithClassName:@"photo"];
     [obj setObject:imageFile forKey:@"file1"];
     [obj setObject:imageFile2 forKey:@"file2"];
     
     
     [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
     // Handle success or failure here ...
     
     if (error == nil) {
     [alertViewWithProgressbar setMessage:@"上传成功"];
     [alertViewWithProgressbar setCancelButtonTitle:@"关闭"];
     }
     } progressBlock:^(int percentDone) {
     NSLog(@"%d",percentDone);
     [alertViewWithProgressbar setMessage:[NSString stringWithFormat:@"%d%%",percentDone]];
     //alertViewWithProgressbar.progress = percentDone;
     // Update your progress spinner here. percentDone will be between 0 and 100.
     }];*/
    
    
    //    [obj fetchIfNeededInBackgroundWithBlock:^(AVObject *object, NSError *error) {
    //        if (error == nil) {
    //            [alertViewWithProgressbar setMessage:@"上传成功"];
    //            [alertViewWithProgressbar setCancelButtonTitle:@"关闭"];
    //        }
    //    }];
}

- (void)reloadImage{
    AVQuery*query = [AVQuery queryWithClassName:@"photo"];
    [query whereKey:@"albumID" equalTo:albumId?albumId:@"1"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"%@",objects);
            if (!arrayPhotos) {
                arrayPhotos = [[NSMutableArray alloc] initWithCapacity:0];
            }
            [arrayPhotos removeAllObjects];
            
            for (int i = 0; i < objects.count; i++) {
                AVObject *obj = [objects objectAtIndex:i];
                PhotoItemInfo *info = [[PhotoItemInfo alloc] init];
                info.fileOrigin = [obj objectForKey:@"originurl"];
                info.fileThumbnail = [obj objectForKey:@"thumbnailurl"];
                [arrayPhotos addObject:info];
            }
            
            //arrayPhotos = (NSMutableArray *)objects;
            [myTableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayPhotos.count/3+((arrayPhotos.count%3)>0?1:0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cal"];
    if (cell == nil) {
        cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cal"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.photoInfo1 = [arrayPhotos objectAtIndex:indexPath.row*3];
    cell.mainContent = self;
    if (indexPath.row*3+1<=arrayPhotos.count-1) {
        cell.photoInfo2 = [arrayPhotos objectAtIndex:indexPath.row*3+1];
    }
    else {
        cell.photoInfo2 = nil;
    }
    
    if (indexPath.row*3+2<=arrayPhotos.count-1) {
        cell.photoInfo3 = [arrayPhotos objectAtIndex:indexPath.row*3+2];
    }
    else {
        cell.photoInfo3 = nil;
    }
    
    [cell loadContent];
    
    return cell;
}

- (void)showFull:(PhotoItemInfo *)photoInfo{
    FullPhotoViewController *controller = [[FullPhotoViewController alloc] init];
    controller.arrayPic = arrayPhotos;
    for (int i = 0; i < arrayPhotos.count; i++) {
        if ([photoInfo isEqual:[arrayPhotos objectAtIndex:i]]) {
            controller.selIndex = i;
            controller.str = [NSString stringWithFormat:@"%d/%d",i+1,arrayPhotos.count];
        }
    }
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) gestureRecognizerDidPan:(UIPanGestureRecognizer*)panGesture
{
    
    
    CGPoint currentPoint = [panGesture translationInView:self.view ];
    
    
    if (touchBeganPoint.x == 0) {
        touchBeganPoint = [panGesture locationInView:[[UIApplication sharedApplication] keyWindow]];
    }
    CGFloat xOffSet = currentPoint.x - touchBeganPoint.x;
    if (xOffSet > 0) {
        self.view.frame = CGRectMake(xOffSet,
                                     self.view.frame.origin.y,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    }



    //[panGesture setTranslation:CGPointZero inView:self.view];
    


    
    if (panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateCancelled)
    {
        UIView * view = (UIView*)panGesture.view;

        touchBeganPoint.x = 0;
        if (CGRectGetMinX(view.frame) < -kTriggerOffSet)
            [self moveToLeftSide];
        // animate to right side
        else if (CGRectGetMinX(view.frame) > kTriggerOffSet)
            [self moveToRightSide];
        else
            [self restoreViewLocation];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

// Check touch position in this method (Add by Ethan, 2011-11-27)
- (void)touchesBegan:(NSSet*) touches Event:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    touchBeganPoint = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
}

// Scale or move select view when touch moved (Add by Ethan, 2011-11-27)
- (void)touchesMove:(NSSet*) touches Event:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
    
    CGFloat xOffSet = touchPoint.x - touchBeganPoint.x;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (xOffSet > 0) {
        [appDelegate makeLeftViewVisible];
    }
    
    self.view.frame = CGRectMake(xOffSet,
                                 self.view.frame.origin.y,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
}

// reset indicators when touch ended (Add by Ethan, 2011-11-27)
- (void)touchesEnd:(NSSet*) touches Event:(UIEvent *)event {
    // animate to left side
    if (self.view.frame.origin.x < -kTriggerOffSet)
        [self moveToLeftSide];
    // animate to right side
    else if (self.view.frame.origin.x > kTriggerOffSet)
        [self moveToRightSide];
    else
        [self restoreViewLocation];
}

#pragma mark -
#pragma mark Other methods
- (void)handleSwipeGesture:(UISwipeGestureRecognizer *)sender
{
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        [self moveToRightSide];
        
    }else if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        [self moveToLeftSide];
    }
    
}

// restore view location
- (void)restoreViewLocation {
    homeViewIsOutOfStage = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = CGRectMake(0,
                                                      self.view.frame.origin.y,
                                                      self.view.frame.size.width,
                                                      self.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         UIControl *overView = (UIControl *)[[[UIApplication sharedApplication] keyWindow] viewWithTag:10086];
                         [overView removeFromSuperview];
                     }];
}

// move view to left side
- (void)moveToLeftSide {
    homeViewIsOutOfStage = YES;
    [self animateHomeViewToSide:CGRectMake(-200.0f,
                                           self.navigationController.view.frame.origin.y,
                                           self.navigationController.view.frame.size.width,
                                           self.navigationController.view.frame.size.height)];
}

// move view to right side
- (void)moveToRightSide {
    homeViewIsOutOfStage = YES;
    [self animateHomeViewToSide:CGRectMake(200.0f,
                                           self.view.frame.origin.y,
                                           self.view.frame.size.width,
                                           self.view.frame.size.height)];
}

// animate home view to side rect
- (void)animateHomeViewToSide:(CGRect)newViewRect {
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.view.frame = newViewRect;
                     }
                     completion:^(BOOL finished){
                         UIControl *overView = [[UIControl alloc] init];
                         overView.tag = 10086;
                         overView.backgroundColor = [UIColor clearColor];
                         overView.frame = self.view.frame;
                         [overView addTarget:self action:@selector(restoreViewLocation) forControlEvents:UIControlEventTouchDown];
                         [[[UIApplication sharedApplication].delegate window] addSubview:overView];
                         
                     }];
}

// handle push btn
- (IBAction)pushBtnTapped:(id)sender {
    
}

// handle left bar btn
- (IBAction)leftBarBtnTapped:(id)sender {
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] makeLeftViewVisible];
    [self moveToRightSide];
}




@end
