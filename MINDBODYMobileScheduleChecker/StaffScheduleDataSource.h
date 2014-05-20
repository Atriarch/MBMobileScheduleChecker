//
//  StaffScheduleDataSource.h
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/19/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadData.h"
#import "StaffSchedule.h"

@interface StaffScheduleDataSource : NSObject

-(instancetype) initWithSoapData: (NSDictionary *) data;
-(int) numberOfEvents;
-(StaffSchedule *) eventAtIndex: (int) idx;

@end
