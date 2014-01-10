//
//  AUViewController.m
//  FFF
//
//  Created by Piotrek on 10.01.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import "AUViewController.h"

#import "ESTBeaconManager.h"

@interface AUViewController () {
    ESTBeaconManager * _beaconManager;
}

@end

@implementation AUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _beaconManager = [[ESTBeaconManager alloc] init];
    _beaconManager.delegate = self;
    _beaconManager.avoidUnknownStateBeacons = YES;
    
    // create sample region with major value defined
    ESTBeaconRegion* region = [[ESTBeaconRegion alloc] initRegionWithMajor:1 minor:1 identifier: @"EstimoteSampleRegion"];
    
    // start looking for estimote beacons in region
    // when beacon ranged beaconManager:didEnterRegion:
    // and beaconManager:didExitRegion: invoked
    [_beaconManager startMonitoringForRegion:region];
    
    [_beaconManager requestStateForRegion:region];

	// Do any additional setup after loading the view, typically from a nib.
}


-(void)beaconManager:(ESTBeaconManager *)manager
     didRangeBeacons:(NSArray *)beacons
            inRegion:(ESTBeaconRegion *)region {
    
    if([beacons count] > 0) {
        
        NSSortDescriptor * sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"ibeacon.rssi" ascending:NO];
        NSArray * sortedBeacons = [beacons sortedArrayUsingDescriptors:@[sortDescriptor]];
        
        ESTBeacon * beacon = [sortedBeacons firstObject];
        
        if (beacon.proximity == CLProximityNear || beacon.proximity == CLProximityImmediate) {
            [self.beaconLabel setText:[NSString stringWithFormat:@"%@ %@",beacon.major, beacon.minor]];
        }
    }
}
@end
