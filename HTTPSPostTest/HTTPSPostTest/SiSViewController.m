//
//  SiSViewController.m
//  HTTPSPostTest
//
//  Created by Stanly Shiyanovskiy on 29.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSViewController.h"

@interface SiSViewController () <NSURLSessionDelegate>

@end

@implementation SiSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Example of GET request
//    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession* session =
//    [NSURLSession sessionWithConfiguration:sessionConfig
//                                  delegate:self
//                             delegateQueue:[NSOperationQueue mainQueue]];
//    NSURL *url = [NSURL URLWithString:@"https://52.89.213.205:8443/rest/user/sites/"];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//    request.HTTPMethod = @"GET";
//    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    NSString *authStr = [NSString stringWithFormat:@"user@gmail.com:user"];
//    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
//    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength]];
//    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
//    NSURLSessionDataTask* dT =
//    [session dataTaskWithRequest:request
//               completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
//                   NSLog(@"Error: %@",error);
//                   NSLog(@"Response: %@", response);
//                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                   NSLog(@"%@", json);
//                   NSDictionary* dict = [error userInfo];
//                   NSLog(@"%@", dict);
//               }];
//    
//    [dT resume];
    
    // Example of POST request
//    NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
//    [postDict setValue:@"sts2@gmail.com" forKey:@"userName"];
//    [postDict setValue:@"stasst" forKey:@"password"];
//    NSData* postData = [NSJSONSerialization dataWithJSONObject:postDict
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:nil];
//    
//    
//    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession* session =
//    [NSURLSession sessionWithConfiguration:sessionConfig
//                                  delegate:self
//                             delegateQueue:[NSOperationQueue mainQueue]];
//    NSURL *url = [NSURL URLWithString:@"https://52.89.213.205:8443/rest/user/signup"];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    request.HTTPBody = postData;
//    request.HTTPMethod = @"POST";
//    NSArray* test = [NSJSONSerialization JSONObjectWithData:postData
//                                                         options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"postData string: %@", [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding]);
//    NSLog(@"postData array: %@", test);
//    
//    //**************************
//    // Check how to pass data from dictionary to JSON
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDict
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:&error];
//    NSString *jsonString;
//    if (jsonData) {
//        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    } else {
//        NSLog(@"Got an error: %@", error);
//        jsonString = @"";
//    }
//    NSLog(@"Your JSON String is %@", jsonString);
//    //**************************
//    // Check back method: from JSON to dictionary
//    NSError *jsonError;
//    NSData *objectData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
//                                                         options:NSJSONReadingMutableContainers
//                                                           error:&jsonError];
//    NSLog(@"Your JSON DICTIONARY String is %@", json);
//    
//    
//    //**************************
//
//    NSURLSessionDataTask* dT =
//    [session dataTaskWithRequest:request
//               completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
//                   NSLog(@"Error: %@",error);
//                   NSLog(@"Response: %@", response);
//                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                   NSLog(@"%@", json);
//                   NSDictionary* dict = [error userInfo];
//                   NSLog(@"%@", dict);
//               }];
//    
//    [dT resume];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://52.89.213.205:8443/rest/user/signup"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:@{
                                                                 @"userName":@"randommail@gg.com",
                                                                 @"password":@"123456"
                                                                 } options:NSJSONWritingPrettyPrinted error:nil];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"code: %ld", (long)[(NSHTTPURLResponse *)response statusCode]);
        NSLog(@"error: %@", error.localizedDescription);
        
    }] resume];
    
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error{
    NSLog(@"%@", error);
}

#pragma mark - NSURLSession delegate -

-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential*))completionHandler {
    
    
    NSURLCredential *credential =
    [NSURLCredential credentialWithUser:@"user@gmail.com"
                               password:@"user"
                            persistence:NSURLCredentialPersistenceNone];
    
    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);



}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"%@", response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString* responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", responseString);
    
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest *))completionHandler {
    NSMutableURLRequest *newRequest = request.mutableCopy;
    // Add authentication header here.
    completionHandler(newRequest);
}




@end
