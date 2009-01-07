#import "SolarEventCalculator.h"

@implementation SolarEventCalculator

- (id) initWithLocation:(Location *)locationArg {
    [super init];
    location = locationArg;
    return self;
}

- (NSString *) computeSunriseTimeForSolarZenith:(NSDecimalNumber *)solarZenith sunriseDate:(NSCalendar *)date {
    return nil;
}

- (NSString *) computeSunsetTimeForSolarZenith:(NSDecimalNumber *)solarZenith sunsetDate:(NSCalendar *)date {
    return nil;
}

- (NSDecimalNumber *) getBaseLongitudeHour {
    return [self setScale:[self divide:[location longitude] by:[NSDecimalNumber decimalNumberWithString: @"15"]]];
}

- (NSDecimalNumber *) getLongitudeHourForDate:(NSDate *)date sunrise:(BOOL)isSunrise {
    NSDecimalNumber *offset = nil;
    if(isSunrise) {
        offset = [NSDecimalNumber decimalNumberWithString:@"6"];
    } else {
        offset = [NSDecimalNumber decimalNumberWithString:@"18"];
    }
    NSDecimalNumber *dividend = [offset decimalNumberBySubtracting:[self getBaseLongitudeHour]];
    NSDecimalNumber *addend = [self divide:dividend by:[NSDecimalNumber decimalNumberWithString:@"24"]];
    
    NSDecimalNumber *longHour = [[self getDayOfYearForDate:date] decimalNumberByAdding:addend withBehavior:[self getHandler]];
    return longHour;
}

- (NSDecimalNumber *) getMeanAnomaly:(NSDecimalNumber *)longitudeHour {
    NSDecimalNumber *interim = [self multiply:longitudeHour by:[NSDecimalNumber decimalNumberWithString:@"0.9856"]];
    return [self setScale:[interim decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:@"3.289"]]];
}

- (NSDecimalNumber *) getSunTrueLongitude:(NSDecimalNumber *)meanAnomaly {
    NSDecimalNumber *meanAnomalyInRads = [self convertDegreesToRadians:meanAnomaly];
    NSDecimalNumber *sinMeanAnomaly = [self decimalNumberFromDouble:(sin([meanAnomalyInRads doubleValue]))];
    
    NSDecimalNumber *doubleMeanAnomaly = [self multiply:meanAnomalyInRads by:[NSDecimalNumber decimalNumberWithString:@"2"]];
    NSDecimalNumber *sinDoubleMeanAnomaly = [self decimalNumberFromDouble:(sin([doubleMeanAnomaly doubleValue]))];
    
    NSDecimalNumber *firstPart = [meanAnomaly decimalNumberByAdding:[self multiply:sinMeanAnomaly by:[NSDecimalNumber decimalNumberWithString:@"1.916"]]];
    NSDecimalNumber *addend = [NSDecimalNumber decimalNumberWithString:@"282.634"];
    NSDecimalNumber *secondPart = [addend decimalNumberByAdding:[self multiply:sinDoubleMeanAnomaly by:[NSDecimalNumber decimalNumberWithString:@"0.020"]]];
    NSDecimalNumber *trueLongitude = [firstPart decimalNumberByAdding:secondPart];
    
    if([trueLongitude doubleValue] > 360) {
        trueLongitude = [trueLongitude decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:@"360"]];
    }
    return [self setScale:trueLongitude];
}

- (NSDecimalNumber *) getRightAscension:(NSDecimalNumber *)sunTrueLong {
    NSDecimalNumber *tanL = [self decimalNumberFromDouble:tan([[self convertDegreesToRadians:sunTrueLong] doubleValue])];

    NSDecimalNumber *innerParams = [self multiply:[self convertRadiansToDegrees:tanL] by:[NSDecimalNumber decimalNumberWithString:@"0.91764"]];
    NSDecimalNumber *rightAscension = [self convertRadiansToDegrees:[self decimalNumberFromDouble:atan([[self convertDegreesToRadians:innerParams] doubleValue])]];
    
    if([rightAscension doubleValue] < 0) {
        rightAscension = [rightAscension decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"360"]];
    } else if([rightAscension doubleValue] > 360) {
        rightAscension = [rightAscension decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:@"360"]];
    }
    
    NSDecimalNumber *longitudeQuadrant = [self decimalNumberFromDouble:floor([[self divide:sunTrueLong by:[NSDecimalNumber decimalNumberWithString:@"90"]] doubleValue])];
    longitudeQuadrant = [self multiply:longitudeQuadrant by:[NSDecimalNumber decimalNumberWithString:@"90"]];
    
    NSDecimalNumber *raQuadrant = [self decimalNumberFromDouble:floor([[self divide:rightAscension by:[NSDecimalNumber decimalNumberWithString:@"90"]] doubleValue])];
    raQuadrant = [self multiply:raQuadrant by:[NSDecimalNumber decimalNumberWithString:@"90"]];
    
    NSDecimalNumber *augend = [longitudeQuadrant decimalNumberBySubtracting:raQuadrant];
    return [self setScale:[self divide:[rightAscension decimalNumberByAdding:augend] by:[NSDecimalNumber decimalNumberWithString:@"15"]]];
}

