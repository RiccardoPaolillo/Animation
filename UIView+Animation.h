//
//  UIView+Animation.h
//  indovinafb
//
//  Created by Riccardo Paolillo on 04/07/13.
//  Copyright (c) 2013 Riccardo Paolillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImage+ImageEffects.h"


typedef enum kModes
{
    kModeRelative,
    kModeAbsolute
}kModes;

typedef enum kDirection
{
    kDirectionFromLeft,
    kDirectionFromRight,
    kDirectionFromTop,
    kDirectionFromBottom
}kDirection;


@interface UIView (Animation)

- (void)flipToView:(UIView *)newView;
- (void)flipColor:(UIColor *)newColor;
- (void)flipRandom;
- (void)flipVertival;
- (void)flipOrizzontal;

- (void)setFrame:(CGRect)frame animated:(BOOL)animated;
- (void)setFrame:(CGRect)frame duration:(float)duration;

- (void)setAlpha:(CGFloat)alpha animated:(BOOL)animated duration:(float)duration;

- (void)hideView:(float)durantion;
- (void)hideView:(float)duration remove:(BOOL)remove;
- (void)hideView:(float)duration direction:(kDirection)direction mode:(kModes)mode;
- (void)hideView:(float)duration cascade:(BOOL)cascade pulse:(BOOL)pulse;

- (void)hideAllSubviewsAnimated:(BOOL)animated duration:(float)duration;
- (void)showAllSubviewsAnimated:(BOOL)animated duration:(float)duration;

- (void)showView:(float)durantion;
- (void)showView:(float)duration direction:(kDirection)direction mode:(kModes)mode;
- (void)showView:(float)duration cascade:(BOOL)cascade pulse:(BOOL)pulse;

- (void)pulsetoSize:(float)value withDuration:(float)duration;

- (void)setAnimateMethod:(BOOL)animated type:(NSString *)animationType;

- (UIImage *)toBlurImageWithRadius:(int)radius;

- (void)setParallax:(int)value;
- (void)addShadow:(CGSize)offset color:(UIColor *)color;

@end
