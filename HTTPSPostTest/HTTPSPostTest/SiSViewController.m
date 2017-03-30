//
//  SiSViewController.m
//  HTTPSPostTest
//
//  Created by Stanly Shiyanovskiy on 29.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface SiSViewController () <NSURLSessionDelegate>

@property(strong, nonatomic) AFHTTPSessionManager* man;

@end

static NSString* urlGetString = @"https://52.89.213.205:8443/rest/user/sites/";
static NSString* urlPostString = @"https://52.89.213.205:8443/rest/user/signup";

@implementation SiSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Session details
    NSURLSession* session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:self
                             delegateQueue:[NSOperationQueue currentQueue]];
    
    
    // Example of GET request
//    NSURL *urlGet = [NSURL URLWithString:urlGetString];
//    NSMutableURLRequest *requestGet = [[NSMutableURLRequest alloc] initWithURL:urlGet];
//    requestGet.HTTPMethod = @"GET";
//    [requestGet setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    NSString *authStr = [NSString stringWithFormat:@"user@gmail.com:user"];
//    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
//    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength]];
//    [requestGet setValue:authValue forHTTPHeaderField:@"Authorization"];
//    
//    NSURLSessionDataTask* dT =
//    [session dataTaskWithRequest:requestGet
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
//    NSURL *urlPost = [NSURL URLWithString:urlPostString];
//    NSMutableURLRequest *requestPost = [[NSMutableURLRequest alloc] initWithURL:urlPost];
//    [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    requestPost.HTTPBody = postData;
//    requestPost.HTTPMethod = @"POST";
//    [[session dataTaskWithRequest:requestPost
//                completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
//                    NSLog(@"data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//                    NSLog(@"code: %ld", (long)[(NSHTTPURLResponse *)response statusCode]);
//                    NSLog(@"error: %@", error.localizedDescription);
//                }] resume];
    
    // AFNetworking GET example
//    self.man = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:urlGetString]];
//    self.man.requestSerializer = [AFJSONRequestSerializer serializer];
//    self.man.responseSerializer = [AFJSONResponseSerializer serializer];
//    self.man.securityPolicy.allowInvalidCertificates = YES;
//    self.man.securityPolicy.validatesDomainName = NO;
//    [self.man.requestSerializer
//     setAuthorizationHeaderFieldWithUsername:@"user@gmail.com"
//     password:@"user"];
//    [self.man.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    
//    [self.man GET:urlGetString
//       parameters:nil
//          success:^(NSURLSessionDataTask* task, id responseObject) {
//              
//              NSLog(@"AFN jsonGet: %@", responseObject);
//              
//          } failure:^(NSURLSessionDataTask* task, NSError* error) {
//              
//              NSLog(@"Error: %@", error);
//              
//          }];
    
    // AFNetworking POST example
    self.man = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:urlPostString]];
    self.man.requestSerializer = [AFJSONRequestSerializer serializer];
    self.man.responseSerializer = [AFJSONResponseSerializer serializer];
    self.man.securityPolicy.allowInvalidCertificates = YES;
    self.man.securityPolicy.validatesDomainName = NO;
    [self.man.requestSerializer
     setAuthorizationHeaderFieldWithUsername:@"user@gmail.com"
     password:@"user"];
    [self.man.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableDictionary *postDictAFN = [[NSMutableDictionary alloc] init];
    [postDictAFN setValue:@"sts0002@gmail.com" forKey:@"userName"];
    [postDictAFN setValue:@"stasst" forKey:@"password"];
    
    [self.man POST:urlPostString
        parameters:postDictAFN
           success:^(NSURLSessionDataTask* task, id responseObject) {
               
               NSLog(@"AFN jsonPost: %@", task);
               NSLog(@"AFN jsonPost: %@", responseObject);
               
           } failure:^(NSURLSessionDataTask* task, NSError* error) {
               
               NSLog(@"Error: %@", error);
               
           }];
    
}

#pragma mark - NSURLSession delegate -

-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential*))completionHandler {
    
    
    NSURLCredential *credential =
    [NSURLCredential credentialWithUser:@"user@gmail.com"
                               password:@"user"
                            persistence:NSURLCredentialPersistenceNone];
    
    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);

}

#pragma mark - AFNetworking methods -



@end
