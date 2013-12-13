//
//  MultiViewController.m
//  XHShockHUD
//
//  Created by 曾 宪华 on 13-12-13.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "MultiViewController.h"

@interface MultiViewController ()

@end

@implementation MultiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)_loadMultiView {
    dispatch_async(dispatch_queue_create("load multiView", NULL), ^{
        NSArray *multiViews = [NSArray arrayWithObjects:@"UITableView", @"UIView", @"UIImageView", @"UILabel", @"UIScrollView", nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.huds = multiViews;
            [self.tableView reloadData];
        });
    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self _loadMultiView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.huds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor blackColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    NSString *className = self.huds[indexPath.row];
    cell.textLabel.text = className;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", className]];
    
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class class = NSClassFromString(self.huds[indexPath.row]);
    UIView *view = [[class alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.center = self.view.center;
    
    CGPoint moveVectorPoint = CGPointMake(0, -75);
    if ([view isKindOfClass:[UILabel class]]) {
        ((UILabel *)view).text = @"50";
        ((UILabel *)view).textColor = [UIColor yellowColor];
        ((UILabel *)view).textAlignment = UITextAlignmentCenter;
        [self.view showShockHUD:view duration:1.5 moveVector:moveVectorPoint];
        return;
    } else if ([view isKindOfClass:[UIImageView class]]) {
        ((UIImageView *)view).image = [UIImage imageNamed:@"5_1280x800.jpeg"];
    }
    
    [self.view showShockHUD:view backgroundColor:[UIColor colorWithRed:1.000 green:0.253 blue:0.349 alpha:1.000] duration:1.5 moveVector:moveVectorPoint];
}


@end
