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

@end

@implementation AC360TableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setAutoPlayObserver];
    }
    return self;
}

- (void)setAutoPlayObserver
{
    if (_autoPlayLink == nil) {
        _autoPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(checkPositionOnScreen)];
        _autoPlayLink.preferredFramesPerSecond = 1;   // 刷新频率
        [_autoPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)prepareForReuse
{
    [_autoPlayLink invalidate];
    
    [super prepareForReuse];
}

- (void)checkPositionOnScreen
{
    ACGLKViewControllerPriority priority = [self positionOnScreen];
    
    if (priority == ACGLKViewControllerPriorityHigh) { // 屏幕顶部 && 轮播图
        if (priority >= [ACGLKViewController shareController].currentPriority) {
            
            [ACGLKViewController shareController].currentPriority = priority;
        }
    }
    else if (priority == ACGLKViewControllerPriorityNormal) { //在屏幕正中
        if (priority >= [ACGLKViewController shareController].currentPriority)
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(centerOnScreen:bitMapImage:)])
            {
                [self.delegate centerOnScreen:self bitMapImage:[UIImage imageNamed:@"pano_sphere2.jpg"]];
            }
            [ACGLKViewController shareController].currentPriority = priority;
        }
    }
    else if (priority == ACGLKViewControllerPriorityLow) {   // 超出屏幕外

        [ACGLKViewController shareController].currentPriority = priority;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(centerOnScreen:bitMapImage:)])
        {
            [self.delegate centerOnScreen:self bitMapImage:[UIImage imageNamed:@"pano_sphere2.jpg"]];
        }
        
    }
    else {
        // ACGLKViewControllerPriorityNone
    }
    
    if ([ACGLKViewController shareController].currentPriority == ACGLKViewControllerPriorityManual) {
//        [self checkPlayPosition];
    }
}

- (ACGLKViewControllerPriority)positionOnScreen
{
    UIView *window = [UIApplication sharedApplication].keyWindow;
    CGPoint origin = [window convertPoint:self.frame.origin fromView:self.superview];
    CGPoint center = [self.superview convertPoint:self.center toView:window];
    CGFloat viewCenterY = window.center.y;
    NSLog(@"%@",NSStringFromCGPoint(origin));
    
    if ((origin.y < 30 + headLineHeight && center.y > -5 + headLineHeight) && (center.x > 0 && center.x < window.bounds.size.width - 5)) {
        return ACGLKViewControllerPriorityHigh;
    }
    else if ( (viewCenterY < center.y + self.bounds.size.height * 0.5 && viewCenterY > center.y - self.bounds.size.height * 0.5) && (origin.x > 0 && origin.x <= window.bounds.size.width - 5)) {
        return ACGLKViewControllerPriorityNormal;
    }
    else if ((center.y <= -5 + headLineHeight || center.y > window.frame.size.height + 5) || (origin.x < 0 || origin.x >= window.bounds.size.width - 5)) {
        return ACGLKViewControllerPriorityLow;
    }
    else {
        return ACGLKViewControllerPriorityNone;
    }
}

@end
