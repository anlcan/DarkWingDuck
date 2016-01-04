//
//  CBProductDetail.h
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import "CBProduct.h"
#import "CBSpec.h"
#import "CBBundle.h"

@interface CBProductDetail : CBProduct

@property (nonatomic, assign) float star;

@property (nonatomic, assign) int reviews;

@property (nonatomic, strong) NSString * detail;

@property (nonatomic, assign) BOOL inStock;

@property (nonatomic, strong) NSArray <CBSpec>* specs;

@property (nonatomic, strong) NSArray <CBBundle>* bundles;

@property (nonatomic, strong) NSString * image;

@end
