//
//  ImageLocationManager.h
//  connectivity
//
//  Created by 刘永生 on 2019/7/24.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>


NS_ASSUME_NONNULL_BEGIN

@interface ImageLocationManager : NSObject

+ (void)startLocationWithSuccessBlock:(void (^)(NSArray<CLLocation *> *))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

@end

NS_ASSUME_NONNULL_END
