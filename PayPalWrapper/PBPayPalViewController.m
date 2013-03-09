//
//  PBPayPalViewController.m
//  PayPalWrapper
//
//  Created by Piet Brauer on 09.03.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "PBPayPalViewController.h"

@interface PBPayPalViewController () <PayPalPaymentDelegate>

@property (nonatomic, copy) CompletionBlock completionBlock;
@property (nonatomic, copy) CancelBlock cancelBlock;

@end

@implementation PBPayPalViewController
@synthesize completionBlock = _completionBlock;
@synthesize cancelBlock = _cancelBlock;

-(PBPayPalViewController *)initWithClientID:(NSString *)clientID
                                                   receiverEmail:(NSString *)receiverEmail
                                                      andPayerId:(NSString *)aPayerId
                                                      andPayment:(PayPalPayment *)payment
                                                  andEnvironment:(NSString *const)environment
                                                 completionBlock:(CompletionBlock)completionBlock
                                                     cancelBlock:(CancelBlock)cancelBlock {
    
    if (payment.processable) {
        
        [PBPayPalViewController setEnvironment:environment];
    
        PBPayPalViewController *paymentViewController = [[PBPayPalViewController alloc] initWithClientId:clientID
                                                                                           receiverEmail:receiverEmail
                                                                                                 payerId:aPayerId
                                                                                                 payment:payment
                                                                                                delegate:self];

        self.completionBlock = completionBlock;
        self.cancelBlock = cancelBlock;
        
        return paymentViewController;
    } else{
        return nil;
    }
}

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment {
    if (self.completionBlock) {
        self.completionBlock(completedPayment);
    }
}

- (void)payPalPaymentDidCancel {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

@end
