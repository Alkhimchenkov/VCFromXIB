//
//  ViewController.m
//  CallXIB
//
//  Created by Андрей on 22.11.2018.
//  Copyright © 2018 Home. All rights reserved.
//

#import "ViewController.h"
#import "CallXIBVC.h"
#import "PromoCodeInput.h"

@interface ViewController () <PromoCodeInputDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)Tap:(id)sender {

    PromoCodeInput *vc = [[PromoCodeInput alloc] init];
    vc.delegate = self;
    [vc initialize];
    [vc show:YES];
    
    //CallXIBVC *vc = [[CallXIBVC alloc] init];
//
  //  [self presentViewController:vc animated:NO completion:nil];
    
}


-(void)dissmiss:(BOOL)animation vc:(NSObject*)vc{
    [(PromoCodeInput*)vc dismiss:YES];
}



@end
