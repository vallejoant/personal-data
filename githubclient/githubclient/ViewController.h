//
//  ViewController.h
//  githubclient
//
//  Created by Normandia  on 08/03/14.
//  Copyright (c) 2014 D. Vallejo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *viewBackground;
@property (weak, nonatomic) IBOutlet UIButton *buttonMainSearch;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (weak, nonatomic) IBOutlet UIView *viewLoaging;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLoading;
@property (weak, nonatomic) IBOutlet UILabel *labelError;

- (IBAction) hideKeyboard:(id)sender;
- (IBAction) search:(id)sender;

@end
