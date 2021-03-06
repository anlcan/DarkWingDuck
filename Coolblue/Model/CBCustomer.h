//
//  CBCustomer.h
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface CBCustomer : JSONModel

@property (nonatomic, strong) NSString * email;

@property (nonatomic, strong) NSString * name;

@end
