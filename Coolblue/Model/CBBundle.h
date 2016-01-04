//
//  CBBundle.h
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import "CBProduct.h"
@protocol CBBundle
@end

@interface CBBundle : CBProduct

@property (nonatomic, assign) float discountPrice;

@end
