//
//  TableDetailsViewController.m
//  gimbaltest
//
//  Created by Jeremy Lizza on 1/5/14.
//  Copyright (c) 2014 Jeremy Lizza. All rights reserved.
//

#import "TableDetailsViewController.h"
#import <FYX/FYXSightingManager.h>
#import <FYX/FYXTransmitter.h>

@interface TableDetailsViewController ()
@property (nonatomic) FYXSightingManager *sightingManager;
@property BOOL checkedIn;
@property (nonatomic) FYXTransmitter *closestTransmitter;
@property (nonatomic) int closestRSSI;
@property (nonatomic) NSDate *dateRecorded;

@end

@implementation TableDetailsViewController

@synthesize tableDetails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [FYX startService:self];
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:[NSNumber numberWithInt:FYXSightingOptionSignalStrengthWindowNone]
                forKey:FYXSightingOptionSignalStrengthWindowKey];
    self.closestTransmitter = [[FYXTransmitter alloc] init];
    self.closestRSSI = 0;
    self.dateRecorded = [NSDate date];
    self.sightingManager = [[FYXSightingManager alloc] init];
    self.sightingManager.delegate = self;
    [self.sightingManager scanWithOptions:options];
    _checkedIn = NO;
    [tableDetails setText:@""];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"header_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:)forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 12, 20)];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
    
}

- (void) buttonAction: (id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)serviceStarted
{
    // this will be invoked if the service has successfully started
    // bluetooth scanning will be started at this point.
    NSLog(@"FYX Service Successfully Started");
}

- (void)startServiceFailed:(NSError *)error
{
    // this will be called if the service has failed to start
    NSLog(@"%@", error);
}

- (void)didReceiveSighting:(FYXTransmitter *)transmitter time:(NSDate *)time RSSI:(NSNumber *)RSSI
{
    // this will be invoked when an authorized transmitter is sighted

    if([self.dateRecorded timeIntervalSinceNow] < -15 && !_checkedIn) {
        self.closestRSSI = 0;
        self.closestTransmitter = nil;
        self.dateRecorded = [NSDate date];
    }
    
    if ((self.closestRSSI == 0 || self.closestRSSI > [RSSI intValue]) && !_checkedIn) {
        self.closestTransmitter = transmitter;
        self.closestRSSI = [RSSI intValue];
        [self.tableDetails setText:[NSString stringWithFormat:@"%@", transmitter.name]];
        [self.sigstrength setText:[NSString stringWithFormat:@"%d", [RSSI intValue]]];
         self.dateRecorded = [NSDate date];
    }
}

- (IBAction)checkin:(id)sender {
    _checkedIn = YES;
    self.containerview.hidden = NO;
    [self.checkinbutton setTitle:@"Change Table" forState:UIControlStateNormal];
    [self.sightingManager stopScan];
}

- (IBAction)garcon:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Summoning Assistance"
                                                        message:@"\n"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(139.5, 75.5); // .5 so it doesn't blur
    [alertView addSubview:spinner];
    [spinner startAnimating];
    [alertView show];
    [self performSelector:@selector(dismissAlert:) withObject:alertView afterDelay:5.0];

}

-(void) dismissAlert:(UIAlertView *)alert {
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}
@end
