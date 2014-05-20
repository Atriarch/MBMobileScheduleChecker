//
//  StaffScheduleViewController.h
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/19/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaffScheduleDataSource.h"

@interface StaffScheduleViewController : UITableViewController

-(id)initWithData: (NSArray *) data;

@end
