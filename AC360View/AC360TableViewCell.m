//
//  AC360TableViewCell.m
//  AC360View
//
//  Created by lyricdon on 2017/9/18.
//  Copyright © 2017年 modernmedia. All rights reserved.
//

#import "AC360TableViewCell.h"
#import "ACGLKViewController.h"
#define headLineHeight 84

@interface AC360TableViewCell ()

@property (nonatomic, strong) CADisplayLink *autoPlayLink;
@property (nonatomic, assign) BOOL isShowing;

@end

@implementation AC360TableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setAutoPlayObserver];
        self.isShowing = NO;
    }
    return self;
}

- (void)setAutoPlayObserver
{
    _autoPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(checkPositionOnScreen)];
    _autoPlayLink.preferredFramesPerSecond = 1;   // 刷新频率
    [_autoPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)prepareForReuse
{
    [_autoPlayLink invalidate];
    self.isShowing = NO;
    
    [super prepareForReuse];
}

- (void)checkPositionOnScreen
{
    ACGLKViewControllerPriority priority = [self positionOnScreen];
    

    if(priority == ACGLKViewControllerPriorityHigh)
    {
        if (priority >= [ACGLKViewController shareController].currentPriority)
        {
            [ACGLKViewController shareController].currentPriority = priority;
            
            if (!self.isShowing)
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(centerOnScreen:bitMapImage:)])
                {
                    [self.delegate centerOnScreen:self bitMapImage:[UIImage imageNamed:@"pano_sphere2.jpg"]];
                }
                self.isShowing = YES;
            }
        }
    }
    else if (priority == ACGLKViewControllerPriorityNormal)
    {
        if (priority >= [ACGLKViewController shareController].currentPriority)
        {
            [ACGLKViewController shareController].currentPriority = priority;
            if (!self.isShowing)
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(centerOnScreen:bitMapImage:)])
                {
                    [self.delegate centerOnScreen:self bitMapImage:[UIImage imageNamed:@"pano_sphere2.jpg"]];
                }
                self.isShowing = YES;
            }
        }
        else
        {
            self.isShowing = NO;
        }
    }
    else
    {
        if (self.isShowing)
        {
            [ACGLKViewController shareController].currentPriority = priority;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(outOfScreen:)])
            {
                [self.delegate outOfScreen:self];
            }
        }
        
        self.isShowing = NO;
    }
    
    if ([ACGLKViewController shareController].currentPriority == ACGLKViewControllerPriorityManual)
    {
        
    }
}

- (void)setSource:(id)source
{
    [self setAutoPlayObserver];
}

- (ACGLKViewControllerPriority)positionOnScreen
{
    UIView *window = [UIApplication sharedApplication].keyWindow;
    CGPoint origin = [window convertPoint:self.frame.origin fromView:self.superview];
    CGPoint center = [self.superview convertPoint:self.center toView:window];
    CGFloat viewCenterY = window.center.y;
    NSLog(@"%@",NSStringFromCGPoint(origin));
    
    BOOL isCenter = (viewCenterY < center.y + self.bounds.size.height * 0.5 && viewCenterY > center.y - self.bounds.size.height * 0.5);
    BOOL isOut = (origin.y <= -self.frame.size.height || origin.y > window.frame.size.height);
    
    
    if (isCenter)
    {
        return ACGLKViewControllerPriorityHigh;
    }
    else if (isOut)
    {
        return ACGLKViewControllerPriorityNone;
    }
    else
    {
        return ACGLKViewControllerPriorityNormal;
    }
}

@end
