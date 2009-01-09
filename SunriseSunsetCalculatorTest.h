#import <SenTestingKit/SenTestingKit.h>
#import "SunriseSunsetCalculator.h"

@interface SunriseSunsetCalculatorTest : SenTestCase {
    SunriseSunsetCalculator *calc;
    NSDate *date;
}

- (void) setUp;
- (void) tearDown;
- (void) testGetAstronomicalSunrise;
- (void) testGetAstronomicalSunset;
- (void) testGetNauticalSunrise;
- (void) testGetNauticalSunset;
- (void) testGetCivilSunrise;
- (void) testGetCivilSunset;
- (void) testGetOfficialSunrise;
- (void) testGetOfficialSunset;

@end
