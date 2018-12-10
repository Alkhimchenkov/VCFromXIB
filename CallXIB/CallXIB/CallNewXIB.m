//
//  CallNewXIB.m
//  CallXIB
//
//  Created by Андрей on 22.11.2018.
//  Copyright © 2018 Home. All rights reserved.
//

#import "CallNewXIB.h"

#define COLOR_BUTTON 0xf5a622
#define COLOR_BACKGROUND 0x213550

#define UIColorFromHEX(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]


@interface CallNewXIB () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *content;

@property (strong, nonatomic) IBOutlet UIView *dialogView;
@property (strong, nonatomic) IBOutlet UILabel *codeRefferalLabel;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *codeRefferalTextFields;
@property (strong, nonatomic) IBOutlet UIButton *codeUseCodeButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *codeRefferalActivityIndicator;
@property (strong, nonatomic) IBOutlet UIButton *codeSkipButton;
@property (strong, nonatomic) IBOutlet UIButton *codeClearButton;


@end

@implementation CallNewXIB


- (id)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self customInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self customInit];
    }
    return self;
}

-(void)customInit{
    [[NSBundle mainBundle] loadNibNamed:@"CallNewXIB" owner:self options:nil];
        [self addSubview:self.content];
        self.content.frame = self.bounds;
}

-(void)initialize{
    
    self.dialogView.layer.cornerRadius = 6;
    self.dialogView.clipsToBounds = YES;
    self.dialogView.backgroundColor = UIColorFromHEX(COLOR_BACKGROUND);
    
    for (UITextField *field in _codeRefferalTextFields) {
        field.delegate = self;
        field.text = @"";
        field.backgroundColor = [UIColor clearColor];
        field.layer.borderColor = [UIColor whiteColor].CGColor;
        field.textColor = [UIColor blackColor];
    }
    
    [self.codeUseCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.codeUseCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [self.codeUseCodeButton setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.codeSkipButton setTintColor:[UIColor whiteColor]];
    [self.codeClearButton setTintColor:[UIColor whiteColor]];
    
}

-(void)show:(BOOL)animated{
    UIViewController *topController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    if (topController){
        
        UIViewController *presentedViewController = [[UIViewController alloc] init];
        
        presentedViewController = topController.presentedViewController;
        while ([presentedViewController isEqual:topController.presentedViewController]) {
            topController = presentedViewController;
        }
        [topController.view addSubview:self];
    }
    
    if (animated){

        self.dialogView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        self.dialogView.center = self.center;

        self.dialogView.transform = CGAffineTransformMakeTranslation(0, topController.view.frame.size.height + self.dialogView.frame.size.height );


        [UIView animateWithDuration:0.33 animations:^{
            self.dialogView.layer.transform = CATransform3DIdentity;
            self.dialogView.transform = CGAffineTransformMakeScale(1, 1);
        }];
        [self.codeRefferalTextFields.firstObject becomeFirstResponder];
    } else {
        self.dialogView.center = self.center;
        [self.codeRefferalTextFields.firstObject becomeFirstResponder];
    }
}

-(void)dismiss:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.33
                              delay:0
             usingSpringWithDamping:1
              initialSpringVelocity:10
                            options:0
                         animations:^{
                             self.dialogView.center =CGPointMake(self.center.x, self.frame.size.height + self.dialogView.frame.size.height / 2);
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    }else{
        [self removeFromSuperview];
    }
}

- (IBAction)focusOnLastRefferalField:(id)sender {
    if ( ((UITextField*)_codeRefferalTextFields.firstObject).text.length == 0 ){
        [(UITextField*)(_codeRefferalTextFields.firstObject) becomeFirstResponder];
    } else {
        [(UITextField*)(_codeRefferalTextFields.lastObject) becomeFirstResponder];
    }
}

- (IBAction)dissmiss:(id)sender {
    [self dismiss:YES];

}

- (IBAction)enteredRefferalCodeCharacter:(UITextField*)sender {
    // update field UI
    __block BOOL isFilled = sender.text.length > 0 ? YES:NO;
    [UIView animateWithDuration:0.3f animations:^{
        sender.backgroundColor = isFilled ? [UIColor whiteColor]:[UIColor clearColor];
    }];
    
    // update the uses button
    NSInteger fillTextCount = 0;
    for (UITextField *field in _codeRefferalTextFields) {
        if ( field.text.length > 0){
            fillTextCount++;
        }
    }
    
    __block BOOL allFilled = ( fillTextCount == _codeRefferalTextFields.count ) ? YES:NO;
    [UIView animateWithDuration:0.3f animations:^{
        self.codeUseCodeButton.enabled = allFilled;
        self.codeUseCodeButton.backgroundColor = allFilled ? UIColorFromHEX(COLOR_BUTTON):[UIColor lightGrayColor];
    }];
    
    
    // transfer responder to next field
    [sender resignFirstResponder];
    for (UITextField *field in _codeRefferalTextFields) {
        if ( field.text.length == 0){
            [field becomeFirstResponder];
            break;
        }
    }

}

@end
