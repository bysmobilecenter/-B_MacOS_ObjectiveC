//
//  ViewController.m
//  macOS-oc
//
//  Created by bys on 23/01/2018.
//  Copyright © 2018 bys. All rights reserved.
//

#import "ViewController.h"
@import AppCenter;
@import AppCenterAnalytics;
@import AppCenterCrashes;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)crash_track:(NSButton *)sender {
     [MSCrashes generateTestCrash];
}


- (IBAction)event1track:(NSButton *)sender {
    NSDictionary *properties = @{@"Category" : @"Music", @"FileName" : @"favorite.avi"};
    [MSAnalytics trackEvent:@"event1" withProperties: properties];
}

- (IBAction)event2_track:(NSButton *)sender {
    [MSAnalytics trackEvent:@"Event2"];
}
@end
