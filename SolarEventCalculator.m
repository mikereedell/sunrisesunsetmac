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
    return [self divide:[location longitude] by:[NSDecimalNumber decimalNumberWithString: @"15"]];
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
    return [interim decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:@"3.289"]];
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
    NSDecimalNumber *rightAscension =  [self decimalNumberFromDouble:atan([[self convertDegreesToRadians:innerParams] doubleValue])];
    rightAscension = [self setScale:rightAscension];
    
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
    return [self divide:[rightAscension decimalNumberByAdding:augend] by:[NSDecimalNumber decimalNumberWithString:@"15"]];
}


//Utility Methods
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
    return [multiplicand decimalNumberByMultiplyingBy:multiplier withBehavior: [self getHandler]];
}

- (NSDecimalNumber *) divide:(NSDecimalNumber *)dividend by:(NSDecimalNumber *)divisor {
    return [dividend decimalNumberByDividingBy: divisor withBehavior: [self getHandler]];
}

- (NSDecimalNumberHandler *) getHandler {
    return [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:(short)4 raiseOnExactness:false raiseOnOverflow:false raiseOnUnderflow:false raiseOnDivideByZero:true];
}

- (NSDecimalNumber *) decimalNumberFromDouble:(double)number {
    return (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:number];
}

- (NSDecimalNumber *) setScale:(NSDecimalNumber *)number {
    return [self multiply:number by:[NSDecimalNumber one]];
}

@end
