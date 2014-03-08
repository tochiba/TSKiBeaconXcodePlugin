//
//  TSKPeripheralManager.h
//  TSKiBeaconTestXcodePlugin
//
//  Created by 千葉 俊輝 on 2014/03/08.
//  Copyright (c) 2014年 Toshiki Chiba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IOBluetooth/IOBluetooth.h>

@interface TSKPeripheralManager : NSObject <CBPeripheralManagerDelegate>
+ (TSKPeripheralManager *)sharedManager;
- (void)startAdvertising;
- (void)stopAdvertising;
@end
