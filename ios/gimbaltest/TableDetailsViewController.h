//
//  TableDetailsViewController.h
//  gimbaltest
//
//  Created by Jeremy Lizza on 1/5/14.
//  Copyright (c) 2014 Jeremy Lizza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FYX/FYX.h>
#import <FYX/FYXSightingManager.h>
#import <FYX/FYXTransmitter.h>

@interface TableDetailsViewController : UIViewController <FYXServiceDelegate,FYXSightingDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tableDetails;
- (IBAction)checkin:(id)sender;
- (IBAction)garcon:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *nav;
@property (weak, nonatomic) IBOutlet UIView *containerview;
@property (weak, nonatomic) IBOutlet UIButton *checkinbutton;
@property (weak, nonatomic) IBOutlet UILabel *sigstrength;

@end
