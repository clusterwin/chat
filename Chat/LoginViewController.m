//
//  LoginViewController.m
//  Chat
//
//  Created by Alex Lester on 11/5/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "LoginViewController.h"
#import "PFUser.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@end

@implementation LoginViewController
- (IBAction)signUpButtonPress:(id)sender {
	PFUser *user = [PFUser user];
	user.username = self.emailTextField.text;
	user.password = self.passwordTextField.text;
	user.email = self.emailTextField.text;
	
	// other fields can be set just like with PFObject
	//user[@"phone"] = @"415-392-0202";
	
	[user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
		if (!error) {   // Hooray! Let them use the app now.
		} else {   NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
			[self showAlert:errorString];
		}
	}];
}
- (IBAction)signInButtonPress:(id)sender {
	[PFUser logInWithUsernameInBackground:self.emailTextField.text password:self.emailTextField.text
									block:^(PFUser *user, NSError *error) {
										if (user) {
											// Do stuff after successful login.
										} else {
											// The login failed. Check error to see why.
											[self showAlert:@"Log in failed"];
										}
									}];
}


- (void)showAlert:(NSString *)alertString {
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
																   message:alertString
															preferredStyle:UIAlertControllerStyleAlert];
 
	UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
														  handler:^(UIAlertAction * action) {}];
 
	[alert addAction:defaultAction];
	[self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
