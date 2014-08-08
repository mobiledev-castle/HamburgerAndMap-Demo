
#import "PlaceMark.h"

@implementation PlaceMark

@synthesize coordinate = mCoordinate;
@synthesize tag;
@synthesize line1;
@synthesize line2;
@synthesize line3;
@synthesize image;
@synthesize strThumbUrl;
@synthesize index;
//@synthesize item;

- (NSString *)subtitle
{
	return @" ";
}

- (NSString *)title
{
	return @" ";
}

- (id) init
{
	line1 = @"";
	line2 = @"";
	line3 = @"";
    strThumbUrl = @"";
	return self;
}

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
	mCoordinate = coordinate;
	
	return self;
}


@end