#import <Cocoa/Cocoa.h>
#import "Location.h"

@interface SunriseSunsetCalculator : NSObject {
    //Members go here
    Location *location;
  //  SolarEventCalculator *calculator;
}

//Method declarations go here.
- (id) initWithLocation:(Location *) locationArg;
//- (id) initWithLocation:(Location *) locationArg TimeZoneIdentifier:(NSString *)timeZoneIdentifierArg;
//- (NSString *) getAstronomicalSunriseForDate:(NSCalendarDate *) date;
//- (NSString *) getAstronomicalSunsetForDate:(NSCalendarDate *) date;
//- (NSString *) getNauticalSunriseForDate:(NSCalendarDate *) date;
//- (NSString *) getNauticalSunsetForDate:(NSCalendarDate *) date;
- (NSString *) getCivilSunriseForDate:(NSCalendarDate *) date;
- (NSString *) getCivilSunsetForDate:(NSCalendarDate *) date;
//- (NSString *) getOfficialSunriseForDate:(NSCalendarDate *) date;
//- (NSString *) getOfficialSunsetForDate:(NSCalendarDate *) date;

- (Location *) location;

@end
