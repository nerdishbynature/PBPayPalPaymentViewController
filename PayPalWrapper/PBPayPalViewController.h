//
//  PBPayPalViewController.h
//  PayPalWrapper
//
//  Created by Piet Brauer on 09.03.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "PayPalPaymentViewController.h"

typedef void (^CompletionBlock)(PayPalPayment *completedPayment);
typedef void (^CancelBlock)(void);

@interface PBPayPalViewController : PayPalPaymentViewController

/**
 Initializes the view controller
 @param clientID PayPal client ID
 @param receiverEmail the receiver email address
 @param aPayerId the payer ID
 @param payment The PayPalPayment
 @param environment the environment which should be used
 @param completionBlock The block called on success
 @param cancelBlock The block called when the transaction was aborted
 */
-(PBPayPalViewController *)initWithClientID:(NSString *)clientID
                                   receiverEmail:(NSString *)receiverEmail
                                      andPayerId:(NSString *)aPayerId
                                      andPayment:(PayPalPayment *)payment
                                  andEnvironment:(NSString *const)environment
                                 completionBlock:(CompletionBlock)completionBlock
                                     cancelBlock:(CancelBlock)cancelBlock;

@end
