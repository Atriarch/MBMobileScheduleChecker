//
//  StaffSchedule.m
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/19/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import "StaffSchedule.h"

@interface StaffSchedule()

@property (nonatomic) NSMutableDictionary *staffScheduleAttributes;

@end


@implementation StaffSchedule//

-(id) initDictionary:(NSDictionary *)dictionary{
    if ((self = [super init]) == nil) {
        return nil;
    }
    self.staffScheduleAttributes =[NSMutableDictionary dictionaryWithDictionary: dictionary];
    return self;
}

-(NSString *) date{
    NSString *date = [[self.staffScheduleAttributes objectForKey:@"StartDateTime"] objectForKey:@"StartDateTime"];
    date = [date substringWithRange:NSMakeRange(0,10)];
    return date;
}

-(NSString *) startTime{
    NSString *startTime = [[self.staffScheduleAttributes objectForKey:@"StartDateTime"] objectForKey:@"StartDateTime"];
    startTime = [startTime substringWithRange:NSMakeRange(11,8)];
    return startTime;
}

-(NSString *) endTime{
    NSString *endTime = [[self.staffScheduleAttributes objectForKey:@"EndDateTime"] objectForKey:@"EndDateTime"];
    endTime = [endTime substringWithRange:NSMakeRange(11,8)];
    return endTime;
}

-(NSString *) clientName{
    NSString *clientFirstName = [[[self.staffScheduleAttributes objectForKey:@"Client"] objectForKey:@"FirstName"] objectForKey:@"FirstName"];
    NSString *clientLastName = [[[self.staffScheduleAttributes objectForKey:@"Client"] objectForKey:@"LastName"] objectForKey:@"LastName"];
    NSString *clientName = [NSString stringWithFormat: @"%@ %@", clientFirstName, clientLastName];
    
    return clientName;
}

-(NSString *) sessionType{
    NSString *sessionType = [[[self.staffScheduleAttributes objectForKey:@"SessionType"] objectForKey:@"Name"] objectForKey:@"Name"];
    return sessionType;
}

-(NSString *) staffID{
    NSString *staffID = [[[self.staffScheduleAttributes objectForKey:@"Staff"] objectForKey:@"ID"] objectForKey:@"ID"];
    return staffID;
}

@end
