//
//  PromoCodeInput.h
//  PromoCodeInput
//
//  Created by Андрей on 22.11.2018.
//  Copyright © 2018 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PromoCodeInputDelegate;

@interface PromoCodeInput : UIView

@property (weak,   nonatomic) id <PromoCodeInputDelegate> delegate;

-(void)show:(BOOL)animated;
-(void)initialize;
-(void)dismiss:(BOOL)animated;

@end

@protocol PromoCodeInputDelegate <NSObject>
-(void)dissmiss:(BOOL)animation vc:(NSObject*)vc;
@end

NS_ASSUME_NONNULL_END
