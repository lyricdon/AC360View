//
//  ViewController.m
//  AC360View
//
//  Created by lyricdon on 2017/9/18.
//  Copyright © 2017年 modernmedia. All rights reserved.
//

#import "ViewController.h"
#import "AC360TableViewCell.h"
#import "ACGLKViewController.h"

@interface ViewController ()

@property (nonatomic, strong) ACGLKViewController *GLKController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[AC360TableViewCell class] forCellReuseIdentifier:@"photoCell"];
    
    _GLKController = [ACGLKViewController shareController];
    [self addChildViewController:_GLKController];
    [_GLKController didMoveToParentViewController:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AC360TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoCell" forIndexPath:indexPath];
    cell.delegate = _GLKController;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

@end
