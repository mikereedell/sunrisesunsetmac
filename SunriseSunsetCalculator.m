#import "SunriseSunsetCalculator.h"

@implementation SunriseSunsetCalculator

- (id) initWithLocation:(Location *)locationArg {
    [super init];
    location = locationArg;
    return self;
}

- (NSString *)getCivilSunriseForDate:(NSCalendarDate *) date {
    return nil;
}

- (NSString *)getCivilSunsetForDate:(NSCalendarDate *) date {
    return nil;
}

- (Location *)location {
    return location;
}

@end
