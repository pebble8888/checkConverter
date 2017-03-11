//
//  ViewController.m
//  checkConverter
//
//  Created by pebble8888 on 2016/07/01.
//  Copyright © 2016年 pebble8888. All rights reserved.
//

#import "ViewController.h"
#import "MyEncoder.h"

@interface ViewController ()
@property MyEncoder* encoder;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.encoder = [[MyEncoder alloc] init];
    [self.encoder run];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
