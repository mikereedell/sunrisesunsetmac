#import "Location.h"

@implementation Location

- (id) initWithLatitude:(NSString *)latitudeArg Longitude:(NSString *)longitudeArg {
    [super init];
    latitude = [[NSDecimalNumber alloc] initWithString:latitudeArg];
    longitude = [[NSDecimalNumber alloc] initWithString:longitudeArg];
    
    return self;
}

- (NSDecimalNumber *) latitude {
    return latitude;
}

- (NSDecimalNumber *) longitude {
    return longitude;
}

@end
