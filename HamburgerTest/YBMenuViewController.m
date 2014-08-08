//
//  YBMenuViewController.m
//  HamburgerTest
//
//  Created by Yurii.B on 7/25/14.
//  Copyright (c) 2014 YuriiBogdan. All rights reserved.
//

#import "YBMenuViewController.h"

#import "UIViewController+ECSlidingViewController.h"
#import "MEDynamicTransition.h"

@interface YBMenuViewController ()
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) UINavigationController *transitionsNavigationController;
@property (nonatomic, strong) UINavigationController *settingsNavigationController;
@property (nonatomic, strong) MEDynamicTransition *dynamicTransition;
@end

@implementation YBMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // topViewController is the transitions navigation controller at this point.
    // It is initially set as a User Defined Runtime Attributes in storyboards.
    // We keep a reference to this instance so that we can go back to it without losing its state.
    if (!_dynamicTransition)
        _dynamicTransition = [[MEDynamicTransition alloc] init];
    
    self.transitionsNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
    self.slidingViewController.delegate = _dynamicTransition;
//    self.dynamicTransition.slidingViewController = self.slidingViewController;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark - Properties

- (NSArray *)menuItems {
    if (_menuItems) return _menuItems;
    
    _menuItems = @[@"Transitions", @"Map"];
    
    return _menuItems;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *menuItem = self.menuItems[indexPath.row];
    
    cell.textLabel.text = menuItem;
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *menuItem = self.menuItems[indexPath.row];
    
    // This undoes the Zoom Transition's scale because it affects the other transitions.
    // You normally wouldn't need to do anything like this, but we're changing transitions
    // dynamically so everything needs to start in a consistent state.
    self.slidingViewController.topViewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
    
    if ([menuItem isEqualToString:@"Transitions"]) {
        self.slidingViewController.topViewController = self.transitionsNavigationController;
    } else if ([menuItem isEqualToString:@"Map"]) {
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"YBSettingNavigationController"];
    }
    [self.slidingViewController resetTopViewAnimated:YES];
}

@end