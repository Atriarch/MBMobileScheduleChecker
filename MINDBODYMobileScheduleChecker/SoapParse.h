//
//  SoapParse.h
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/17/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoapParse : NSObject  <NSXMLParserDelegate>

@property (nonatomic) NSMutableArray *parsedData;
@property (nonatomic) NSMutableString *text;


@end
