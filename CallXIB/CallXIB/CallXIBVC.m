//
//  CallXIBVC.m
//  CallXIB
//
//  Created by Андрей on 22.11.2018.
//  Copyright © 2018 Home. All rights reserved.
//

#import "CallXIBVC.h"

@interface CallXIBVC ()
@property (strong, nonatomic) IBOutlet UIView *refCodeView;

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation CallXIBVC

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self customInit];
    }
    return self;
}


-(void)customInit{
    [[NSBundle mainBundle] loadNibNamed:@"CallXIB" owner:self options:nil];
    [self.view addSubview:self.contentView];
    self.contentView.frame = self.view.bounds;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self customInit];
//    [self.view setBackgroundColor:[UIColor clearColor]];
    
}


@end
