//
//  BillViewController.h
//  gimbaltest
//
//  Created by Jeremy Lizza on 1/5/14.
//  Copyright (c) 2014 Jeremy Lizza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *billDetails;
@property (weak, nonatomic) IBOutlet UILabel *total;
- (IBAction)pay:(id)sender;
- (IBAction)tipadded:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tipfield;
@property (weak, nonatomic) IBOutlet UILabel *subtotal;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *gesture;

@end
