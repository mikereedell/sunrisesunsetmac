#import <Cocoa/Cocoa.h>
#import "Location.h"

#define ONE_EIGHTY [NSDecimalNumber decimalNumberWithString:@"180"]
#define PI [NSDecimalNumber decimalNumberWithString:@"3.14159265358979323846264338327950288419"]


@interface SolarEventCalculator : NSObject {
    Location *location;
    NSTimeZone *timeZone;
}

//Constructors
- (id) initWithLocation:(Location *)locationArg;
//- (id) initWithLocation:(Location *)locationArg timeZoneIdentifier:(NSString *)timeZoneIdentifier;

// "Public" methods
- (NSString *) computeSunriseTimeForSolarZenith:(NSDecimalNumber *)solarZenith sunriseDate:(NSCalendar *)date;
- (NSString *) computeSunsetTimeForSolarZenith:(NSDecimalNumber *)solarZenith sunsetDate:(NSCalendar *)date;

//Computational methods
- (NSDecimalNumber *) getBaseLongitudeHour;
- (NSDecimalNumber *) getLongitudeHourForDate:(NSDate *)date sunrise:(BOOL)isSunrise;
- (NSDecimalNumber *) getMeanAnomaly:(NSDecimalNumber *)longitudeHour;
- (NSDecimalNumber *) getSunTrueLongitude:(NSDecimalNumber *)meanAnomaly;
- (NSDecimalNumber *) getRightAscension:(NSDecimalNumber *)sunTrueLong;
- (NSDecimalNumber *) getCosineSunLocalHour:(NSDecimalNumber *)sunTrueLongitude forZenith:(NSDecimalNumber *)zenith;
- (NSDecimalNumber *) getSunLocalHour:(NSDecimalNumber *)sunTrueLongitude forZenith:(NSDecimalNumber *)zenith forSunrise:(BOOL)isSunrise;
    
//Utility methods
- (NSDecimalNumber *) getDayOfYearForDate:(NSDate *) date;
- (NSDecimalNumber *) getSinOfSunDeclination:(NSDecimalNumber *)sunTrueLongitude;
- (NSDecimalNumber *) getCosineOfSunDeclination:(NSDecimalNumber *)sinSunDeclination;
- (NSDecimalNumber *) multiply:(NSDecimalNumber *)multiplicand by:(NSDecimalNumber *)multiplier;
- (NSDecimalNumber *) divide:(NSDecimalNumber *)dividend by:(NSDecimalNumber *)divisor;
- (NSDecimalNumberHandler *) getHandler;
- (NSDecimalNumber *) getArcCosineFor:(NSDecimalNumber *)radians;
- (NSDecimalNumber *) convertRadiansToDegrees:(NSDecimalNumber *)radians;
- (NSDecimalNumber *) convertDegreesToRadians:(NSDecimalNumber *)degrees;
- (NSDecimalNumber *) decimalNumberFromDouble:(double)number;
- (NSDecimalNumber *) setScale:(NSDecimalNumber *)number;

@end