- (NSDecimalNumber *) getCosineSunLocalHour:(NSDecimalNumber *)sunTrueLongitude forZenith:(NSDecimalNumber *)zenith {
    NSDecimalNumber *sinSunDeclination = [self getSinOfSunDeclination:sunTrueLongitude];
    NSDecimalNumber *cosineSunDeclination = [self getCosineOfSunDeclination:sinSunDeclination];
    
    NSDecimalNumber *zenithInRadians = [self convertDegreesToRadians:zenith];
    NSDecimalNumber *cosineZenith = [self decimalNumberFromDouble:cos([zenithInRadians doubleValue])];
    NSDecimalNumber *sinLatitude = [self decimalNumberFromDouble:sin([[self convertDegreesToRadians:[location latitude]] doubleValue])];
    NSDecimalNumber *cosineLatitude = [self decimalNumberFromDouble:cos([[self convertDegreesToRadians:[location latitude]] doubleValue])];
    
    NSDecimalNumber *dividend = [cosineZenith decimalNumberBySubtracting:[self multiply:sinSunDeclination by:sinLatitude]];
    return [self setScale:[self divide:dividend by:[self multiply:cosineSunDeclination by:cosineLatitude]]];
}

- (NSDecimalNumber *) getSunLocalHour:(NSDecimalNumber *)sunTrueLongitude forZenith:(NSDecimalNumber *)zenith forSunrise:(BOOL)isSunrise {
    NSDecimalNumber *sunLocalHour = [self convertRadiansToDegrees:[self getArcCosineFor:[self getCosineSunLocalHour:sunTrueLongitude forZenith:zenith]]];
    if(isSunrise) {
        sunLocalHour = [[NSDecimalNumber decimalNumberWithString:@"360"] decimalNumberBySubtracting:sunLocalHour];
    }
    return [self setScale:[self divide:sunLocalHour by:[NSDecimalNumber decimalNumberWithString:@"15"]]];
}


//Utility Methods
- (NSDecimalNumber *) getSinOfSunDeclination:(NSDecimalNumber *)sunTrueLongitude {
    double sinSunTrueLongitude = sin([[self convertDegreesToRadians:sunTrueLongitude] doubleValue]);
    return [self setScale:[self decimalNumberFromDouble:(sinSunTrueLongitude * 0.39782)]];
}

- (NSDecimalNumber *) getCosineOfSunDeclination:(NSDecimalNumber *)sinSunDeclination {
    return [self setScale:[self decimalNumberFromDouble:cos(asin([sinSunDeclination doubleValue]))]];
}

- (NSDecimalNumber *) getDayOfYearForDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    
    double n1 = floor((275 * [components month]) / 9);
    double n2 = floor(([components month] + 9) / 12);
    double n3 = (1 + floor(([components year] - 4 * floor([components year] / 4) + 2) / 3));
    double days = n1 - (n2 * n3) + [components day] - 30;
    return [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%1f", days]];
}

- (NSDecimalNumber *) getArcCosineFor:(NSDecimalNumber *)radians {
    double arcCosine = acos([radians doubleValue]);
    return [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%1.4f", arcCosine]];
}

- (NSDecimalNumber *) convertRadiansToDegrees:(NSDecimalNumber *)radians {
    NSDecimalNumber *oneRadianInDegrees = [ONE_EIGHTY decimalNumberByDividingBy:PI];    
    return [self multiply:radians by:oneRadianInDegrees];
}

- (NSDecimalNumber *) convertDegreesToRadians:(NSDecimalNumber *)degrees {
    NSDecimalNumber *oneDegreeInRadians = [PI decimalNumberByDividingBy:ONE_EIGHTY];
    return [self multiply:degrees by:oneDegreeInRadians];
}

- (NSDecimalNumber *) multiply:(NSDecimalNumber *)multiplicand by:(NSDecimalNumber *)multiplier {
    return [multiplicand decimalNumberByMultiplyingBy:multiplier];
}

- (NSDecimalNumber *) divide:(NSDecimalNumber *)dividend by:(NSDecimalNumber *)divisor {
    return [dividend decimalNumberByDividingBy: divisor];
}

- (NSDecimalNumberHandler *) getHandler {
    return [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:(short)4 raiseOnExactness:false raiseOnOverflow:false raiseOnUnderflow:false raiseOnDivideByZero:true];
}

- (NSDecimalNumber *) decimalNumberFromDouble:(double)number {
    return (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:number];
}

- (NSDecimalNumber *) setScale:(NSDecimalNumber *)number {
    return [number decimalNumberByMultiplyingBy:[NSDecimalNumber one] withBehavior:[self getHandler]];
}

@end
