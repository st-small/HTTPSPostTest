//
//  ViewController.m
//  HTTPSPostTest
//
//  Created by Stanly Shiyanovskiy on 29.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "ViewController.h"
#import "RestAPI.h"

@interface ViewController () <RestAPIDelegate, NSURLSessionDelegate>

@property (nonatomic, strong) RestAPI *restApi;
@property (nonatomic, strong) NSMutableArray *webTitles;
@property (nonatomic, strong) NSMutableArray *sectionNames;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self httpGetRequest];
}


-(RestAPI *)restApi {
    if (!_restApi) {
        _restApi = [[RestAPI alloc] init];
    }
    return _restApi;
}

-(NSMutableArray *)webTitles {
    if (!_webTitles) {
        _webTitles = [[NSMutableArray alloc] init];
    }
    return _webTitles;
}

-(NSMutableArray *)sectionNames {
    if (!_sectionNames) {
        _sectionNames = [[NSMutableArray alloc] init];
    }
    return _sectionNames;
}

- (void)httpGetRequest {
    NSString *str = @"https://52.89.213.205:8443";
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    self.restApi.delegate = self;
    [self.restApi httpRequest:request];
}

- (void)getReceivedData:(NSMutableData *)data sender:(RestAPI *)sender
{
    NSError *error = nil;
    NSDictionary *receivedData =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSDictionary *response = [[NSDictionary alloc] initWithDictionary:[receivedData objectForKey:@"response"]];
    NSArray *results = [[NSArray alloc] initWithArray:[response objectForKey:@"results"]];
    
    for (int i; i < results.count; i++) {
        NSDictionary *resultsItems = [results objectAtIndex:i];
        NSString *webTitle = [resultsItems objectForKey:@"webTitle"];
        [self.webTitles addObject:webTitle];
        NSString *sectionName = [resultsItems objectForKey:@"sectionName"];
        [self.sectionNames addObject:sectionName];
    }
    
}

-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust] &&
        [challenge.protectionSpace.host hasSuffix:@"https://52.89.213.205"]) {
        // accept the certificate anyway
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }
    else {
        [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
}



@end
