//
//  DownloadData.m
//  MINDBODY Mobile Schedule Checker
//
//  Created by student on 5/15/14.
//  Copyright (c) 2014 Nathan McGaughy. All rights reserved.
//

#import "DownloadData.h"
#import "SoapParse.h"


@interface DownloadData()

@property (nonatomic) NSMutableData *downloadedData;
@property (nonatomic) NSURLConnection *con;
@property (nonatomic) NSURL *url;


@end


@implementation DownloadData

-(NSData *) dataHeld{
    return self.downloadedData;
}


-(void) downloadContent:(NSURL *)url requests:(NSString *)request actions:(NSString *)action{
    self.url = url;
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *mLength = [NSString stringWithFormat:@"%d", [request length]];
    
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:action forHTTPHeaderField:@"SOAPAction"];
    [req addValue: mLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[request dataUsingEncoding:NSUTF8StringEncoding]];
    
    self.con = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
    
    if(self.con){
        self.downloadedData = [NSMutableData data];
    }
}

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    self.downloadedData = [[NSMutableData alloc] init];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.downloadedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if( [self.delegate respondsToSelector:@selector(acceptData:forURL:)] ){
        [self.delegate acceptData:self.downloadedData forURL:self.url];
    }
    self.downloadedData = nil;
}

@end
