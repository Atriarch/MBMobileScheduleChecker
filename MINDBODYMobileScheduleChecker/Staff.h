//
//  Staff.h
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/16/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Staff : NSObject

-(NSString *) firstName;
-(NSString *) lastName;
-(NSString *) fullName;
-(NSString *) ID;
-(NSString *) userName;
-(NSString *) passWord;
-(id) initDictionary: (NSDictionary *) dictionary;

@end
