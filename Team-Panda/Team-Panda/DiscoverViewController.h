//
//  DiscoverViewController.h
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *jobsList;

-(void)viewDidLoad;
-(void)didReceiveMemoryWarning;
-(void)createViews;

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

@end
