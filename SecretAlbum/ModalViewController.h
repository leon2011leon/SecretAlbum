//
//  ModalView.h
//  Shopping
//
//  Created by Deheng Xu on 11-5-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ModalViewDelegate
@optional
- (void) showModalEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void) hideModalEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
@end

#define USING_BLOCK 1

#define MODAL_UP_IN		0
#define MODAL_DOWN_IN	1
#define MODAL_LEFT_IN	2
#define MODAL_RIGHT_IN	3
#define MODAL_FADE_IN	4

@interface ModalViewController : NSObject {
	int modalStyle;
    UIViewController<ModalViewDelegate> *__modalView;
}

@property (nonatomic, assign) int modalStyle;
@property (nonatomic, readonly) UIViewController *animatedViewController;

- (void)showModalView:(UIViewController<ModalViewDelegate>*)modalViewController OnWidnow:(UIView *) currWindow;
- (void)hideModalView:(UIViewController<ModalViewDelegate>*)modalViewController;
- (CGPoint)hiddenCenter;
- (CGPoint)shownCenter;
@end



