//
//  VAXViewController.h
//  TestCoreLocation
//
//  Created by Adam Brailove on 7/26/14.
//  Copyright (c) 2014 Vaxis Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VAXViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end
