//
//  PBMainViewController.m
//  PayPalWrapper
//
//  Created by Piet Brauer on 08.03.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "PBMainViewController.h"
#import "PayPalMobile.h"
#import "PBPayPalViewController.h"

#define kPayPalClienID @""

@interface PBMainViewController ()

@property (nonatomic, strong) IBOutlet UIButton *payButton;

@end

@implementation PBMainViewController
@synthesize payButton;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)payWithPayPal:(id)sender{
    // Create a PayPalPayment
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = [[NSDecimalNumber alloc] initWithString:@"39.95"];
    payment.currencyCode = @"USD";
    payment.shortDescription = @"Awesome saws";
    
    // Check whether payment is processable.
    if (payment.processable) {

        
        // Provide a payerId that uniquely identifies a user within the scope of your system,
        // such as an email address or user ID.
        NSString *aPayerId = @"<id>";
        NSString *aReceiverEmail = @"<email>";
        
        // Create a PayPalPaymentViewController with the credentials and payerId, the PayPalPayment
        // from the previous step, and a PayPalPaymentDelegate to handle the results.
        PBPayPalViewController *paymentViewController = [[PBPayPalViewController alloc] initWithClientID:kPayPalClienID
                                                                                           receiverEmail:aReceiverEmail
                                                                                              andPayerId:aPayerId
                                                                                              andPayment:payment                                                         
                                                                                          andEnvironment:PayPalEnvironmentNoNetwork
                                                                                         completionBlock:^(PayPalPayment *completedPayment) {

                                                                                             [self verifyCompletedPayment:completedPayment];
                                                                                             [self dismissViewControllerAnimated:YES completion:nil];
                                                                                             
                                                                                         } cancelBlock:^{
                                                                                             
                                                                                             [self dismissViewControllerAnimated:YES completion:nil];
                                                                                             
                                                                                        }];
        
        // Present the PayPalPaymentViewController.
        [self presentViewController:paymentViewController animated:YES completion:nil];
    } else{
        NSLog(@"not processable");
    }
}

-(void)verifyCompletedPayment:(PayPalPayment *)completedPayment{

}

@end
