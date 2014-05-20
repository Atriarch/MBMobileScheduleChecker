//
//  StaffScheduleDataSource.m
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/19/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import "StaffScheduleDataSource.h"

@interface StaffScheduleDataSource()

@property (nonatomic) NSMutableArray *staffSchedules;

@end


@implementation StaffScheduleDataSource



-(instancetype) initWithSoapData: (NSDictionary *) data
{
    if( (self = [super init]) == nil ){
        return nil;
    }
    
    self.staffSchedules = [[NSMutableArray alloc]init];
    NSMutableDictionary *staffScheduleData = [NSMutableDictionary dictionaryWithDictionary:data];
    
    staffScheduleData = [[[[[staffScheduleData objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"GetStaffAppointmentsResponse"] objectForKey:@"GetStaffAppointmentsResult"] objectForKey:@"Appointments"];
    
    NSMutableArray *theSchedule = [staffScheduleData objectForKey:@"Appointment"];
    
    for(int i = 0; i < theSchedule.count; i++){
        NSMutableDictionary *staffMemberSchedule = [theSchedule objectAtIndex:i];
        StaffSchedule *staffSchedule = [[StaffSchedule alloc] initDictionary:staffMemberSchedule];
        [self.staffSchedules addObject:staffSchedule];
    }
    return self;
}



-(int) numberOfEvents
{
    return [self.staffSchedules count];
}



-(StaffSchedule *) eventAtIndex: (int) idx
{
	if( idx >= [self.staffSchedules count] ){
        return nil;
    }
	return [self.staffSchedules objectAtIndex: idx];
}


@end
