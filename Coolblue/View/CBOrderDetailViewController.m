//
//  CBOrderDetailViewController.m
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import "CBOrderDetailViewController.h"

@interface CBOrderDetailViewController ()

@end

@implementation CBOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = NSLocalizedString(@"Order Detail",nil);
    
    UIBarButtonItem* item =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_clear"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismiss{
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:^(){
        
    }];
}

@end
