//
//  SoapDataSource.m
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/14/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import "SoapDataSource.h"
#import "DownloadData.h"
#import "SoapParse.h"


NSString *userName = @"MBO.Nathan.McGaughy";
NSString *passWord = @"SQebDbsXqxLGxZ6d0stvahaFago=";
NSString *dateConstraint = @"2014-01-03";
int sID = -31100;



NSString *getStaffURL = @"https://api.mindbodyonline.com/0_5/StaffService.asmx";
NSString *getStaffAction = @"http://clients.mindbodyonline.com/api/0_5/GetStaff";
NSString *getStaff  =

@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
"<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
"<soap:Body>"
"<GetStaff xmlns=\"http://clients.mindbodyonline.com/api/0_5\">"
"<Request>"
"<SourceCredentials>"
"<SourceName>%@</SourceName>"
"<Password>%@</Password>"
"<SiteIDs>"
"<int>%d</int>"
"</SiteIDs>"
"</SourceCredentials>"
"<XMLDetail>Full</XMLDetail>"
"<PageSize>10</PageSize>"
"<CurrentPageIndex>0</CurrentPageIndex>"
"<Filters>"
"<StaffFilter>StaffViewable</StaffFilter>"
"</Filters>"
"</Request>"
"</GetStaff>"
"</soap:Body>"
"</soap:Envelope>";



NSString *getStaffAppointmentsURL = @"https://api.mindbodyonline.com/0_5/AppointmentService.asmx";
NSString *getStaffAppointmentsAction = @"http://clients.mindbodyonline.com/api/0_5/GetStaffAppointments";
NSString *getStaffAppointments=

@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
"<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"http://clients.mindbodyonline.com/api/0_5\">"
"<soap:Body>"
"<GetStaffAppointments>"
"<Request>"
"<SourceCredentials>"
"<SourceName>%@</SourceName>"
"<Password>%@</Password>"
"<SiteIDs>"
"<int>%d</int>"
"</SiteIDs>"
"</SourceCredentials>"
"<XMLDetail>Full</XMLDetail>"
"<PageSize>10</PageSize>"
"<CurrentPageIndex>0</CurrentPageIndex>"
"<StaffCredentials>"
"<Username>%@</Username>"
"<Password>%@</Password>"
"<SiteIDs>"
"<int>%d</int>"
"</SiteIDs>"
"</StaffCredentials>"
"<StartDate>%@</StartDate>"
"<EndDate>%@</EndDate>"
"<StaffIDs>"
"<long>%@</long>"
"</StaffIDs>"
"</Request>"
"</GetStaffAppointments>"
"</soap:Body>"
"</soap:Envelope>";



@interface SoapDataSource(){
    BOOL staffReady, staffScheduleReady, staffReady2;
}

@property (nonatomic) DownloadData *downloadData;
@property (nonatomic) NSString *currentDescription;
@property (nonatomic) SoapParse *sParse;

@end


@implementation SoapDataSource

+(SoapDataSource *) sharedInstance: (NSArray*) requestData
{
    static SoapDataSource *instance = nil;
    if(!instance){
        instance = [[SoapDataSource alloc] init: requestData];
    }
    return  instance;
}


-(instancetype) init: (NSArray*) requestData
{
    self.dataSourceReady = FALSE;
    if((self = [super init]) == nil){
        return nil;
    }
    if([requestData[0] isEqualToString:@"staffList"]){
      [self staffList];
    }
    else if([requestData[0] isEqualToString:@"staffAppointment"]){
        
       [self staffAppointment:requestData];
    }
    return self;
}



-(void) staffList{
    staffReady = FALSE;
    self.downloadData = [[DownloadData alloc] init];
    [self.downloadData setDelegate:self];
    NSString *request = [NSString stringWithFormat:getStaff, userName, passWord, sID];
    NSURL *url = [NSURL URLWithString:getStaffURL];
    NSString *action = getStaffAction;
    [self.downloadData downloadContent:url requests:request actions:action];
}



-(void) staffAppointment: (NSArray*) info{
    staffReady = FALSE;
    self.downloadData = [[DownloadData alloc] init];
    [self.downloadData setDelegate:self];
    NSString *request = [NSString stringWithFormat:getStaffAppointments, userName, passWord, sID, [info objectAtIndex:1], [info objectAtIndex:2], sID, dateConstraint, dateConstraint, [info objectAtIndex:3]];
    NSURL *url = [NSURL URLWithString:getStaffAppointmentsURL];
    NSString *action = getStaffAppointmentsAction;
    [self.downloadData downloadContent:url requests:request actions:action];
}



-(BOOL) dataSourceReady{
       return staffReady;
}



-(void) acceptData: (NSData *) webData forURL: (NSURL *) url{
    
    self.sParse = [[SoapParse alloc] init];
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:webData];
    [xmlParser setDelegate:self.sParse];
    [xmlParser setShouldReportNamespacePrefixes:NO];
    [xmlParser setShouldResolveExternalEntities:NO];
    [xmlParser parse];
 
    NSDictionary *results = [[self.sParse parsedData] objectAtIndex:0];
    
    if([url isEqual:[NSURL URLWithString:getStaffURL]]){
        self.staffDataSource =[[StaffDataSource alloc] initWithSoapData:results];
        staffReady = TRUE;
    }
    else if([url isEqual:[NSURL URLWithString:getStaffAppointmentsURL]]){
        self.staffScheduleDataSource = [[StaffScheduleDataSource alloc] initWithSoapData:results];
        staffReady = TRUE;
    }
    self.dataSourceReady = staffReady;
}










@end
