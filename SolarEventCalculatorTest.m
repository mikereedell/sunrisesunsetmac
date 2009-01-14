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
    
    NSDecimalNumber *expectedSunTrueLong = [NSDecimalNumber decimalNumberWithString:@"219.6960"];
    NSDecimalNumber *actualSunTrueLong = [calc getSunTrueLongitude:[NSDecimalNumber decimalNumberWithString:@"298.7585"]];
    STAssertEquals(NSOrderedSame, [expectedSunTrueLong compare:actualSunTrueLong], [actualSunTrueLong stringValue], nil);
}

- (void) testGetSunTrueLongitudeForSunset {
    SolarEventCalculator *calc = [self getCalculator];

    NSDecimalNumber *expectedSunTrueLong = [NSDecimalNumber decimalNumberWithString:@"220.1966"];
    NSDecimalNumber *actualSunTrueLong = [calc getSunTrueLongitude:[NSDecimalNumber decimalNumberWithString:@"299.2513"]];
    STAssertEquals(NSOrderedSame, [expectedSunTrueLong compare:actualSunTrueLong], [actualSunTrueLong stringValue], nil);
}

- (void) testGetRightAscensionForSunrise {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDecimalNumber *expectedRightAscension = [NSDecimalNumber decimalNumberWithString:@"14.4865"];
    NSDecimalNumber *actualRightAscension = [calc getRightAscension:[NSDecimalNumber decimalNumberWithString:@"219.6959"]];
    STAssertEquals(NSOrderedSame, [expectedRightAscension compare:actualRightAscension], [actualRightAscension stringValue], nil);
}

- (void) testGetRightAscensionForSunset {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDecimalNumber *expectedRightAscension = [NSDecimalNumber decimalNumberWithString:@"14.5193"];
    NSDecimalNumber *actualRightAscension = [calc getRightAscension:[NSDecimalNumber decimalNumberWithString:@"220.1965"]];
    STAssertEquals(NSOrderedSame, [expectedRightAscension compare:actualRightAscension], [actualRightAscension stringValue], nil);    
}

- (void) testGetCosineSunLocalHourForSunrise {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDecimalNumber *expectedCosSunLocalHour = [NSDecimalNumber decimalNumberWithString:@"0.0793"];
    NSDecimalNumber *actualCosSunLocalHour = [calc getCosineSunLocalHour:[NSDecimalNumber decimalNumberWithString:@"219.6959"] forZenith:[NSDecimalNumber decimalNumberWithString:@"96"]];
    STAssertEquals(NSOrderedSame, [expectedCosSunLocalHour compare:actualCosSunLocalHour], [actualCosSunLocalHour stringValue], nil);
}

- (void) testGetCosineSunLocalHourForSunset {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDecimalNumber *expectedCosSunLocalHour = [NSDecimalNumber decimalNumberWithString:@"0.0817"];
    NSDecimalNumber *actualCosSunLocalHour = [calc getCosineSunLocalHour:[NSDecimalNumber decimalNumberWithString:@"220.1965"] forZenith:[NSDecimalNumber decimalNumberWithString:@"96"]];
    STAssertEquals(NSOrderedSame, [expectedCosSunLocalHour compare:actualCosSunLocalHour], [actualCosSunLocalHour stringValue], nil);    
}

- (void) testGetSunLocalHourForSunrise {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDecimalNumber *zenith = [NSDecimalNumber decimalNumberWithString:@"96"];
    NSDecimalNumber *sunTrueLongitude = [NSDecimalNumber decimalNumberWithString:@"219.6959"];
    
    NSDecimalNumber *expectedSunLocalHour = [NSDecimalNumber decimalNumberWithString:@"18.3033"];
    NSDecimalNumber *actualSunLocalHour = [calc getSunLocalHour:sunTrueLongitude forZenith:zenith forSunrise:true];
    STAssertEquals(NSOrderedSame, [expectedSunLocalHour compare:actualSunLocalHour], [actualSunLocalHour stringValue], nil);        
}

- (void) testGetSunLocalHourForSunset {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDecimalNumber *zenith = [NSDecimalNumber decimalNumberWithString:@"96"];
    NSDecimalNumber *sunTrueLongitude = [NSDecimalNumber decimalNumberWithString:@"220.1965"];
    
    NSDecimalNumber *expectedSunLocalHour = [NSDecimalNumber decimalNumberWithString:@"5.6876"];
    NSDecimalNumber *actualSunLocalHour = [calc getSunLocalHour:sunTrueLongitude forZenith:zenith forSunrise:false];
    STAssertEquals(NSOrderedSame, [expectedSunLocalHour compare:actualSunLocalHour], [actualSunLocalHour stringValue], nil);            
}

