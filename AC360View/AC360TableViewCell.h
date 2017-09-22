//
//  AC360TableViewCell.h
//  AC360View
//
//  Created by lyricdon on 2017/9/18.
//  Copyright © 2017年 modernmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AC360TableViewCell;

@protocol AC360TableViewCellDelegate <NSObject>

- (void)centerOnScreen:(AC360TableViewCell *)cell bitMapImage:(UIImage *)image;
- (void)outOfScreen:(AC360TableViewCell *)cell;

@end

@interface AC360TableViewCell : UITableViewCell

@property (weak, nonatomic) id <AC360TableViewCellDelegate> delegate;

@end
