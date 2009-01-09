#import "SunriseSunsetCalculator.h"

@implementation SunriseSunsetCalculator : NSObject {
    Location *location;
    SolarEventCalculator *calculator;
}

- (id) initWithLocation:(Location *)locationArg {
    [super init];
    location = locationArg;
    return self;
}

- (id) initWithLocation:(Location *)locationArg TimeZoneIdentifier:(NSString *)timeZoneIdentifierArg {
    return nil;
}

- (NSString *) getAstronomicalSunriseForDate:(NSDate *) date {
    return [calculator computeSunriseTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"108"] sunriseDate:date];
}

- (NSString *) getAstronomicalSunsetForDate:(NSDate *) date {
    return [calculator computeSunsetTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"108"] sunsetDate:date];
}

- (NSString *) getNauticalSunriseForDate:(NSDate *) date {
    return [calculator computeSunriseTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"102"] sunriseDate:date];
}

- (NSString *) getNauticalSunsetForDate:(NSDate *) date {
    return [calculator computeSunsetTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"102"] sunsetDate:date];
}

- (NSString *) getCivilSunriseForDate:(NSDate *) date {
    return [calculator computeSunriseTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"96"] sunriseDate:date];
}

- (NSString *) getCivilSunsetForDate:(NSDate *) date {
    return [calculator computeSunsetTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"96"] sunsetDate:date];
}

- (NSString *) getOfficialSunriseForDate:(NSDate *) date {
    return [calculator computeSunriseTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"90.8333"] sunriseDate:date];
}

- (NSString *) getOfficialSunsetForDate:(NSDate *) date {
    return [calculator computeSunsetTimeForSolarZenith:[NSDecimalNumber decimalNumberWithString:@"90.8333"] sunsetDate:date];
}

- (Location *) location {
    return location;
}

@end
