//
//  DetailViewController.m
//  FinalProject
//
//  Created by William O'Connor on 5/4/15.
//  Copyright (c) 2015 slickWilly. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (strong, nonatomic) NSMutableDictionary* screenSize;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.screenSize = [[NSMutableDictionary alloc] init];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    NSNumber *height = [[NSNumber alloc] initWithDouble:screenHeight];
    NSNumber *width = [[NSNumber alloc] initWithDouble:screenWidth];
    
    self.screenSize[@"height"] = height;
    self.screenSize[@"width"] = width;
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:self.student.photo];
    imageView.frame = CGRectMake(0.0, 64.0, [self.screenSize[@"width"] floatValue], [self.screenSize[@"height"] floatValue]/2 - 64.0);
    [self.view addSubview:imageView];
    
    // do the same name and detail strings
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, [self.screenSize[@"height"] floatValue]/2, [self.screenSize[@"width"] floatValue], 40)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [nameLabel setText:self.student.title];
    nameLabel.textColor = [UIColor colorWithRed:0xDE/255.0 green:0xE0/255.0 blue:0xE3/255.0 alpha:1.0];
    nameLabel.font = [UIFont fontWithName:@"Josefin Sans" size:20.0];
    [self.view addSubview:nameLabel];
    
    UILabel* detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, [self.screenSize[@"height"] floatValue]/2 + 60, [self.screenSize[@"width"] floatValue] - 20, 140)];
    detailLabel.numberOfLines = 0;
    detailLabel.adjustsFontSizeToFitWidth = YES;
    detailLabel.textAlignment = NSTextAlignmentCenter;
    [detailLabel setText:self.student.details];
    detailLabel.textColor = [UIColor colorWithRed:0xDE/255.0 green:0xE0/255.0 blue:0xE3/255.0 alpha:1.0];
    detailLabel.font = [UIFont fontWithName:@"Josefin Sans" size:16.0];
    [self.view addSubview:detailLabel];
    
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.frame = CGRectMake([width floatValue]/2 - 50, .9*[height floatValue], 100.0, 40.0);
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0x35/255.0 green:0x37/255.0 blue:0x38/255.0 alpha:1.0];
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

- (void) back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
