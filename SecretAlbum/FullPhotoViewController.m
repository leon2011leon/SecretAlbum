//
//  FullPhotoViewController.m
//  SecretAlbum
//
//  Created by he chao on 13-9-7.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import "FullPhotoViewController.h"
#import "PhotoItemInfo.h"

@interface FullPhotoViewController ()

@end

@implementation FullPhotoViewController

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
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor grayColor];
    if (!pageViewController) {
        pageViewController = [[CVScrollPageViewController alloc] init];
    }
    pageViewController.indicatorStyle = CVScrollPageIndicatorStyleLight;
    pageViewController.view.exclusiveTouch = YES;
    pageViewController.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    //pageViewController.pageControlFrame = CGRectMake(0, pageViewController.frame.origin.y+pageViewController.frame.size.height-20, 320, 20);
    [pageViewController setDelegate:self];
    [self.view addSubview:pageViewController.view];
    pageViewController.pageControl.hidden = YES;
    //[self.view addSubview:pageViewController.pageControl];
    [self performSelector:@selector(loadPageContent)];
    
    
    _photo = [[AVImageView alloc] init];
    _photo.contentMode = UIViewContentModeScaleAspectFit;
    _photo.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_photo];
    
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    
    _top = [[AVImageView alloc] init];
    _top.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    _top.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    [self.view addSubview:_top];
    
    _bottom = [[AVImageView alloc] init];
    _bottom.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    _bottom.frame = CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49);
    [self.view addSubview:_bottom];
    
    _lbTitle = [[UILabel alloc] init];
    _lbTitle.frame = _top.frame;
    _lbTitle.backgroundColor = [UIColor clearColor];
    _lbTitle.textColor = [UIColor whiteColor];
    _lbTitle.textAlignment = NSTextAlignmentCenter;
    _lbTitle.font = [UIFont systemFontOfSize:16];
    _lbTitle.text = self.str;
    [self.view addSubview:_lbTitle];
    
    _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnClose.frame = CGRectMake(self.view.frame.size.width-60, 0, 50, 50);
    [_btnClose setImage:[UIImage imageNamed:@"close2"] forState:UIControlStateNormal];
    [_btnClose addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    //[_btnClose addSignal:photoBoard.CLOSE forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnClose];
    
    _btnDownload = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnDownload.frame = CGRectMake(self.view.frame.size.width - 60, _bottom.frame.origin.y + 11, 27, 27);
    [_btnDownload setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    [_btnDownload addTarget:self action:@selector(clickDownload) forControlEvents:UIControlEventTouchUpInside];
    //[_btnDownload addSignal:photoBoard.DOWNLOAD forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnDownload];
	// Do any additional setup after loading the view.
}

- (void)clickCloseBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickDownload{
    if (!selImage) {
        selImage = ((AVImageView *)[self scrollPageView:pageViewController viewForPageAtIndex:self.selIndex]).image;
    }
    //UIImageWriteToSavedPhotosAlbum(_photo.image, nil, nil, nil);
    UIImageWriteToSavedPhotosAlbum(selImage, nil, nil, nil);
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"已经保存到相册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [myAlertView show];
}

- (void)loadPageContent{
    pageViewController.pageCount = self.arrayPic.count;
    [pageViewController reloadData];
    pageViewController.pageControl.currentPage = self.selIndex;
    [pageViewController changePage:pageViewController.pageControl];
}

- (void)didScrollToPageAtIndex:(NSUInteger)index {
    _lbTitle.text = [NSString stringWithFormat:@"%d/%d",index+1,self.arrayPic.count];
    selImage = ((AVImageView *)[self scrollPageView:pageViewController viewForPageAtIndex:index]).image;
    //NSLog(@"dd");
}

- (UIView *)scrollPageView:(id)scrollPageView viewForPageAtIndex:(NSUInteger)index {
    AVImageView *pageView = (AVImageView *)[scrollPageView dequeueReusablePage:index];
    if (nil == pageView) {
        pageView = [[AVImageView alloc] init];
        pageView.contentMode = UIViewContentModeScaleAspectFit;
        pageView.frame = self.view.bounds;
    }
    pageView.image = [UIImage imageNamed:@"default_big"];
    pageView.file = ((PhotoItemInfo *)[self.arrayPic objectAtIndex:index]).fileOrigin;
    [pageView loadInBackground];
    return pageView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
