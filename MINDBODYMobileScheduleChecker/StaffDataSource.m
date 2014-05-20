//
//  StaffDataSource.m
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/15/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import "StaffDataSource.h"

@interface StaffDataSource()
@property (nonatomic) NSMutableArray *staffMembers;

@end


@implementation StaffDataSource

-(NSMutableArray *) allStaff
{
    if(!self.staffMembers){
        self.staffMembers = [[NSMutableArray alloc] init];
    }
    return self.staffMembers;
}


-(instancetype) initWithSoapData: (NSDictionary *) data
{
    if( (self = [super init]) == nil ){
        return nil;
    }

    self.staffMembers = [[NSMutableArray alloc]init];
    NSMutableDictionary *staffData = [NSMutableDictionary dictionaryWithDictionary:data];
    
    staffData = [[[[[staffData objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"GetStaffResponse"] objectForKey:@"GetStaffResult"] objectForKey:@"StaffMembers"];
    
    NSMutableArray *theStaff = [staffData objectForKey:@"Staff"];
    
    
    for(int i = 0; i < theStaff.count; i++){
        NSMutableDictionary *staffMember = [theStaff objectAtIndex:i];
        Staff *staff = [[Staff alloc] initDictionary:staffMember];
        
        if([staff.ID integerValue] > 0){
            [self.staffMembers addObject:staff];
        }
    }
    return self;
}

-(int) numberOfStaff
{
    return [self.staffMembers count];
}

-(Staff *) staffAtIndex: (int) idx
{
	if( idx >= [self.staffMembers count] ){
        return nil;
    }
	return [self.staffMembers objectAtIndex: idx];
}




@end
