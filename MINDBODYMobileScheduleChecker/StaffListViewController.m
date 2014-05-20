//
//  StaffListViewController.m
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/14/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import "StaffListViewController.h"
#import "StaffScheduleViewController.h"
#import "SoapDataSource.h"
#import "StaffScheduleDataSource.h"


@interface StaffListViewController ()

@property (nonatomic) SoapDataSource *soapData;
@property (nonatomic) StaffDataSource *staffData;
@property (nonatomic) StaffScheduleDataSource *staffScheduleData;
@property (nonatomic) NSMutableArray *requestData;
@property (nonatomic) UIActivityIndicatorView *activityInd;

@end

static NSString *CellIdentifier = @"cell";




@implementation StaffListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
     self.requestData = [[NSMutableArray alloc] init];
    [self.requestData addObject:@"staffList"];

    self = [super initWithStyle:style];
    if (self) {
        [[SoapDataSource sharedInstance: self.requestData] addObserver:self
                                          forKeyPath:@"dataSourceReady"
                                             options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                                             context:nil];
        self.title = @"Staff";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    self.soapData = [SoapDataSource sharedInstance: self.requestData];
    self.staffData = [[StaffDataSource alloc] init];
    self.staffScheduleData = [[StaffScheduleDataSource alloc] init];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    
    self.activityInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.activityInd setCenter: self.view.center];
    [self.view addSubview:self.activityInd];
    
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



-(void) refreshTableView: (UIRefreshControl *) sender
{
    [self.tableView reloadData];
    [sender endRefreshing];
}



-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    self.staffData = [self.soapData staffDataSource];
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.staffData numberOfStaff];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Staff *staff = [self.staffData staffAtIndex:[indexPath row]];
    cell.textLabel.text = [staff fullName];
    return cell;
}



- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( [self.tableView cellForRowAtIndexPath:indexPath].selected ) {
        [self.tableView deselectRowAtIndexPath: indexPath animated:YES];
        return nil;
    }
    return indexPath;
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Staff *staff = [self.staffData staffAtIndex:[indexPath row]];
    self.requestData = [[NSMutableArray alloc] init];

    [self.requestData addObject:@"staffAppointment"];
    [self.requestData addObject:staff.userName];
    [self.requestData addObject:staff.passWord];
    [self.requestData addObject:staff.ID];
        
    StaffScheduleViewController *slvc = [[StaffScheduleViewController alloc] initWithData:self.requestData];
    [self.navigationController pushViewController:slvc animated:YES];

}




@end
