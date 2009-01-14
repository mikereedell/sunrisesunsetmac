#import "SunriseSunsetCalculatorTest.h"


@implementation SunriseSunsetCalculatorTest : SenTestCase {
    SunriseSunsetCalculator *calc;
    NSDate *date;
}

- (void) setUp {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:2008];
    [comps setMonth:11];
    [comps setDay:1];
    NSCalendar *cal = [NSCalendar currentCalendar];
    date = [cal dateFromComponents:comps];
    
    calc = [[SunriseSunsetCalculator alloc] initWithLocation: [[Location alloc] initWithLatitude:@"39.9937" Longitude:@"-75.7850"]];
}

- (void) tearDown {
}

- (void) testGetAstronomicalSunrise {
    NSString *actual = [calc getAstronomicalSunriseForDate:date];
    STAssertTrue([@"06:01" isEqual:actual], @"Wrong time: %@", actual);
}

- (void) testGetAstronomicalSunset {
    NSString *actual = [calc getAstronomicalSunsetForDate:date];
    STAssertTrue([@"19:32" isEqual:actual], @"Wrong time: %@", actual);
}

- (void) testGetNauticalSunrise {
    NSString *actual = [calc getNauticalSunriseForDate:date];
    STAssertTrue([@"06:33" isEqual:actual], actual, nil);
}

- (void) testGetNauticalSunset {
    NSString *actual = [calc getNauticalSunsetForDate:date];
    STAssertTrue([@"19:00" isEqual:actual], @"Wrong time: %@", actual);
}

- (void) testGetCivilSunrise {
    NSString *actual = [calc getCivilSunriseForDate:date];
    STAssertTrue([@"07:05" isEqual:actual], actual, nil);
}

- (void) testGetCivilSunset {
    NSString *actual = [calc getCivilSunsetForDate:date];
    STAssertTrue([@"18:28" isEqual:actual],  @"Wrong time: %@", actual);
}

- (void) testGetOfficialSunrise {
    NSString *actual = [calc getOfficialSunriseForDate:date];
    STAssertTrue([@"07:33" isEqual:actual], actual, nil);
}

- (void) testGetOfficialSunset {
    NSString *actual = [calc getOfficialSunsetForDate:date];
    STAssertTrue([@"18:00" isEqual:actual], @"Wrong time: %@", actual);
}

@end
