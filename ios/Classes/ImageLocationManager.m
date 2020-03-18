//
//  ImageLocationManager.m
//  connectivity
//
//  Created by 刘永生 on 2019/7/24.
//

#import "ImageLocationManager.h"

@interface ImageLocationManager ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
/// 定位成功的回调block
@property (nonatomic, copy) void (^successBlock)(NSArray<CLLocation *> *);
/// 定位失败的回调block
@property (nonatomic, copy) void (^failureBlock)(NSError *error);

@property (nonatomic, assign) BOOL isFinish;/**< 定位完成 */

@end


@implementation ImageLocationManager

+ (instancetype)manager {
    static ImageLocationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.locationManager = [[CLLocationManager alloc] init];
        manager.locationManager.delegate = manager;
        [manager.locationManager requestWhenInUseAuthorization];
        
    });
    return manager;
}
+ (void)startLocationWithSuccessBlock:(void (^)(NSArray<CLLocation *> *))successBlock failureBlock:(void (^)(NSError *error))failureBlock {
    
    [ImageLocationManager manager].isFinish = NO;
    [[ImageLocationManager manager].locationManager startUpdatingLocation];
    [ImageLocationManager manager].successBlock = successBlock;
    [ImageLocationManager manager].failureBlock = failureBlock;
}

#pragma mark - CLLocationManagerDelegate

/// 地理位置发生改变时触发
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [manager stopUpdatingLocation];
    
    if (_successBlock && !_isFinish) {
        
        _isFinish = YES;
        _successBlock(locations);
    }
    
}

/// 定位失败回调方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位失败, 错误: %@",error);
    if (_failureBlock&& !_isFinish) {
        
        _isFinish = YES;
        _failureBlock(error);
    }
}


@end
