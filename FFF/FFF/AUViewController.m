//
//  AUViewController.m
//  FFF
//
//  Created by Piotrek on 10.01.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import "AUViewController.h"


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
    
    ESTBeaconRegion* region = [[ESTBeaconRegion alloc] initRegionWithIdentifier:@"EstimoteSampleRegion"];
    
    [_beaconManager startMonitoringForRegion:region];
    [_beaconManager requestStateForRegion:region];
    [_beaconManager startRangingBeaconsInRegion:region];
}


-(void)beaconManager:(ESTBeaconManager *)manager
     didRangeBeacons:(NSArray *)beacons
            inRegion:(ESTBeaconRegion *)region {
    
    if([beacons count] > 0) {
        
        
        NSSortDescriptor * sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"rssi" ascending:NO];
        NSArray * sortedBeacons = [beacons sortedArrayUsingDescriptors:@[sortDescriptor]];
        
        ESTBeacon * beacon = [sortedBeacons firstObject];
        
        if (beacon.proximity == CLProximityNear) {
            [self.beaconLabel setText:[NSString stringWithFormat:@"Nearest beacon:\nMajor:%@\nMinor:%@\nDistance:%@",beacon.major, beacon.minor, beacon.distance]];
        }
    }
}
@end
