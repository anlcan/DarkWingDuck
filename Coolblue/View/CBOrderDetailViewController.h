//
//  CBOrderDetailViewController.h
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import "CBBAseViewController.h"

@interface CBOrderDetailViewController : CBBAseViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableProducts;

@end
