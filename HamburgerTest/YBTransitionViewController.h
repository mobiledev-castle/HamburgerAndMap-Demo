//
//  YBTransitionViewController.h
//  HamburgerTest
//
//  Created by Yurii.B on 7/25/14.
//  Copyright (c) 2014 YuriiBogdan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
@interface YBTransitionViewController : UITableViewController <ECSlidingViewControllerDelegate>
- (IBAction)menuButtonTapped:(id)sender;
@end
