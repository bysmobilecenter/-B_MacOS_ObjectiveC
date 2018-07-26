//
//  AppDelegate.m
//  macOS-oc
//
//  Created by bys on 23/01/2018.
//  Copyright © 2018 bys. All rights reserved.
//

#import "AppDelegate.h"
@import AppCenter;
@import AppCenterAnalytics;
@import AppCenterCrashes;
@import AppCenterPush;
@interface AppDelegate ()<MSPushDelegate,MSCrashesDelegate>

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    //[MSAppCenter setLogUrl:@"https://in-staging-south-centralus.staging.avalanch.es"];
    [MSPush setDelegate:self];
    [MSAppCenter start:@"24137b35-3bdb-498d-bbff-d3f9443c3055" withServices:@[ [MSAnalytics class], [MSCrashes class], [MSPush class]]];
    NSUUID *installId = [MSAppCenter  installId];
    NSString *deviceId = [installId UUIDString];
    MSCustomProperties *customProperties = [MSCustomProperties new];
    [customProperties setString:@"blue" forKey:@"color"];
    [customProperties setNumber:@(10) forKey:@"score"];
    [MSAppCenter setCustomProperties:customProperties];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)push:(MSPush *)push didReceivePushNotification:(MSPushNotification *)pushNotification {
    NSString *title = pushNotification.title ?: @"";
    NSString *message = pushNotification.message;
    NSMutableString *customData = nil;
    for (NSString *key in pushNotification.customData) {
        ([customData length] == 0) ? customData = [NSMutableString new] : [customData appendString:@", "];
        [customData appendFormat:@"%@: %@", key, [pushNotification.customData objectForKey:key]];
    }
    message = [NSString stringWithFormat:@"%@%@%@", (message ? message : @""), (message && customData ? @"\n" : @""),
               (customData ? customData : @"")];
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:title];
    [alert setInformativeText:message];
    [alert addButtonWithTitle:@"OK"];
    [alert runModal];
}
@end
