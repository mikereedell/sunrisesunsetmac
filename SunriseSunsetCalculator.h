#import <Cocoa/Cocoa.h>
#import "Location.h"
#import "SolarEventCalculator.h"

@interface SunriseSunsetCalculator : NSObject {
    Location *location;
    SolarEventCalculator *calculator;
}

//Method declarations go here.
- (id) initWithLocation:(Location *)locationArg;
- (id) initWithLocation:(Location *)locationArg TimeZoneIdentifier:(NSString *)timeZoneIdentifierArg;
- (NSString *) getAstronomicalSunriseForDate:(NSDate *)date;
- (NSString *) getAstronomicalSunsetForDate:(NSDate *)date;
- (NSString *) getNauticalSunriseForDate:(NSDate *)date;
- (NSString *) getNauticalSunsetForDate:(NSDate *)date;
- (NSString *) getCivilSunriseForDate:(NSDate *)date;
- (NSString *) getCivilSunsetForDate:(NSDate *)date;
- (NSString *) getOfficialSunriseForDate:(NSDate *)date;
- (NSString *) getOfficialSunsetForDate:(NSDate *)date;
- (Location *) location;

@end
