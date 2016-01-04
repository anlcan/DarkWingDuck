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
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.view.bounds.size.width, 60);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18]];
    [button setBackgroundColor:[UIColor darkGrayColor]];
    
    self.accesoryView = button;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIButton *button =(UIButton*)self.accesoryView;
    NSString * title =[NSString stringWithFormat:@"%@ %.2f",
                       NSLocalizedString(@"Checkout:",nil),
                       [[AppController shared] getCurrentOrder].totalAmount];
    
    [button setTitle:title
            forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismiss{
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:^(){
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[AppController shared].getCurrentOrder.products count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* ident = @"";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if ( cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:ident];
    }
    
    
    CBProduct * product = [[AppController shared].getCurrentOrder.products objectAtIndex:indexPath.row];
    cell.textLabel.text = product.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", product.price]; // this should be on product...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
