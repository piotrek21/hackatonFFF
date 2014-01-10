//
//  AUViewController.h
//  FFF
//
//  Created by Piotrek on 10.01.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ESTBeaconManager.h"

@interface AUViewController : UIViewController <ESTBeaconManagerDelegate>

@property IBOutlet UILabel * beaconLabel;

@end
