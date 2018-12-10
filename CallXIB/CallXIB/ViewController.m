//
//  ViewController.m
//  CallXIB
//
//  Created by Андрей on 22.11.2018.
//  Copyright © 2018 Home. All rights reserved.
//

#import "ViewController.h"
#import "CallXIBVC.h"
#import "CallNewXIB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)Tap:(id)sender {

    CallNewXIB *vc = [[CallNewXIB alloc] init];
    [vc initialize];
    [vc show:YES];
    
    //CallXIBVC *vc = [[CallXIBVC alloc] init];
//
  //  [self presentViewController:vc animated:NO completion:nil];
    
}

@end
