//
//  DetailViewController.m
//  githubclient
//
//  Created by David on 10/03/14.
//  Copyright (c) 2014 D. Vallejo. All rights reserved.
//

#import "DetailViewController.h"
#import "RepositoryCell.h"
#import "GitHubEngine.h"
#import "RepositoryObject.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
	
    self.textFieldUserName.layer.cornerRadius = 5;
    self.textFieldUserName.clipsToBounds = YES;
    
    self.buttonMainSearch.layer.cornerRadius = 5;
    self.buttonMainSearch.clipsToBounds = YES;
    
    self.viewLoaging.layer.cornerRadius = 5;
    self.viewLoaging.clipsToBounds = YES;
    
    [self loadUser];
    
}


- (void) loadUser
{
    user = [[GitHubEngine sharedSingleton] getUser];
    
    self.labelnickname.text = user.nickname;
    self.labelName.text = user.fullname;
    self.labelLocation.text = user.location;
    self.labelEmal.text = user.email;
    self.labelFollowers.text = [NSString stringWithFormat:@"%@", user.followers];
    self.labelFollowing.text = [NSString stringWithFormat:@"%@", user.following];
    self.labelWebsite.text = user.webpage;
    
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.avatar]]];
    if (image != nil) {
        [self.imageViewAvatar setImage:image];
    }
    
    if(user.repositories != nil && [user.repositories count] > 0){
        [self.labelNoRepositories setHidden:YES];
        [tableView setHidden:NO];
        [tableView reloadData];
    }else{
        [self.labelNoRepositories setHidden:NO];
        [tableView setHidden:YES];
    }
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
    
    [self loadUser];
    
    
}

- (void) searchError
{
    
    self.buttonMainSearch.alpha = 0;
    self.buttonMainSearch.hidden = NO;
    [UIView animateWithDuration:1 animations:^{
        self.buttonMainSearch.alpha = 1;
        self.viewLoaging.alpha = 0;
    }];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"User not found. Please, insert a new nickname."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(user != nil && user.repositories != nil && [user.repositories count] > 0){
        return [user.repositories count];
    }else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RepositoryCell";
    RepositoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
            cell = (RepositoryCell *)[nib objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     cell.backgroundColor = [UIColor clearColor];
    
    cell.viewBackground.layer.cornerRadius = 5;
    cell.viewBackground.clipsToBounds = YES;

    
    RepositoryObject* object = [user.repositories objectAtIndex:indexPath.row];
    
    if(object.name != nil) cell.labelName.text = object.name;
    if(object.descript != nil && object.descript.length > 0)  cell.labelDescription.text = object.descript;
    if(object.stargazers != nil) cell.labelStars.text = [NSString stringWithFormat:@"%@", object.stargazers];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 60;
}

@end
