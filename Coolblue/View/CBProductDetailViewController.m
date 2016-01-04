//
//  CBProductDetailViewController.m
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#import "CBProductDetailViewController.h"

#define SPEC_SECTION 0
#define BUNDLE_SECTION 1

#define HEADER_HEIGHT 44
#define SECTION_HEIGHT 20


@interface CBProductDetailViewController ()


@end

@implementation CBProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.imgProductDetail sd_setImageWithURL:[NSURL URLWithString:self.productDetail.image]];
    self.title = self.productDetail.name;
    
    UIView * container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,HEADER_HEIGHT )];
    container.backgroundColor = [UIColor whiteColor];
    

    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,HEADER_HEIGHT )];
    label.numberOfLines = 2;
    label.text = [NSString stringWithFormat:@"%@ %@\n%.1f star %d reviews",
                  self.productDetail.name,
                  self.productDetail.inStock?@"in stock" : @"out of stock",
                  self.productDetail.star,
                  self.productDetail.reviews];
    
    [container addSubview:label];
    [self.tableDetails setTableHeaderView:container];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.view.bounds.size.width, 60);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18]];
    

    if ( [[AppController shared] isProductInOrder:self.productDetail]){
        [button addTarget:self action:@selector(removeFromOrder) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor redColor]];
        [button setTitle:NSLocalizedString(@"Remove from order",nil) forState:UIControlStateNormal];
    }else {
        [button addTarget:self action:@selector(addToOrder) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor darkGrayColor]];
        [button setTitle:NSLocalizedString(@"Add to order",nil) forState:UIControlStateNormal];
    }

    
    
    self.accesoryView = button;
    

    UIBarButtonItem* item =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_shopping_basket"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(presentOrderViewController)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addToOrder{
    [[AppController shared] addProduct:self.productDetail];
    
    UIButton * button = (UIButton*)self.accesoryView;
    [button addTarget:self action:@selector(removeFromOrder) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitle:NSLocalizedString(@"Remove from order",nil) forState:UIControlStateNormal];
}

-(void)removeFromOrder{
    [[AppController shared] removeProduct:self.productDetail];
    [self.navigationController popViewControllerAnimated:YES];
}

//==============================================================================
#pragma mark tableviewdelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SECTION_HEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == SPEC_SECTION? [self.productDetail.specs count]:[self.productDetail.bundles count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* ident = indexPath.section == SPEC_SECTION?
    @"spec" : @"bundle";
    UITableViewCellStyle style = indexPath.section == SPEC_SECTION?
    UITableViewCellStyleValue1 : UITableViewCellStyleSubtitle;
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if ( cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:style
                                       reuseIdentifier:ident];
    }
    
    
    if ( indexPath.section == SPEC_SECTION){
        CBSpec * spec =[self.productDetail.specs objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = spec.value;
        cell.textLabel.text = spec.name;
    } else {
        CBBundle * bundle =[self.productDetail.bundles objectAtIndex:indexPath.row];

        

        
        NSAttributedString *first = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f",
                                                                                              bundle.price]
                                                                                  attributes:@{NSStrikethroughStyleAttributeName:
                                                                                                   [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
        
        NSAttributedString * second =[[NSAttributedString alloc] initWithString:[NSString  stringWithFormat:@" %.2f",
                                                                             bundle.discountPrice]];
        
        NSMutableAttributedString * all = [first mutableCopy];
        [all appendAttributedString:second];
        cell.detailTextLabel.attributedText = all;
        cell.textLabel.text = bundle.name;

    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( indexPath.section == BUNDLE_SECTION){
        CBBundle * bundle =[self.productDetail.bundles objectAtIndex:indexPath.row];
        CBProductDetail * detail = [CBProductDetail new];
        detail.name = bundle.name;
        detail.price = bundle.price;
        detail.image = @"https://unsplash.it/200/300/?random";
        detail.inStock = YES;
        detail.reviews = 133;
        detail.star = 1.5;
        
        [self pushProductDetail:detail];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
