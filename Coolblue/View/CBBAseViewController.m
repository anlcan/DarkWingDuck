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
#import "CBOrderDetailViewController.h"

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
    NSError * error = nil;
    id result =  [[c alloc]initWithDictionary:dict error:&error];
    if ( error!= nil){
        NSLog(@"%@", error);
    }
    return result;
}

-(void)presentOrderViewController{
    CBOrderDetailViewController * orderVC = _create(CBOrderDetailViewController);
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:orderVC];
    [self.navigationController presentViewController:nav animated:YES completion:^{
        
    }];
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

- (void)shakeAnimation:(UIView*)view
{
    const int reset = 5;
    const int maxShakes = 6;
    
    // pass these as variables instead of statics or class variables if shaking
    // two controls simultaneously
    static int shakes = 0;
    static int translate = reset;
    
    [UIView animateWithDuration:0.09 - (shakes * .01) // reduce duration every
     // shake from .09 to .04
                          delay:0.01f // edge wait delay
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.transform = CGAffineTransformMakeTranslation(translate, 0);
                     }
                     completion:^(BOOL finished) {
                         if (shakes < maxShakes) {
                             shakes++;
                             
                             // throttle down movement
                             if (translate > 0)
                                 translate--;
                             
                             // change direction
                             translate *= -1;
                             [self shakeAnimation:view];
                         } else {
                             view.transform = CGAffineTransformIdentity;
                             shakes = 0; // ready for next time
                             translate = reset; // ready for next time
                             return;
                         }
                     }];
}

@end