- (void) testGetLocalMeanTimeForSunrise {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDecimalNumber *sunTrueLongitude = [NSDecimalNumber decimalNumberWithString:@"219.6959"];
    NSDecimalNumber *longitudeHour = [NSDecimalNumber decimalNumberWithString:@"306.4605"];
    NSDecimalNumber *sunLocalHour = [NSDecimalNumber decimalNumberWithString:@"18.3033"];
    
    NSDecimalNumber *expectedLocalMeanTime = [NSDecimalNumber decimalNumberWithString:@"6.0303"];
    NSDecimalNumber *actualLocalMeanTime = [calc getLocalMeanTime:sunTrueLongitude longitudeHour:longitudeHour sunLocalHour:sunLocalHour];
    STAssertEquals(NSOrderedSame, [expectedLocalMeanTime compare:actualLocalMeanTime], [actualLocalMeanTime stringValue], nil);        
}

- (void) testGetLocalMeanTimeForSunset {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDecimalNumber *sunTrueLongitude = [NSDecimalNumber decimalNumberWithString:@"220.1965"];
    NSDecimalNumber *longitudeHour = [NSDecimalNumber decimalNumberWithString:@"306.9605"];
    NSDecimalNumber *sunLocalHour = [NSDecimalNumber decimalNumberWithString:@"5.6876"];
    
    NSDecimalNumber *expectedLocalMeanTime = [NSDecimalNumber decimalNumberWithString:@"17.4145"];
    NSDecimalNumber *actualLocalMeanTime = [calc getLocalMeanTime:sunTrueLongitude longitudeHour:longitudeHour sunLocalHour:sunLocalHour];
    STAssertEquals(NSOrderedSame, [expectedLocalMeanTime compare:actualLocalMeanTime], [actualLocalMeanTime stringValue], nil);
}

- (void) testGetLocalTimeForSunrise {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDecimalNumber *localMeanTime = [NSDecimalNumber decimalNumberWithString:@"6.0303"];
    NSDate *date = [self getDate];
    
    NSDecimalNumber *expectedLocalTime = [NSDecimalNumber decimalNumberWithString:@"7.0826"];
    NSDecimalNumber *actualLocalTime = [calc getLocalTime:localMeanTime forDate:date];
    STAssertEquals(NSOrderedSame, [expectedLocalTime compare:actualLocalTime], [actualLocalTime stringValue], nil);
}

- (void) testGetLocalTimeForSunset {
    SolarEventCalculator *calc = [self getCalculator];

    NSDecimalNumber *localMeanTime = [NSDecimalNumber decimalNumberWithString:@"17.4145"];
    NSDate *date = [self getDate];

    NSDecimalNumber *expectedLocalTime = [NSDecimalNumber decimalNumberWithString:@"18.4668"];
    NSDecimalNumber *actualLocalTime = [calc getLocalTime:localMeanTime forDate:date];
    STAssertTrue([expectedLocalTime isEqual:actualLocalTime], [actualLocalTime stringValue], nil);    
}

- (void) testGetLocalTimeAsStringForSunrise {
    SolarEventCalculator *calc = [self getCalculator];
        
    NSString *expectedLocalTime = @"07:05";
    NSString *actualLocalTime = [calc getLocalTimeAsString:[NSDecimalNumber decimalNumberWithString:@"7.0826"]];
    STAssertTrue([expectedLocalTime isEqual:actualLocalTime], actualLocalTime, nil);        
}

- (void) testGetLocalTimeAsStringForSunset {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSString *expectedLocalTime = @"18:28";
    NSString *actualLocalTime = [calc getLocalTimeAsString:[NSDecimalNumber decimalNumberWithString:@"18.4668"]];
    STAssertTrue([expectedLocalTime isEqual:actualLocalTime], @"Wrong time: %@", actualLocalTime);
}

- (void) testComputeSunriseTimeForSolarZenith {
    SolarEventCalculator *calc = [self getCalculator];
    
    NSDate *date = [self getDate];
    NSDecimalNumber *zenith = [NSDecimalNumber decimalNumberWithString:@"96"];
    
    NSString *expectedTime = @"07:05";
    NSString *actualTime = [calc computeSunriseTimeForSolarZenith:zenith date:date];
    STAssertTrue([expectedTime isEqual:actualTime], @"Wrong time: %@", actualTime);
}

- (void) testComputeSunsetTimeForSolarZenith {
    SolarEventCalculator *calc = [self getCalculator];

    NSDate *date = [self getDate];
    NSDecimalNumber *zenith = [NSDecimalNumber decimalNumberWithString:@"96"];
    
    NSString *expectedTime = @"18:28";
    NSString *actualTime = [calc computeSunsetTimeForSolarZenith:zenith date:date];
    STAssertTrue([expectedTime isEqual:actualTime], @"Wrong time: %@", actualTime);
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

// ***** Utility Methods *****
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
