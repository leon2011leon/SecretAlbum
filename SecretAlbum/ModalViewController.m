//
//  ModalView.m
//  Shopping
//
//  Created by Xu Deheng on 11-5-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ModalViewController.h"


@implementation ModalViewController

@synthesize modalStyle;
@synthesize animatedViewController;

- (id) init
{
	self = [super init];
	modalStyle = MODAL_DOWN_IN;
	//modalStyle = MODAL_FADE_IN;
	return self;
}

- (void) showModalView:(UIViewController<ModalViewDelegate> *)modalView OnWidnow:(UIView *)currWindow
{
    __modalView = modalView;
    
	if (modalStyle == MODAL_FADE_IN) {
		self.animatedViewController.view.alpha = 0.02f;
	}else {
		self.animatedViewController.view.center = [self hiddenCenter];
	}
    
    if (![NSThread currentThread].isMainThread) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [currWindow addSubview:self.animatedViewController.view];
        });
    }else {
        [currWindow addSubview:self.animatedViewController.view];
    }
	
    
#if !USING_BLOCK	
    
#else
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"ModalView block!");
        
        if (modalStyle == MODAL_FADE_IN) {
            self.animatedViewController.view.center = self.shownCenter;
        }
        [UIView animateWithDuration:0.35f animations:^{
            if (modalStyle == MODAL_FADE_IN) {
                self.animatedViewController.view.alpha = 1.0f;
            }else {
                self.animatedViewController.view.center = [self shownCenter];
            }
        } completion:^(BOOL finished) {
            if (finished && [__modalView respondsToSelector:@selector(showModalEnded:finished:context:)]) {
                [__modalView showModalEnded:nil finished:[NSNumber numberWithBool:YES] context:nil];
                [__modalView release];//just keep retainCount minus, not be set to nil.
            }
        }];
    });    
#endif
}

- (void) hideModalView:(UIViewController<ModalViewDelegate>*)modalView
{
    __modalView = [modalView retain];    
    
#if !USING_BLOCK
    
#else
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"hide ModalView!");
        [UIView animateWithDuration:0.35 animations:^{
            if (modalStyle == MODAL_FADE_IN) {
                self.animatedViewController.view.alpha = 0.02f;
            }else {
                self.animatedViewController.view.center = [self hiddenCenter];
            }
        } completion:^(BOOL finished) {
            if (finished && [__modalView respondsToSelector:@selector(hideModalEnded:finished:context:)]) {
                [__modalView hideModalEnded:nil finished:[NSNumber numberWithBool:YES] context:NULL];
                [__modalView release];//cannot be replaced by SafeRelease()
            }
        }];
    });
#endif
}

- (CGPoint)hiddenCenter
{
    CGPoint offScreenCenter = CGPointZero;
    
	CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect rect = [[UIScreen mainScreen] applicationFrame];
	float dy = screenRect.size.height - rect.size.height;
    
	switch (modalStyle) {
		case MODAL_UP_IN:
			offScreenCenter.x = rect.size.width * 0.5;
			offScreenCenter.y = -rect.size.height * 0.5;
			break;
		case MODAL_DOWN_IN:
			offScreenCenter.x = rect.size.width / 2.0;
			offScreenCenter.y = rect.size.height * 1.5;
			break;
		case MODAL_LEFT_IN:
			offScreenCenter.x = -rect.size.width * 0.5;
			offScreenCenter.y = rect.size.height / 2.0 + dy;
			break;
		case MODAL_RIGHT_IN:
			offScreenCenter.x = rect.size.width * 1.5;
			offScreenCenter.y = rect.size.height / 2.0 + dy;
			break;
		default:
			break;
	}
    return offScreenCenter;
}

- (CGPoint)shownCenter
{
	CGPoint middleCenter = CGPointZero;
    
    //    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //	CGRect rect = [[UIScreen mainScreen] applicationFrame];
    //	float dy = screenRect.size.height - rect.size.height;
    //    middleCenter.x = screenRect.size.width / 2.0;
    //	middleCenter.y = frame.size.height / 2.0 + (dy / 2.0f);

    CGRect frame = [UIScreen mainScreen].applicationFrame;
    middleCenter.x = frame.size.width / 2.0;
    middleCenter.y = frame.size.height / 2.0 + frame.origin.y;
    
    //NSLog(@"middleCenter :%@", NSStringFromCGPoint(middleCenter));
    //NSLog(@"app frame :%@", NSStringFromCGRect([UIScreen mainScreen].applicationFrame));
    //NSLog(@"animViewCtrl :%@", NSStringFromCGRect(self.animatedViewController.view.frame));
    return middleCenter;
}

- (UIViewController *)animatedViewController
{
    if (__modalView) {
        if (__modalView.tabBarController) {
            return __modalView.tabBarController;
        }else if (__modalView.navigationController) {
            return __modalView.navigationController;
        }else {
            return __modalView;
        }
    }
    return nil;
}

- (void) dealloc
{
#if DEALLOC_LOGING
    NSLog(@"Dealloc ModalViewController!");
#endif
	[super dealloc];
}

@end
