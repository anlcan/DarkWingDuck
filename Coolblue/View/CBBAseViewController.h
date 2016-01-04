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

@interface CBBAseViewController : UIViewController

@property (nonatomic, weak, readonly) AFURLSessionManager* manager;


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

@end
