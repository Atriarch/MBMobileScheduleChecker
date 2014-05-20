//
//  DownloadData.h
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/15/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebDataReadyDelegate;


@interface DownloadData : NSObject<NSURLConnectionDelegate>

@property (nonatomic) id<WebDataReadyDelegate> delegate;

-(void) downloadContent:(NSURL *)url requests:(NSString *)request actions:(NSString *)action;
-(NSData *) dataHeld;

@end

@protocol WebDataReadyDelegate <NSObject>

-(void) acceptData: (NSData *) webData forURL: (NSURL *) url;

@end


