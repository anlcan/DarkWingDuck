//
//  AppController.m
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import "AppController.h"
#import "CBProduct.h"

static AppController * shared;

@implementation AppController

+(AppController*)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [AppController new];
    });
    return shared;
}

-(NSArray*)filteredProducts:(NSString *)text{

    
    if(text == nil || [text length] == 0) {
        return   [AppController shared].currentProducts; // default currentProducts
    } else {
        
        NSArray *tmpArray = [[AppController shared].currentProducts filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            
            
            if([evaluatedObject isKindOfClass:[CBProduct class]]) {
                CBProduct *product = (CBProduct*)evaluatedObject;
                return [product.name rangeOfString:text].location != NSNotFound;
            }else {
                return false;
            }
        }]];
        
        return tmpArray;
    }
}


@end
