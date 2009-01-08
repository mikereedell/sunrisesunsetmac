#import <SenTestingKit/SenTestingKit.h>
#import "SolarEventCalculator.h"

@interface SolarEventCalculatorTest : SenTestCase {

}

- (void) testGetBaseLongitudeHour;
- (void) testGetLongitudeHourForSunrise;
- (void) testGetLongitudeHourForSunset;
- (void) testGetDayOfYear;
- (void) testGetMeanAnomalyForSunrise;
- (void) testGetMeanAnomalyForSunset;
- (void) testGetSunTrueLongitudeForSunrise;
- (void) testGetSunTrueLongitudeForSunset;
- (void) testGetRightAscensionForSunset;
- (void) testGetRightAscensionForSunset;
- (void) testGetCosineSunLocalHourForSunrise;
- (void) testGetCosineSunLocalHourForSunset;
- (void) testGetLocalMeanTimeForSunset;
- (void) testGetLocalMeanTimeForSunrise;
- (void) testGetLocalTimeForSunrise;
- (void) testGetLocalTimeForSunset;
- (void) testGetLocalTimeAsStringForSunrise;
- (void) testGetLocalTimeAsStringForSunset;

- (void) testGetArcCosineFor;
- (void) testConvertRadiansToDegrees;
- (void) testConvertDegreesToRadians;
- (SolarEventCalculator *) getCalculator;
- (NSString *) getAssertMessage:(NSDecimalNumber *)expectedVal actual:(NSDecimalNumber *)actualVal;
- (NSDate *) getDate;

@end
