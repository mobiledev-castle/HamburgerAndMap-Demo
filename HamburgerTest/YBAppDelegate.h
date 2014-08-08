//
//  YBAppDelegate.h
//  HamburgerTest
//
//  Created by Yurii.B on 7/25/14.
//  Copyright (c) 2014 YuriiBogdan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

@interface YBAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) CLLocation *userLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;

+ (YBAppDelegate*) sharedDelegate;

@end
