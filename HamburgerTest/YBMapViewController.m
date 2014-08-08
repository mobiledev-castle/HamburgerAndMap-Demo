//
//  YBMapViewController.m
//  HamburgerTest
//
//  Created by Yurii.B on 7/25/14.
//  Copyright (c) 2014 YuriiBogdan. All rights reserved.
//

#import "YBMapViewController.h"

#import <MapKit/MapKit.h>
#import "YBAppDelegate.h"
#import "PlaceMark.h"

@interface YBMapViewController () <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end

@implementation YBMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.showsUserLocation = YES;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([YBAppDelegate sharedDelegate].userLocation.coordinate, 250, 250);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = [YBAppDelegate sharedDelegate].userLocation.coordinate;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    [self.mapView addAnnotation:point];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MapViewDelegate
- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    NSLog(@"viewForAnnotation");
    
    MKAnnotationView *pinView = [self returnPointView:annotation.coordinate andTitle:annotation.title andColor:MKPinAnnotationColorGreen];
    return pinView;
}

-(MKAnnotationView*) returnPointView: (CLLocationCoordinate2D) location andTitle: (NSString*) title andColor: (int) color{
    /*Method that acts as a point-generating machine. Takes the parameters of the location, the title, and the color of the
     pin, and it returns a view that holds the pin with those specified details*/
    
    MKPointAnnotation *resultPin = [[MKPointAnnotation alloc] init];
    MKPinAnnotationView *result = [[MKPinAnnotationView alloc] initWithAnnotation:resultPin reuseIdentifier:Nil];
    [resultPin setCoordinate:location];
    resultPin.title = title;
    result.pinColor = color;
    return result;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    NSLog(@"didAddAnnotationViews");
    for (MKAnnotationView *view in views){
        if ([[view annotation] isKindOfClass:[MKUserLocation class]]){
            
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([[view annotation] coordinate] , 250, 250);
            
            [mapView setRegion:region animated:YES];
        }
    }
}

- (void) showUserLocation
{
	CLLocation* userLoc = self.mapView.userLocation.location;
	CLLocationCoordinate2D userCoord = userLoc.coordinate;
	PlaceMark *pin = [[PlaceMark alloc] initWithCoordinate: userCoord];
	[self.mapView addAnnotation: pin];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
