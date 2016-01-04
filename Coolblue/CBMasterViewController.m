//
//  CBMasterViewController.m
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import "CBMasterViewController.h"
#import "CBProduct.h"
#import "CBProductDetail.h"
#import "CBProductDetailViewController.h"

@interface CBMasterViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) NSString * searchText;

@property (nonatomic, strong) NSArray * array;
@end

@implementation CBMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CoolBlue";
    // Do any additional setup after loading the view from its nib.
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 60)] ;
    self.searchBar.showsCancelButton = NO;
    self.searchBar.delegate = self;
    self.searchBar.placeholder = NSLocalizedString(@"Product name, description", nil);
    self.searchBar.keyboardType = UIKeyboardTypeNumberPad;
    //self.searchBar.searchBarStyle = UISearchBarStyleProminent;
    
    self.tableProducts.tableHeaderView = self.searchBar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self fetchProducts];
    [self hideSearchBar];
}

- (void)hideSearchBar {
    
    [self.searchBar resignFirstResponder];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.tableProducts.contentOffset = CGPointMake(0, 0);
    } completion:nil];
}


-(void)fetchProducts{
    
    NSURLRequest * request = [self requestForPath:@"/products"];
    
    CBMasterViewController *__weak weakSelf = self;
    NSURLSessionDataTask * task = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [weakSelf dismissProgress];
        if ( !nil){
            NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
            
            for ( NSDictionary * dict in responseObject){
                CBProduct * product = [self parse:dict forClass:[CBProduct class]];
                [array addObject:product];
            }
            // update controller/manager products so others can access it...
            [AppController shared].currentProducts = array;
            [weakSelf resetSearch];
        }
        
    }];
    
    [task resume];
    [self showProgress];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* ident = @"";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if ( cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:ident];
    }
    
    CBProduct * product = [self.array objectAtIndex:indexPath.row];
    cell.textLabel.text = product.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", product.price];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CBProduct * product = [self.array objectAtIndex:indexPath.row];
    
    
    // the correct way to do this is ..
    //NSString * path = [NSString stringWithFormat:@"/products/%d", product.id];
    // .....but since we are mocking.
    NSString * path = [NSString stringWithFormat:@"/products/%d", 1];
    NSURLRequest * request = [self requestForPath:path];
    
    CBMasterViewController *__weak weakSelf = self;
    NSURLSessionDataTask * task = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [weakSelf dismissProgress];
        if ( !nil){
            CBProductDetail * productDetail = [self parse:responseObject forClass:[CBProductDetail class]];
            [weakSelf pushProductDetail:productDetail];
        }
        
    }];
    
    [task resume];
    [self showProgress];
    
}

-(void)pushProductDetail:(CBProductDetail*)detail{
    CBProductDetailViewController * detailVC = _create(CBProductDetailViewController);
    detailVC.productDetail = detail;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UISearchBar Delegate
-(void)resetSearch{
    self.array = [AppController shared].currentProducts;
    [self.tableProducts reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self hideSearchBar];
    [self resetSearch];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    
    [self setSearchText:searchText];
    [searchBar setShowsCancelButton:(searchText.length > 0) animated:YES];
    
    self.array = [[AppController shared] filteredProducts:self.searchText];
    [self.tableProducts reloadData];
    
}



@end
