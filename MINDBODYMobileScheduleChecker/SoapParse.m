//
//  SoapParse.m
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/17/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import "SoapParse.h"


@implementation SoapParse 


- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.parsedData = [[NSMutableArray alloc] init];
    [self.parsedData addObject:[NSMutableDictionary dictionary]];
    self.text = [[NSMutableString alloc] init];
}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSMutableDictionary *parent = [self.parsedData lastObject];
    
    NSMutableDictionary *child = [NSMutableDictionary dictionary];
    [child addEntriesFromDictionary:attributeDict];
    
    id existingValue = [parent objectForKey:elementName];
    if (existingValue)
    {
        NSMutableArray *array = nil;
        if ([existingValue isKindOfClass:[NSMutableArray class]])
        {
            array = (NSMutableArray *) existingValue;
        }
        else
        {
            array = [NSMutableArray array];
            [array addObject:existingValue];
            [parent setObject:array forKey:elementName];
        }
        [array addObject:child];
    }
    else
    {
        [parent setObject:child forKey:elementName];
    }
    [self.parsedData addObject:child];
}



- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSMutableDictionary *dictInProgress = [self.parsedData lastObject];
    if ([self.text length] > 0)
    {
        [dictInProgress setObject:self.text forKey:elementName];
        self.text = [[NSMutableString alloc] init];
    }
    [self.parsedData removeLastObject];
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.text appendString:string];
}

@end
