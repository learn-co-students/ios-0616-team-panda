//
//  TestControllerObjc.m
//  Team-Panda
//
//  Created by Flatiron School on 8/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "TestControllerObjc.h"
#import "USStatesColorMap.h"
#import <CoreText/CoreText.h>


@interface TestControllerObjc()

@property (strong, nonatomic) USStatesColorMap *colorMap;

@end

@implementation TestControllerObjc

    -(void)viewDidLoad {
        [super viewDidLoad];
        NSLog(@"\n\nview did load\n\n");
        
        self.colorMap = [[USStatesColorMap alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        [self.view addSubview:self.colorMap];
        [self.colorMap setColorForAllStates:[UIColor redColor]];
        
    }

    -(void)viewDidAppear:(BOOL)animated {
        [super viewDidAppear:animated];
        
        
//        [self.colorMap setColor:[UIColor redColor] forState:Texas];
        
//        [self.colorMapIB setColorForAllStates:[UIColor purpleColor]];
        
    }

@end


