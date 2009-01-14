#import "SunriseSunsetCalculator.h"

@implementation SunriseSunsetCalculator : NSObject {
    Location *location;
    SolarEventCalculator *calculator;
}

- (id) initWithLocation:(Location *)locationArg {
    [super init];
    location = locationArg;
    calculator = [[SolarEventCalculator alloc] initWithLocation:location];
    return self;
}

- (id) initWithLocation:(Location *)locationArg TimeZoneIdentifier:(NSString *)timeZoneIdentifierArg {
    return nil;
}

- (NSString *) getAstronomicalSunriseForDate:(NSDate *) date {
    return [calculator computeSunriseTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"108"] date:date];
}

- (NSString *) getAstronomicalSunsetForDate:(NSDate *) date {
    return [calculator computeSunsetTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"108"] date:date];
}

- (NSString *) getNauticalSunriseForDate:(NSDate *) date {
    return [calculator computeSunriseTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"102"] date:date];
}

- (NSString *) getNauticalSunsetForDate:(NSDate *) date {
    return [calculator computeSunsetTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"102"] date:date];
}

- (NSString *) getCivilSunriseForDate:(NSDate *) date {
    return [calculator computeSunriseTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"96"] date:date];
}

- (NSString *) getCivilSunsetForDate:(NSDate *) date {
    return [calculator computeSunsetTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"96"] date:date];
}

- (NSString *) getOfficialSunriseForDate:(NSDate *) date {
    return [calculator computeSunriseTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"90.8333"] date:date];
}

- (NSString *) getOfficialSunsetForDate:(NSDate *) date {
    return [calculator computeSunsetTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"90.8333"] date:date];
}

- (Location *) location {
    return location;
}

@end
