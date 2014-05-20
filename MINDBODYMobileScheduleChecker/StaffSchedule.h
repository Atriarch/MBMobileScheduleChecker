//
//  StaffSchedule.h
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/19/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StaffSchedule : NSObject

-(id) initDictionary: (NSDictionary *) dictionary;
-(NSString *) date;
-(NSString *) startTime;
-(NSString *) endTime;
-(NSString *) clientName;
-(NSString *) sessionType;
-(NSString *) staffID;

@end
