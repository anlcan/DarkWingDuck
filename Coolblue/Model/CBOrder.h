//
//  CBOrder.h
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface CBOrder : JSONModel

@property (nonatomic, strong) NSMutableArray * products;

@property (nonatomic) float totalAmount;


@end
