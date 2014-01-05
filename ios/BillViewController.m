//
//  BillViewController.m
//  gimbaltest
//
//  Created by Jeremy Lizza on 1/5/14.
//  Copyright (c) 2014 Jeremy Lizza. All rights reserved.
//

#import "BillViewController.h"

@interface BillViewController () <UIAlertViewDelegate>
@property (nonatomic) int billtotal;
@end

@implementation BillViewController

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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"header_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:)forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 12, 20)];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Loading"
                                           message:@"\n"
                                          delegate:self
                                 cancelButtonTitle:nil
                                 otherButtonTitles:nil];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(139.5, 75.5); // .5 so it doesn't blur
    [alertView addSubview:spinner];
    [spinner startAnimating];
    [alertView show];
	// Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"http://lizzard.selfip.com/api/Table/GetBill?billid=1"];
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    if(jsonData != nil)
    {
        NSError *error = nil;
        NSMutableDictionary *billDetails = [NSJSONSerialization
                                           JSONObjectWithData:jsonData
                                           options:NSJSONReadingMutableContainers
                                           error:&error];
    
        _billtotal = [billDetails[@"total"] intValue];
        NSLog(@"billtotal: %d", _billtotal);
        [self.total setText:[NSString stringWithFormat:@"$%@", billDetails[@"total"]]];
        [self.subtotal setText:[NSString stringWithFormat:@"$%@", billDetails[@"total"]]];
        //NSString *newStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSArray *newArray = billDetails[@"items"];
        [self.billDetails setText:@""];
        
        for (NSDictionary *unit in newArray) {
            NSDictionary *item = unit[@"item"];
            [self.billDetails setText:[NSString stringWithFormat:@"%@\n%@    $%@",self.billDetails.text, item[@"description"], item[@"price"]]];
        }

        //[self.billDetails setText:newStr];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
        [self.view addGestureRecognizer:gesture];
        
        [gesture addTarget:self action:@selector(dismissKeyboard)];
        
    }
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void) buttonAction: (id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) dismissKeyboard {
    [self resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pay:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pay?" message:@"Do you want to pay with the credit card on file?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Yes"];
    [alert show];
}

- (IBAction)tipadded:(id)sender {
    NSLog(@"billtotal: %d, tipfield: %d", _billtotal, [[self.tipfield text] intValue]);
    [self.total setText:[NSString stringWithFormat:@"$%d", _billtotal + [[self.tipfield text] intValue]]];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}
@end
