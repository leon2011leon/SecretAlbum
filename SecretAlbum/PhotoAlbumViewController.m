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
    
    
    
    WildcardGestureRecognizer * tapInterceptor = [[WildcardGestureRecognizer alloc] init];
    tapInterceptor.delegate = self;
    tapInterceptor.touchesDelegate = self;
    
    [self.view addGestureRecognizer:tapInterceptor];
    self.view.backgroundColor = [UIColor redColor];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self animateHomeViewToSide:CGRectMake(-290.0f,
                                           self.navigationController.view.frame.origin.y,
                                           self.navigationController.view.frame.size.width,
                                           self.navigationController.view.frame.size.height)];
}

// move view to right side
- (void)moveToRightSide {
    homeViewIsOutOfStage = YES;
    [self animateHomeViewToSide:CGRectMake(290.0f,
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
