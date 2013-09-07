//
//  WildcardGestureRecognizer.h
//  TaduFramework
//
//  Created by a on 12-7-6.
//  Copyright (c) 2012年 塔读. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^TouchesEventBlock)(NSSet * touches, UIEvent * event);


@protocol touchesDelegate <NSObject>

@optional
- (void)touchesBegan:(NSSet*) touches Event:(UIEvent *)event;
- (void)touchesMove:(NSSet*) touches Event:(UIEvent *)event;
- (void)touchesEnd:(NSSet*) touches Event:(UIEvent *)event;
@end

@interface WildcardGestureRecognizer : UIGestureRecognizer {
    TouchesEventBlock touchesBeganCallback;
    TouchesEventBlock touchesMoveCallback;
    TouchesEventBlock touchesEndCallback;
}
@property(copy) TouchesEventBlock touchesBeganCallback;
@property(copy) TouchesEventBlock touchesMoveCallback;
@property(copy) TouchesEventBlock touchesEndCallback;

@property (nonatomic, assign) id<touchesDelegate> touchesDelegate;


@end
