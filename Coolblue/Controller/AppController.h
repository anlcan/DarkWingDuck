//
//  AppController.h
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBOrder.h"
#import "CBProduct.h"

@interface AppController : NSObject

@property (nonatomic, strong) NSArray * currentProducts;


+(AppController*)shared;

-(NSArray*)filteredProducts:(NSString *)filterText;

/*
 * adds a product to current order
 */
-(void)addProduct:(CBProduct*)product;


/*
 * removes a product
 */
-(void)removeProduct:(CBProduct*)product;

/*
 * removes a product
 */
-(BOOL)isProductInOrder:(CBProduct*)product;

/*
 * removes a product
 */
-(void)clearOrder;


-(CBOrder*)getCurrentOrder;

@end
