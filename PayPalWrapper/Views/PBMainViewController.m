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

#define kPayPalClienID @"Your client ID here"

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


-(BOOL) validEmail:(NSString*) emailString {
    if (emailString) {
        NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$";
        NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
        NSLog(@"%i", regExMatches);
        if (regExMatches == 0) {
            return NO;
        } else
            return YES;
        
    }
    return NO;
}



-(IBAction)payWithPayPal:(id)sender{
    // Create a PayPalPayment
    
    NSString *aPayerId = @"405";
  
    NSString *aReceiverEmail = self.email_field.text;
    
     if ( [self.email_field.text length]<1) {
         
         UIAlertView *alertShow=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Please enter receiver's email to test." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
         [alertShow show];
     }
    
     else
    
        if ( [self validEmail:aReceiverEmail]) {
        
        
        PayPalPayment *payment = [[PayPalPayment alloc] init];
        payment.amount = [[NSDecimalNumber alloc] initWithString:@"39.95"];
        payment.currencyCode = @"USD";
        payment.shortDescription = @"Awesome saws";
        
        // Check whether payment is processable.
        if (payment.processable) {
            
         
            // Provide a payerId that uniquely identifies a user within the scope of your system,
            // such as an email address or user ID.
            
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
    else{
        UIAlertView *alertShow=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Please enter valid receiver email to test." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertShow show];
                                
    }

    
    
   }

-(void)verifyCompletedPayment:(PayPalPayment *)completedPayment{

}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
- (void)dealloc {
    [_email_field release];
    [super dealloc];
}
@end
