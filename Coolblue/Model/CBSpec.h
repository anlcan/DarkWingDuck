//
//  CBSpec.h
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@protocol CBSpec
@end

@interface CBSpec : JSONModel

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * value;

@end
