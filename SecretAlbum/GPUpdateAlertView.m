//
//  GPUpdateAlertView.m
//  GaoPeng
//
//  Created by imac--zcl on 13-5-8.
//  Copyright (c) 2013年 leon. All rights reserved.
//

#import "GPUpdateAlertView.h"
#import "GPDataUpdateManager.h"
@implementation GPUpdateAlertView
@synthesize lastVersionInfo;
@synthesize contentView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews {
    
    [super layoutSubviews];
    int contentHeight = self.contentView.frame.size.height;
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y -  contentHeight/2, self.frame.size.width, self.frame.size.height + contentHeight + 35 )];
    
    UIView *lowestView;
    
    int i = 0;
    
    while (![[self.subviews objectAtIndex:i] isKindOfClass:[UIControl class]]) {
        
        lowestView = [self.subviews objectAtIndex:i];
        
        i++;
        
    }
    
    CGFloat tableWidth = 262.0f;
    
    self.contentView.frame = CGRectMake(11.0f, lowestView.frame.origin.y + lowestView.frame.size.height + 2 * 5, tableWidth, contentHeight);

    for (UIView *v in self.subviews) {
        
        if ([v isKindOfClass:[UIControl class]]) {
            
            v.frame = CGRectMake(v.frame.origin.x, self.frame.size.height - v.frame.size.height - 50  , v.frame.size.width, v.frame.size.height);
            
            
        }
        
    }
    
}

- (void)show{
    
    [self prepare];
    
    [super show];
    
}

- (void)prepare {

    NSString* titleForMsg = [NSString stringWithFormat:@"温馨提示：%@",self.lastVersionInfo.updateMsg];
    CGSize labelsizeForLog = [self.lastVersionInfo.changeLog sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(257, 1000) lineBreakMode:UILineBreakModeWordWrap];
    CGSize labelsizeForMsg = [titleForMsg sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(257, 1000) lineBreakMode:UILineBreakModeWordWrap];
    self.contentView=[[[UIView alloc] initWithFrame:CGRectMake(12, 50, 260, labelsizeForLog.height + labelsizeForMsg.height + 20)] autorelease];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    
    UILabel *lineLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 12, 260, labelsizeForLog.height)];
    lineLable.lineBreakMode = UILineBreakModeWordWrap;
    lineLable.numberOfLines = 0;
    lineLable.textColor = [UIColor whiteColor];
    lineLable.backgroundColor = [UIColor clearColor];
    lineLable.text = self.lastVersionInfo.changeLog;
    lineLable.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:lineLable];
    [lineLable release];
    
    UILabel *lineLableforMsg=[[UILabel alloc] initWithFrame:CGRectMake(0, 12+labelsizeForLog.height+5, 260, labelsizeForMsg.height)];
    lineLableforMsg.lineBreakMode = UILineBreakModeWordWrap;
    lineLableforMsg.numberOfLines = 0;
    lineLableforMsg.textColor = [UIColor whiteColor];
    lineLableforMsg.backgroundColor = [UIColor clearColor];
    lineLableforMsg.text = titleForMsg;
    lineLableforMsg.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:lineLableforMsg];
    [lineLableforMsg release];

    
    [self insertSubview:self.contentView atIndex:0];
    
    [self setNeedsLayout];
   
}

- (void)dealloc {

    [contentView release];

    [super dealloc];
    
}



@end
