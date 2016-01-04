//
//  AppController.h
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppController : NSObject

@property (nonatomic, strong) NSArray * currentProducts;

+(AppController*)shared;

-(NSArray*)filteredProducts:(NSString *)filterText;

@end
