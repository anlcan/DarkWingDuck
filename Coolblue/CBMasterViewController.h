//
//  CBMasterViewController.h
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBBaseViewController.h"

@interface CBMasterViewController : CBBAseViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableProducts;

@end
