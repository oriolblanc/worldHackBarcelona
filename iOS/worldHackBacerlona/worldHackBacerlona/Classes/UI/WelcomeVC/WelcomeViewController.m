//
//  WelcomeViewController.m
//  worldHackBarcelona
//
//  Created by Valenti on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginVC.h"
#import "GameVC.h"
#import "AppDelegate.h"

@interface WelcomeViewController ()
-(void)makeLogout:(id)sender;
@end

@implementation WelcomeViewController

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
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:254.0f/255 green:191.0f/255 blue:16.0f/255 alpha:.9f]];

    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(makeLogout:)];
    [self.navigationItem setRightBarButtonItem:barButton];
    [barButton release];
    
    //if session no valid
    
    if(![delegate.facebook isSessionValid]){
        LoginVC *vc = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
        [self presentModalViewController:vc animated:NO];
        [vc release];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
        [self.navigationController.navigationBar setHidden:NO];
}

-(void)makeLogout:(id)sender{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate.facebook logout];
    
    LoginVC *vc = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
    [self presentModalViewController:vc animated:NO];
    [vc release];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - action

-(IBAction)start:(id)sender
{
    [GameService getQuestionsAndAnswersWithSuccess:^(id data) {
 
        GameVC * vc = [[[GameVC alloc] initWithNibName:@"GameVC" bundle:nil] autorelease];
        [self.navigationController pushViewController:vc animated:YES];
        
    } error:^(NSError *error) {
        NSLog(@"error");
    }];
}

@end
