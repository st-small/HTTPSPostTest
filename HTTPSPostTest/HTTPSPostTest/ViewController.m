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




@end
