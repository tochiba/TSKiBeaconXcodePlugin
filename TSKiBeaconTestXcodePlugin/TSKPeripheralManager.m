//
//  TSKPeripheralManager.m
//  TSKiBeaconTestXcodePlugin
//
//  Created by 千葉 俊輝 on 2014/03/08.
//  Copyright (c) 2014年 Toshiki Chiba. All rights reserved.
//

#import "TSKPeripheralManager.h"
#import "BLCBeaconAdvertisementData.h"

@interface TSKPeripheralManager()
@property (nonatomic) NSUUID *proximityUUID;
@property (nonatomic) CBPeripheralManager *peripheralManager;
@end

static TSKPeripheralManager *_sharedManager = nil;

// UUID
static NSString *const mStringUUID = @"";
// major
static const unsigned short int mMajor = 0;
// minor
static const unsigned short int mMinor = 0;
// measurePower
static const int mMeasurePower = 0;

@implementation TSKPeripheralManager

+ (TSKPeripheralManager *)sharedManager
{
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[TSKPeripheralManager alloc] init];
    });
    return _sharedManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        // 初期処理
        _proximityUUID = [[NSUUID alloc] initWithUUIDString:mStringUUID];
        _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    }
    return self;
}


#pragma mark - Public Methods
- (void)startAdvertising
{
    BLCBeaconAdvertisementData *beaconData = [[BLCBeaconAdvertisementData alloc] initWithProximityUUID:_proximityUUID
                                                                                                 major:mMajor
                                                                                                 minor:mMinor
                                                                                         measuredPower:mMeasurePower];
    [self.peripheralManager startAdvertising:beaconData.beaconAdvertisement];
}

- (void)stopAdvertising
{
    [self.peripheralManager stopAdvertising];
}

#pragma mark - CBPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOff:
            break;
        case CBPeripheralManagerStatePoweredOn:
            break;
        case CBPeripheralManagerStateResetting:
            break;
        case CBPeripheralManagerStateUnauthorized:
            break;
        case CBPeripheralManagerStateUnknown:
            break;
        case CBPeripheralManagerStateUnsupported:
            break;
        default:
            break;
    }
    
    if(peripheral.state == CBPeripheralManagerStatePoweredOn){
        [self startAdvertising];
    }
}
@end
