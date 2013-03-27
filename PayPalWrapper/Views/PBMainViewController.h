//
//  PBMainViewController.h
//  PayPalWrapper
//
//  Created by Piet Brauer on 08.03.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBMainViewController : UIViewController<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *email_field;

@end
