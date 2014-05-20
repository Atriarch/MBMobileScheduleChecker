//
//  StaffScheduleViewController.m
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/19/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import "StaffScheduleViewController.h"
#import "StaffScheduleDataSource.h"
#import "SoapDataSource.h"

@interface StaffScheduleViewController ()

@property (nonatomic) NSArray *dataHold;
@property (nonatomic) SoapDataSource *soapData;
@property (nonatomic) StaffScheduleDataSource *staffScheduleData;
@property (nonatomic) UIActivityIndicatorView *activityInd;

@end

static NSString *CellIdentifier = @"cell";



@implementation StaffScheduleViewController

- (id)initWithData: (NSArray *) data
{
    self = [super init];
    if (self) {
        self.dataHold = data;
        self.soapData = [[SoapDataSource alloc] init:data];
        self.title = @"Staff Schedule";
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        
    self.staffScheduleData = [[StaffScheduleDataSource alloc] init];

    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:nil action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    self.activityInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
   
    [self.activityInd setCenter: self.view.center];
    [self.view addSubview:self.activityInd];
    
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



-(void) refreshTableView: (UIRefreshControl *) sender
{
    [self.refreshControl beginRefreshing];
    self.staffScheduleData = [self.soapData staffScheduleDataSource];
    [self.tableView reloadData];
    [sender endRefreshing];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%@    (Pull down to load)", [self.dataHold objectAtIndex:1]];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.staffScheduleData numberOfEvents];
}



- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];//[tableView 
    StaffSchedule *staffSchedule = [self.staffScheduleData eventAtIndex:[indexPath row]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@-%@)", staffSchedule.date, staffSchedule.startTime, staffSchedule.endTime];
    cell.detailTextLabel.text =[NSString stringWithFormat:@"%@: %@", staffSchedule.clientName, staffSchedule.sessionType];
    return cell;
}

@end
