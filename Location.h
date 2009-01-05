#import <Cocoa/Cocoa.h>


@interface Location : NSObject {
    NSDecimalNumber *latitude;
    NSDecimalNumber *longitude;
}

- (id) initWithLatitude: (NSString *)latitudeArg Longitude: (NSString *)longitudeArg;
- (NSDecimalNumber *) latitude;
- (NSDecimalNumber *) longitude;

@end
