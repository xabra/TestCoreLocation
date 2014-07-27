//
//  VAXViewController.m
//  TestCoreLocation
//
//  Created by Adam Brailove on 7/26/14.
//  Copyright (c) 2014 Vaxis Technologies. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "VAXViewController.h"




@interface VAXViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lattitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *altitudeLabel;

@end

@implementation VAXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.lattitudeLabel.text = @"This is your lattitude (deg)";
    self.longitudeLabel.text = @"This is your longitude (deg)";
    self.altitudeLabel.text = @"This is your altitude (deg)";
    [self setupLocationManager];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLocationManager {
    // Create the location manager object
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
    //self.stateString = NSLocalizedString(@"Tracking", @"Tracking");
    //[self.tableView reloadData];
    //UIBarButtonItem *resetItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Reset", @"Reset") style:UIBarButtonItemStyleBordered target:self action:@selector(reset)] autorelease];
    //[self.navigationItem setLeftBarButtonItem:resetItem animated:YES];;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //Get a reference to the last (most recent) item in location array
    CLLocation* newLocation = (CLLocation*) locations.lastObject;
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) return;
    // test the age of the location measurement to determine if the measurement is cached
    // in most cases you will not want to rely on cached measurements
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) return;
    // update the display with the new location data
    
    NSString *latString = (newLocation.coordinate.latitude < 0) ? @"S": @"N";
    NSString *lonString = (newLocation.coordinate.longitude < 0) ? @"W":  @"E";

    self.lattitudeLabel.text = [NSString stringWithFormat:@"Lattitude: %3.4f deg %@", fabs(newLocation.coordinate.latitude), latString];
    self.longitudeLabel.text = [NSString stringWithFormat:@"Longitude: %3.4f deg %@", fabs(newLocation.coordinate.longitude), lonString];
    self.altitudeLabel.text = [NSString stringWithFormat:@"Altitude: %3.4f meters", fabs(newLocation.altitude)];
}

@end
