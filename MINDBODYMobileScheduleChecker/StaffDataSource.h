//
//  StaffDataSource.h
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/15/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Staff.h"
#import "DownloadData.h"


@interface StaffDataSource : NSObject

-(instancetype) initWithSoapData: (NSDictionary *) data;
-(Staff *) staffAtIndex: (int) idx;
-(int) numberOfStaff;

@end
