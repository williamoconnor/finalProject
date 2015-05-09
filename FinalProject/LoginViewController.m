//
//  ViewController.m
//  FinalProject
//
//  Created by William O'Connor on 5/4/15.
//  Copyright (c) 2015 slickWilly. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // LAUNCHES
    NSNumber* launches = [[NSUserDefaults standardUserDefaults] objectForKey:@"launches"];
    if ([launches intValue] == 5) {
        UIAlertView* fiveLaunchesAlertView = [[UIAlertView alloc] initWithTitle:@"Five Launches!" message:@"You have launched the app 5 times. Congratulations!" delegate:nil cancelButtonTitle:@"Wahoo!!" otherButtonTitles:nil, nil];
        [fiveLaunchesAlertView show];
    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    NSNumber *height = [[NSNumber alloc] initWithDouble:screenHeight];
    NSNumber *width = [[NSNumber alloc] initWithDouble:screenWidth];

    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = CGPointMake([width floatValue]/2, .56*[height floatValue]);
    loginButton.readPermissions = @[@"public_profile", @"email"];
    [loginButton addObserver:self forKeyPath:@"titleLabel.text" options:NSKeyValueObservingOptionNew context:NULL];
    [self.view addSubview:loginButton];
    
    UIImageView* backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, [width floatValue], [height floatValue])];
    backgroundImage.image = [UIImage imageNamed:@"willLaPlaya.jpg"];
    [self.view addSubview:backgroundImage];
    
    [self.view bringSubviewToFront:loginButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"titleLabel.text"]) {
        // Value changed
        if ([FBSDKAccessToken currentAccessToken]) {
            UIActivityIndicatorView* loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            loading.center = self.view.center;
            [loading startAnimating];
            NSLog(@"profile: %@", [FBSDKAccessToken currentAccessToken].userID);
            /* make the API call */
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                     NSLog(@"fetched user:%@", result);
                     //check result
                     [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"user"];
                     [self performSegueWithIdentifier:@"tableViewSegue" sender:self];
                }
             }];
        }
    }
}


@end
