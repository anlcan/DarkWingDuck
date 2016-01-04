//
//  CBProductDetailViewController.h
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import "CBBAseViewController.h"
#import "CBProductDetail.h"

@interface CBProductDetailViewController : CBBAseViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) CBProductDetail* productDetail;
@property (weak, nonatomic) IBOutlet UIImageView *imgProductDetail;

@property (weak, nonatomic) IBOutlet UITableView *tableDetails;

@end
