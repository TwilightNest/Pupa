// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
#import <MapboxCommon/MBXConfigurationServiceErrorCode_Internal.h>

NS_SWIFT_NAME(ConfigurationServiceError)
__attribute__((visibility ("default")))
@interface MBXConfigurationServiceError : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithCode:(MBXConfigurationServiceErrorCode)code
                             message:(nonnull NSString *)message;

@property (nonatomic, readonly) MBXConfigurationServiceErrorCode code;
@property (nonatomic, readonly, nonnull, copy) NSString *message;

@end
