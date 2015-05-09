//
//  TableViewController.m
//  FinalProject
//
//  Created by William O'Connor on 5/4/15.
//  Copyright (c) 2015 slickWilly. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"
#import "ThingAboutWill.h"
#import <Parse/Parse.h>

@interface TableViewController ()

@property (strong, nonatomic) NSMutableArray* objects;
@property int selectedRowIndex;
@property (strong, nonatomic) UITableView* tableView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    NSNumber *height = [[NSNumber alloc] initWithDouble:screenHeight];
    NSNumber *width = [[NSNumber alloc] initWithDouble:screenWidth];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(([width floatValue]/2) - 100, 30.0, 200.0, 40.0)];
    titleLabel.textColor = [UIColor colorWithRed:0xDE/255.0 green:0xE0/255.0 blue:0xE3/255.0 alpha:1.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"About Will O'Connor";
    [self.view addSubview:titleLabel];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 80.0, [width floatValue], [height floatValue]-80)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor colorWithRed:0x35/255.0 green:0x37/255.0 blue:0x38/255.0 alpha:1.0];
    self.tableView.backgroundColor = [UIColor colorWithRed:0x35/255.0 green:0x37/255.0 blue:0x38/255.0 alpha:1.0];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
    self.objects = [self createObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:0x35/255.0 green:0x37/255.0 blue:0x38/255.0 alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithRed:0xDE/255.0 green:0xE0/255.0 blue:0xE3/255.0 alpha:1.0];
    
    
    NSLog(@"%@",self.objects[indexPath.row]);
    cell.textLabel.text = ((ThingAboutWill*)self.objects[indexPath.row]).title;
    cell.textLabel.font = [UIFont fontWithName:@"Josefin Sans" size:18.0];
    cell.textLabel.numberOfLines = 0;
    cell.imageView.image = ((ThingAboutWill*)self.objects[indexPath.row]).photo;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objects count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRowIndex = indexPath.row;
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    DetailViewController* destinationViewController = segue.destinationViewController;
    destinationViewController.student = self.objects[self.selectedRowIndex];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (NSMutableArray*) createObjects
{
    NSMutableArray* things = [[NSMutableArray alloc] init];
    NSArray* parseThings = [[NSArray alloc] init];
    
    PFQuery* thingsQuery = [PFQuery queryWithClassName:@"Thing"];
    parseThings = [thingsQuery findObjects];
    
    for (PFObject* object in parseThings) {
        PFFile* photo = object[@"photo"];
        NSData* photoData = [photo getData];
        UIImage *image = [UIImage imageWithData:photoData];
        NSString* title = object[@"title"];
        NSString* description = object[@"description"];
        ThingAboutWill* thingy = [[ThingAboutWill alloc] initWithTitle:title andPhoto:image andDetail:description];
        [things addObject:thingy];
    }
    NSLog(@"%@", things);
    
    return things;
}

@end
