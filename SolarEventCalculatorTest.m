#import "SolarEventCalculatorTest.h"

@implementation SolarEventCalculatorTest

- (void) testGetBaseLongitudeHour {
    NSDecimalNumber *expectedBaseLongHour = [NSDecimalNumber decimalNumberWithString:@"-5.0523"];
    NSDecimalNumber *actualBaseLongHour = [[self getCalculator] getBaseLongitudeHour];
    
    STAssertEquals(NSOrderedSame, [expectedBaseLongHour compare:actualBaseLongHour], [self getAssertMessage:expectedBaseLongHour actual:actualBaseLongHour], nil);
}

- (void) testGetLongitudeHourForSunrise {
    SolarEventCalculator *calc = [self getCalculator];
    NSDate *date = [self getDate];
    
    NSDecimalNumber *expectedLongitudeHour = [NSDecimalNumber decimalNumberWithString:@"306.4605"];
    NSDecimalNumber *actualLongitudeHour = [calc getLongitudeHourForDate:date sunrise:true];
    STAssertEquals(NSOrderedSame, [expectedLongitudeHour compare:actualLongitudeHour], [actualLongitudeHour stringValue], nil);
}

- (void) testGetLongitudeHourForSunset {
    SolarEventCalculator *calc = [self getCalculator];
    NSDate *date = [self getDate];
    
    NSDecimalNumber *expectedLongitudeHour = [NSDecimalNumber decimalNumberWithString:@"306.9605"];
    NSDecimalNumber *actualLongitudeHour = [calc getLongitudeHourForDate:date sunrise:false];      
    STAssertEquals(NSOrderedSame, [expectedLongitudeHour compare:actualLongitudeHour], [actualLongitudeHour stringValue], nil);
}

- (void) testGetMeanAnomalyForSunrise {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDecimalNumber *expectedMeanAnomaly = [NSDecimalNumber decimalNumberWithString:@"298.7585"];
    NSDecimalNumber *actualMeanAnomaly = [calc getMeanAnomaly:[NSDecimalNumber decimalNumberWithString:@"306.4605"]];
    STAssertEquals(NSOrderedSame, [expectedMeanAnomaly compare:actualMeanAnomaly], [actualMeanAnomaly stringValue], nil);
}

- (void) testGetMeanAnomalyForSunset {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDecimalNumber *expectedMeanAnomaly = [NSDecimalNumber decimalNumberWithString:@"299.2513"];
    NSDecimalNumber *actualMeanAnomaly = [calc getMeanAnomaly:[NSDecimalNumber decimalNumberWithString:@"306.9605"]];
    STAssertEquals(NSOrderedSame, [expectedMeanAnomaly compare:actualMeanAnomaly], [actualMeanAnomaly stringValue], nil);    
}

- (void) testGetSunTrueLongitudeForSunrise {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDecimalNumber *expectedSunTrueLong = [NSDecimalNumber decimalNumberWithString:@"220.1965"];
    NSDecimalNumber *actualSunTrueLong = [calc getSunTrueLongitude:[NSDecimalNumber decimalNumberWithString:@"299.2513"]];
    STAssertEquals(NSOrderedSame, [expectedSunTrueLong compare:actualSunTrueLong], [actualSunTrueLong stringValue], nil);
}

- (void) testGetSunTrueLongitudeForSunset {
    SolarEventCalculator *calc = [self getCalculator];

    NSDecimalNumber *expectedSunTrueLong = [NSDecimalNumber decimalNumberWithString:@"219.6959"];
    NSDecimalNumber *actualSunTrueLong = [calc getSunTrueLongitude:[NSDecimalNumber decimalNumberWithString:@"298.7585"]];
    STAssertEquals(NSOrderedSame, [expectedSunTrueLong compare:actualSunTrueLong], [actualSunTrueLong stringValue], nil);
}

- (void) testGetRightAscensionForSunrise {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDecimalNumber *expectedRightAscension = [NSDecimalNumber decimalNumberWithString:@"37.2977"];
    NSDecimalNumber *actualRightAscension = [calc getRightAscension:[NSDecimalNumber decimalNumberWithString:@"220.1965"]];
    STAssertEquals(NSOrderedSame, [expectedRightAscension compare:actualRightAscension], [actualRightAscension stringValue], nil);
}

- (void) testGetRightAscensionForSunset {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDecimalNumber *expectedRightAscension = [NSDecimalNumber decimalNumberWithString:@""];
    NSDecimalNumber *actualRightAscension = [calc getRightAscension:[NSDecimalNumber decimalNumberWithString:@"219.6959"]];
    STAssertEquals(NSOrderedSame, [expectedRightAscension compare:actualRightAscension], [actualRightAscension stringValue], nil);    
}

//Utility Method Tests
- (void) testGetDayOfYear {
    NSDate *date = [self getDate];
    
    NSDecimalNumber *expectedDayOfYear = [NSDecimalNumber decimalNumberWithString:@"306"];
    NSDecimalNumber *actualDayOfYear = [[self getCalculator] getDayOfYearForDate:date];
    STAssertEquals(NSOrderedSame, [expectedDayOfYear compare:actualDayOfYear], [actualDayOfYear stringValue], nil);
}

- (void) testGetArcCosineFor {
    NSDecimalNumber *arcCosZero = [NSDecimalNumber decimalNumberWithString:@"1.5708"];
    NSDecimalNumber *actualArcCosZero = [[self getCalculator] getArcCosineFor:[NSDecimalNumber zero]];
    STAssertEquals(NSOrderedSame, [arcCosZero compare:actualArcCosZero], [actualArcCosZero stringValue], nil);
}

- (void) testConvertRadiansToDegrees {
    SolarEventCalculator *calc = [self getCalculator];
    NSDecimalNumber *oneDegreeInRadians = [calc convertRadiansToDegrees:[PI decimalNumberByDividingBy:ONE_EIGHTY]];
    STAssertEquals(NSOrderedSame, [[NSDecimalNumber decimalNumberWithString:@"1.0000"] compare:oneDegreeInRadians], [oneDegreeInRadians stringValue], nil);
}

- (void) testConvertDegreesToRadians {
    SolarEventCalculator *calc = [self getCalculator];
    NSDecimalNumber *oneRadianInDegrees = [calc convertDegreesToRadians:[ONE_EIGHTY decimalNumberByDividingBy:PI]];
    STAssertEquals(NSOrderedSame, [[NSDecimalNumber decimalNumberWithString:@"1.0000"] compare:oneRadianInDegrees], [oneRadianInDegrees stringValue], nil);
}

- (SolarEventCalculator *) getCalculator {   
    return [[SolarEventCalculator alloc] initWithLocation: [[Location alloc] initWithLatitude:@"39.9937" Longitude:@"-75.7850"]];
}

- (NSString *) getAssertMessage:(NSDecimalNumber *)expectedVal actual:(NSDecimalNumber *)actualVal {
    return [NSString stringWithFormat:@"Expected %d but was %d", [expectedVal decimalValue], [actualVal decimalValue]];
}

- (NSDate *) getDate {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:2008];
    [comps setMonth:11];
    [comps setDay:1];
    NSCalendar *cal = [NSCalendar currentCalendar];
    return [cal dateFromComponents:comps];
}

@end
