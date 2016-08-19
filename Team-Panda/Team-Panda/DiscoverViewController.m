//
//  DiscoverViewController.m
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController ()

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation DiscoverViewController

static NSString *basicCell = @"basicCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: basicCell];
    
    self.tableView.rowHeight = 100;
    [self createViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createViews {

    [self.view addSubview:self.tableView];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.tableView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.75 constant:0].active = true;
    [self.tableView.widthAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:1 constant:0].active = true;
    [self.tableView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.tableView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = true;
    
    self.tableView.backgroundColor = [UIColor yellowColor];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewCell *secondCell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:basicCell];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier: basicCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:basicCell];
    }
    
//    cell.textLabel.text = @"Test";
    
    [cell.textLabel setText:@"Test"];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    cell.backgroundColor = [UIColor redColor];
    NSLog(@"Cell Text: %@", cell.textLabel.text);
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

@end
