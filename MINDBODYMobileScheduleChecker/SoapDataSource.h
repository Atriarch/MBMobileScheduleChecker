//
//  SoapDataSource.h
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/14/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StaffDataSource.h"
#import "DownloadData.h"
#import "StaffScheduleDataSource.h"


@protocol DataSourceReadyForUseDelegate;


@interface SoapDataSource : NSObject<WebDataReadyDelegate>

@property (nonatomic) id<DataSourceReadyForUseDelegate> delegate;

@property (nonatomic) StaffDataSource *staffDataSource;
@property (nonatomic) StaffScheduleDataSource *staffScheduleDataSource;

@property (nonatomic) BOOL dataSourceReady;

+(SoapDataSource *) sharedInstance: (NSArray*) requestData;
-(instancetype) init: (NSArray*) requestData;

@end
