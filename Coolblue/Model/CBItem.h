//
//  CBItem.h
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBProduct.h"

@interface CBItem : NSObject

@property (nonatomic, strong) CBProduct * product;

@property (nonatomic, assign) int count;

@end
