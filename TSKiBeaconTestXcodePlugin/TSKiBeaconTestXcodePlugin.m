//
//  TSKiBeaconTestXcodePlugin.m
//  TSKiBeaconTestXcodePlugin
//
//  Created by 千葉 俊輝 on 2014/03/08.
//    Copyright (c) 2014年 Toshiki Chiba. All rights reserved.
//

#import "TSKiBeaconTestXcodePlugin.h"
#import "TSKPeripheralManager.h"

static TSKiBeaconTestXcodePlugin *sharedPlugin;

@interface TSKiBeaconTestXcodePlugin()

@property (nonatomic, strong) NSBundle *bundle;
@end

@implementation TSKiBeaconTestXcodePlugin

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static id sharedPlugin = nil;
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        self.bundle = plugin;
        NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Debug"];
        if (menuItem) {
            [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
            NSMenuItem *actionMenuItemStart = [[NSMenuItem alloc] initWithTitle:@"Start Advertising" action:@selector(p_startAdvertising) keyEquivalent:@"8"];
            actionMenuItemStart.keyEquivalentModifierMask = NSCommandKeyMask | NSShiftKeyMask;
            [actionMenuItemStart setTarget:self];
            [[menuItem submenu] addItem:actionMenuItemStart];

            NSMenuItem *actionMenuItemStop = [[NSMenuItem alloc] initWithTitle:@"Stop Advertising" action:@selector(p_stopAdvertising) keyEquivalent:@"9"];
            actionMenuItemStop.keyEquivalentModifierMask = NSCommandKeyMask | NSShiftKeyMask;
            [actionMenuItemStop setTarget:self];
            [[menuItem submenu] addItem:actionMenuItemStop];

        }
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private Method
- (void)p_startAdvertising
{
    NSAlert *alert = [NSAlert alertWithMessageText:@"Start Advertising" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
    [alert runModal];
    [[TSKPeripheralManager sharedManager] startAdvertising];
}

- (void)p_stopAdvertising
{
    NSAlert *alert = [NSAlert alertWithMessageText:@"Stop Advertising" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
    [alert runModal];
    [[TSKPeripheralManager sharedManager] stopAdvertising];
}

@end
