//
//  ACGLKViewController.m
//  AC360View
//
//  Created by lyricdon on 2017/9/22.
//  Copyright © 2017年 modernmedia. All rights reserved.
//

#import "ACGLKViewController.h"

@interface ACGLKViewController ()

@end

@implementation ACGLKViewController

+ (instancetype)shareController
{
    return [[self alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _panoramaView = [[PanoramaView alloc] initWithFrame:CGRectMake(50, 50, 300, 200)];
//    [_panoramaView setImageWithName:@"pano_sphere2.jpg"];
    [_panoramaView setOrientToDevice:YES];
    [_panoramaView setTouchToPan:YES];
    [_panoramaView setPinchToZoom:YES];
    [_panoramaView setShowTouches:NO];
    [_panoramaView setVRMode:NO];
    
    [self setView:_panoramaView];
}

-(void) glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [_panoramaView draw];
}

- (void)outOfScreen:(AC360TableViewCell *)cell bitMapImage:(UIImage *)image
{
    if (self.view.superview)
    {
        [self.view removeFromSuperview];
        [_panoramaView setImage:nil];
    }
}

- (void)centerOnScreen:(AC360TableViewCell *)cell bitMapImage:(UIImage *)image
{
    [_panoramaView setImage:image];
    [cell.contentView addSubview:self.view];
}


@end
