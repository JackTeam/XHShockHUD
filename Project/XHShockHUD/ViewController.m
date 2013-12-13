//
//  ViewController.m
//  XHShockHUD
//
//  Created by 曾 宪华 on 13-12-13.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

#pragma mark - Left cycle init

- (void)_loadHuds {
    dispatch_async(dispatch_queue_create("load HUDs", NULL), ^{
        NSArray *huds = [NSArray arrayWithObjects:@"CustomHUDViewController", @"XHUIKitViewController", @"MultiViewController", nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.huds = huds;
            [self.tableView reloadData];
        });
    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self _loadHuds];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"HUD组件", @"");
    
    
    [self.view showHUDWithText:@"只要是继承UIView的类，我们的HUD都可以在里面show出来，并且是你需要的，喜欢的，样式好的，欢迎大家来强大他" hudSize:CGSizeMake(250, 200) hudType:kXHHUDInfo animationType:kXHHUDFade delay:1.];
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
    }
    NSString *className = self.huds[indexPath.row];
    cell.textLabel.text = className;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", className]];
    
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class class = NSClassFromString(self.huds[indexPath.row]);
    id viewController = [[class alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
