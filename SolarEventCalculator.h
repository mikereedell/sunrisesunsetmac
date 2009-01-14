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
- (NSString *) computeSunriseTimeForSolarZenith:(NSDecimalNumber *)solarZenith date:(NSDate *)date;
- (NSString *) computeSunsetTimeForSolarZenith:(NSDecimalNumber *)solarZenith date:(NSDate *)date;

//Computational methods
- (NSString *) computeSolarEventForSolarZenith:(NSDecimalNumber *)solarZenith date:(NSDate *)date isSunrise:(BOOL)isSunrise;
- (NSDecimalNumber *) getBaseLongitudeHour;
- (NSDecimalNumber *) getLongitudeHourForDate:(NSDate *)date sunrise:(BOOL)isSunrise;
- (NSDecimalNumber *) getMeanAnomaly:(NSDecimalNumber *)longitudeHour;
- (NSDecimalNumber *) getSunTrueLongitude:(NSDecimalNumber *)meanAnomaly;
- (NSDecimalNumber *) getRightAscension:(NSDecimalNumber *)sunTrueLong;
- (NSDecimalNumber *) getCosineSunLocalHour:(NSDecimalNumber *)sunTrueLongitude forZenith:(NSDecimalNumber *)zenith;
- (NSDecimalNumber *) getSunLocalHour:(NSDecimalNumber *)sunTrueLongitude forZenith:(NSDecimalNumber *)zenith forSunrise:(BOOL)isSunrise;
- (NSDecimalNumber *) getLocalMeanTime:(NSDecimalNumber *) sunTrueLongitude longitudeHour:(NSDecimalNumber *)longHour sunLocalHour:(NSDecimalNumber *)localHour;
- (NSDecimalNumber *) getLocalTime:(NSDecimalNumber *)localMeanTime forDate:(NSDate *)date;
- (NSString *) getLocalTimeAsString:(NSDecimalNumber *)localTime;

//Utility methods
- (NSDecimalNumber *) getDayOfYearForDate:(NSDate *) date;
- (NSDecimalNumber *) getSinOfSunDeclination:(NSDecimalNumber *)sunTrueLongitude;
- (NSDecimalNumber *) getCosineOfSunDeclination:(NSDecimalNumber *)sinSunDeclination;
- (NSDecimalNumber *) multiply:(NSDecimalNumber *)multiplicand by:(NSDecimalNumber *)multiplier;
- (NSDecimalNumber *) divide:(NSDecimalNumber *)dividend by:(NSDecimalNumber *)divisor;
- (NSDecimalNumberHandler *) getHandler:(short)scale;
- (NSDecimalNumber *) getArcCosineFor:(NSDecimalNumber *)radians;
- (NSDecimalNumber *) convertRadiansToDegrees:(NSDecimalNumber *)radians;
- (NSDecimalNumber *) convertDegreesToRadians:(NSDecimalNumber *)degrees;
- (NSDecimalNumber *) decimalNumberFromDouble:(double)number;
- (NSDecimalNumber *) setScale:(NSDecimalNumber *)number;

@end
