//
//  Staff.m
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/16/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import "Staff.h"

@interface Staff()

@property (nonatomic) NSMutableDictionary *staffAttributes;

@end


@implementation Staff

-(id) initDictionary:(NSDictionary *)dictionary{
    if ((self = [super init]) == nil) {
        return nil;
    }
    self.staffAttributes =[NSMutableDictionary dictionaryWithDictionary: dictionary];
    return self;
}

-(NSString *) firstName{
    return [[self.staffAttributes objectForKey:@"FirstName"] objectForKey:@"FirstName"];
}

-(NSString *) lastName{
    return [[self.staffAttributes objectForKey:@"LastName"] objectForKey:@"LastName"];
}

-(NSString *) fullName{
    return [[self.staffAttributes objectForKey:@"Name"] objectForKey:@"Name"];
}

-(NSString *) ID{
    return [[self.staffAttributes objectForKey:@"ID"] objectForKey:@"ID"];
}

-(NSString *) userName{
    NSString *firstN = self.firstName;
    NSString *lastN = self.lastName;
    NSString *userName = [NSString stringWithFormat:@"%@.%@", firstN, lastN];
    return userName;
}

-(NSString *) passWord{
    NSString *firstN = [self.firstName substringWithRange:NSMakeRange(0, 1)];
    firstN = [firstN lowercaseString];
    NSString *lastN = [self.lastName substringWithRange:NSMakeRange(0, 1)];
    lastN = [lastN lowercaseString];
    NSString *passWord = [NSString stringWithFormat:@"%@%@%@", firstN, lastN, self.ID];
    return passWord;
}


@end
