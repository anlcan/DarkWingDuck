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

@interface AppController ()
@property (nonatomic, strong) CBOrder * currentOrder;

@end


@implementation AppController

+(AppController*)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [AppController new];
    });
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentOrder = [CBOrder new];
        self.currentOrder.products = [@[] mutableCopy];
    }
    return self;
}

#pragma mark Order

-(void)addProduct:(CBProduct*)product{
    [self.currentOrder.products addObject:product];
    [self recalculateOrderAmount];
}

-(void)removeProduct:(CBProduct*)product{
    CBProduct * inOrder = [self productInOrder:product];
    [self.currentOrder.products removeObject:inOrder];
    [self recalculateOrderAmount];
}


-(CBProduct*)productInOrder:(CBProduct*)product{
    for(CBProduct * productInBasket in self.currentOrder.products){
        if ( productInBasket.id == product.id ){
            return productInBasket;
        }
    }
    return nil;
}

-(BOOL)isProductInOrder:(CBProduct*)product{

    return [self productInOrder:product] != nil;
}

-(void)clearOrder{
    [self.currentOrder.products removeAllObjects];
    [self recalculateOrderAmount];
}


-(CBOrder*)getCurrentOrder{
    return _currentOrder;
}

-(void)recalculateOrderAmount{
    
    self.currentOrder.totalAmount = 0;
    for (CBProduct * p in self.currentOrder.products){
        self.currentOrder.totalAmount += p.price;
    }
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
