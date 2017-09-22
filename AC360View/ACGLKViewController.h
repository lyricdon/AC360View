//
//  ACGLKViewController.h
//  AC360View
//
//  Created by lyricdon on 2017/9/22.
//  Copyright © 2017年 modernmedia. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "PanoramaView.h"
#import "AC360TableViewCell.h"

typedef NS_ENUM(NSInteger, ACGLKViewControllerPriority) {
    ACGLKViewControllerPriorityNone = 0,
    ACGLKViewControllerPriorityLow,
    ACGLKViewControllerPriorityNormal,
    ACGLKViewControllerPriorityHigh,
    ACGLKViewControllerPriorityManual, // 手动点击优先度最高
};

@interface ACGLKViewController : GLKViewController <AC360TableViewCellDelegate>

@property (strong, nonatomic) PanoramaView *panoramaView;

@property (nonatomic, assign) ACGLKViewControllerPriority currentPriority;

+ (instancetype)shareController;

@end
