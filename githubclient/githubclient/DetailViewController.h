//
//  DetailViewController.h
//  githubclient
//
//  Created by David on 10/03/14.
//  Copyright (c) 2014 D. Vallejo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserObject.h"

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate> {
    
    IBOutlet UITableView *tableView;
    UserObject* user;

}


@property (strong, nonatomic) IBOutlet UIView *viewBackground;
@property (weak, nonatomic) IBOutlet UIButton *buttonMainSearch;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (weak, nonatomic) IBOutlet UIView *viewLoaging;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLoading;
@property (strong, nonatomic) IBOutlet UILabel *labelNoRepositories;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewAvatar;
@property (strong, nonatomic) IBOutlet UILabel *labelnickname;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelLocation;
@property (strong, nonatomic) IBOutlet UILabel *labelEmal;
@property (strong, nonatomic) IBOutlet UILabel *labelWebsite;
@property (strong, nonatomic) IBOutlet UILabel *labelFollowers;
@property (strong, nonatomic) IBOutlet UILabel *labelFollowing;

- (IBAction) hideKeyboard:(id)sender;
- (IBAction) search:(id)sender;

@end
