//
//  ViewController.m
//  githubclient
//
//  Created by Normandia  on 08/03/14.
//  Copyright (c) 2014 D. Vallejo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "GitHubEngine.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.textFieldUserName.layer.cornerRadius = 5;
    self.textFieldUserName.clipsToBounds = YES;
    
    self.buttonMainSearch.layer.cornerRadius = 5;
    self.buttonMainSearch.clipsToBounds = YES;
    
    self.viewBackground.layer.cornerRadius = 8;
    self.viewBackground.clipsToBounds = YES;
    
    self.viewLoaging.layer.cornerRadius = 5;
    self.viewLoaging.clipsToBounds = YES;
    
    self.buttonMainSearch.alpha = 0;
    self.buttonMainSearch.hidden = NO;
    self.textFieldUserName.alpha = 0;
    self.textFieldUserName.hidden = NO;
    [UIView animateWithDuration:1 animations:^{
        self.buttonMainSearch.alpha = 1;
        self.textFieldUserName.alpha = 1;
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) hideKeyboard:(id)sender
{
    [[self textFieldUserName] resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchUser];
    return YES;
}

- (IBAction) search:(id)sender
{
    [self searchUser];
}

- (void) searchUser
{
    [[self textFieldUserName] resignFirstResponder];
    self.labelError.hidden = YES;
    
    self.viewLoaging.alpha = 0;
    self.viewLoaging.hidden = NO;
    [UIView animateWithDuration:0.7 animations:^{
        self.buttonMainSearch.alpha = 0;
        self.viewLoaging.alpha = 0.5;
    }];
    
    NSArray *imageNames = @[@"loading1.png", @"loading2.png", @"loading3.png", @"loading4.png"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    self.imageViewLoading.animationImages = images;
    self.imageViewLoading.animationDuration = 0.7;
    
    [self.imageViewLoading startAnimating];
    
    [[GitHubEngine sharedSingleton] authenticate];
    
    
    dispatch_queue_t queue = dispatch_queue_create("ios.codetest.githubclient", NULL);
    dispatch_async(queue, ^{
        
        BOOL finded = [[GitHubEngine sharedSingleton] searchUser:self.textFieldUserName.text];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (finded) {
                [self searchOk];
            }else{
                [self searchError];
            }
        });
    });
    
    

}





- (void) searchOk
{

    self.buttonMainSearch.hidden = NO;
    self.buttonMainSearch.alpha = 1;
    self.viewLoaging.alpha = 0;
    [self.imageViewLoading stopAnimating];
    
    
    [self performSegueWithIdentifier: @"goToDetailSegue" sender: self];
    
}

- (void) searchError
{
    
    self.buttonMainSearch.alpha = 0;
    self.buttonMainSearch.hidden = NO;
    [UIView animateWithDuration:1 animations:^{
        self.buttonMainSearch.alpha = 1;
        self.viewLoaging.alpha = 0;
    }];
    
    [self.imageViewLoading stopAnimating];
    
    self.labelError.hidden = NO;
}

@end
