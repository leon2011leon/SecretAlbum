//
//  WildcardGestureRecognizer.m
//  TaduFramework
//
//  Created by a on 12-7-6.
//  Copyright (c) 2012年 塔读. All rights reserved.
//

#import "WildcardGestureRecognizer.h"


@implementation WildcardGestureRecognizer
@synthesize touchesBeganCallback;
@synthesize touchesMoveCallback;
@synthesize touchesEndCallback;
@synthesize touchesDelegate = _touchesDelegate;
-(id) init{
    if (self = [super init])
    {
        self.cancelsTouchesInView = NO;
        self.delaysTouchesEnded = NO;
        self.delaysTouchesBegan = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   self.cancelsTouchesInView = NO;
    if (self.touchesDelegate && [self.touchesDelegate respondsToSelector:@selector(touchesBegan:Event:)])
    {
        [self.touchesDelegate touchesBegan:touches Event:event];
    }

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.touchesDelegate && [self.touchesDelegate respondsToSelector:@selector(touchesEnd:Event:)])
    {
        self.cancelsTouchesInView = YES;
        [self.touchesDelegate touchesEnd:touches Event:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (self.touchesDelegate && [self.touchesDelegate respondsToSelector:@selector(touchesEnd:Event:)])
    {
        [self.touchesDelegate touchesEnd:touches Event:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.touchesDelegate && [self.touchesDelegate respondsToSelector:@selector(touchesMove:Event:)])
    {
        [self.touchesDelegate touchesMove:touches Event:event];
    }
}

- (void)reset
{
}


- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    return NO;
}

- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    return NO;
}

@end

