//
//  CBBAseViewController.m
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import "CBBAseViewController.h"
#import "CBModel.h"
#import <MBProgressHUD/MBProgressHUD.h>
/**
 * we will use onlyu one sessionManager, will be very usefull to track all requests
 *
 */
static AFURLSessionManager *sessionManager;

/**
 * Coolblue mock server hostname, an exception has added to plist for http requests!!
 */
static NSString * host = @"http://demo3033169.mockable.io";


/*
 * This is a base view to extend other viewcontrollers from
 * It will be hold commons operation such as alerting, showing/dimsssing loading
 *
 */
@interface CBBAseViewController ()
@end

@implementation CBBAseViewController

+(void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = sessionManager;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(id)parse:(NSDictionary*)dict forClass:(Class)c{
    
    return [[c alloc]initWithDictionary:dict error:nil];
}


/*
 *
 */
-(void)showProgress{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}


/*
 *
 */
-(void)dismissProgress{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}


-(NSURLRequest*)requestForPath:(NSString *)path{
    NSString * fullPath = [NSString stringWithFormat:@"%@%@", host, path];
    NSURL *URL = [NSURL URLWithString:fullPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    return request;
}

@end