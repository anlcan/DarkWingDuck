//
//  CBBAseViewController.h
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "AppController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Coolblue.h"
#import "CBProductDetail.h"

@interface CBBAseViewController : UIViewController

@property (nonatomic, weak, readonly) AFURLSessionManager* manager;


@property (nonatomic, strong) UIView * accesoryView; // if set, it will be shown at the battom of view controller
/*
 * Util method to parse dictonary to a classToGenerate object usin JSONModel
 */
-(id)parse:(NSDictionary*)dictonary forClass:(Class)classToGenerate;

/*
 *
 */
-(void)showProgress;


/*
 *
 */
-(void)dismissProgress;




/**
 * convenient method for creating request whith relative paths
 *
 */
-(NSURLRequest*)requestForPath:(NSString *)relativePath;

/**
 * sends an nsurlrequest to server with success completion
 */
-(void)send:(NSURLRequest*)request withCompletion:(nullable void (^)(id responseObject)) completion;

/**
 *
 */
-(void)presentOrderViewController;


/**
 *
 */
-(void)pushProductDetail:(CBProductDetail*)productDetai;


/**
 *
 */
- (void)shakeAnimation:(UIView*)view;

@end
