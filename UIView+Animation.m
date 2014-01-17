//
//  UIView+Animation.m
//  indovinafb
//
//  Created by Riccardo Paolillo on 04/07/13.
//  Copyright (c) 2013 Riccardo Paolillo. All rights reserved.
//

#import "UIView+Animation.h"


@implementation UIView (Animation)


- (void)flipToView:(UIView *)newView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:newView cache:YES];
    
    [newView removeFromSuperview];
    [self addSubview:newView];
    
    [UIView commitAnimations];
}

- (void)flipColor:(UIColor *)newColor
{
    [UIView animateWithDuration:0.3 animations:^
    {
        self.layer.transform = CATransform3DMakeRotation(-M_PI_2,0.0,0.0,1.0);
    }
    completion:^(BOOL finished)
    {
        if (finished)
        {
            self.backgroundColor = newColor;
            [self restoreRotation];
        }
    }];
}

- (void)flipRandom
{
    if (arc4random()%2 == 0)
        [self flipOrizzontal];
    else
        [self flipVertival];
}

- (void)flipVertival
{
    [UIView animateWithDuration:0.5 animations:^
    {
        self.layer.transform = CATransform3DMakeRotation(-M_PI_2,1.0,0.0,0.0);
    }
    completion:^(BOOL finished)
    {
        if (finished)
            [self restoreRotation];
    }];
}

- (void)flipOrizzontal
{
    [UIView animateWithDuration:0.5 animations:^
    {
        self.layer.transform = CATransform3DMakeRotation(-M_PI_2,0.0,1.0,0.0);
    }
    completion:^(BOOL finished)
    {
        if (finished)
            [self restoreRotation];
    }];
}

- (void)restoreRotation
{
    [UIView animateWithDuration:0.5
                     animations:^{self.layer.transform = CATransform3DMakeRotation(M_PI_2,0.0,0.0,0.0);}
                     completion:^(BOOL finished){}];
}



- (void)pulsetoSize:(float)value withDuration:(float)duration
{
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = duration;
    pulseAnimation.toValue  = [NSNumber numberWithFloat:value];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount  = 1;
    
    [self.layer addAnimation:pulseAnimation forKey:nil];
}


- (void)setFrame:(CGRect)frame animated:(BOOL)animated
{
    if (animated)
        [self setFrame:frame duration:1.0];
    else
        self.frame = frame;
}

- (void)setFrame:(CGRect)frame duration:(float)duration
{
    [UIView animateWithDuration:duration animations:^{self.frame = frame;} completion:nil];
}

- (void)setAlpha:(CGFloat)alpha animated:(BOOL)animated duration:(float)duration
{
    if (animated)
        [UIView animateWithDuration:duration animations:^{self.alpha = alpha;} completion:nil];
    else
        [self setAlpha:alpha];
}


- (void)showView:(float)duration direction:(kDirection)direction mode:(kModes)mode
{
    [self hideView:0];
    
    switch (mode)
    {
        case kModeAbsolute:
            [self showView:duration absoluteDirection:direction];
            break;
        
        case kModeRelative:
            [self showView:duration relativeDirection:direction];
            break;
            
        default:
            break;
    }
}

- (void)showView:(float)duration absoluteDirection:(kDirection)direction
{
    int destX = self.frame.origin.x;
    int destY = self.frame.origin.y;
    
    int startX;
    int startY;
    
    switch (direction)
    {
        case kDirectionFromRight:
            startX = -self.frame.size.width;
            startY = destY;
            break;
            
        case kDirectionFromLeft:
            startX = [UIScreen mainScreen].bounds.size.width;
            startY = destY;
            break;
            
        case kDirectionFromTop:
            startY = -self.frame.size.height;
            startX = destX;
            break;
            
        case kDirectionFromBottom:
            startY = [UIScreen mainScreen].bounds.size.height;
            startX = destX;
            break;
            
        default:
            break;
    }
    
    [self showView:duration];
    [self setFrame:CGRectMake(startX, startY, self.frame.size.width, self.frame.size.height)];
    [self setFrame:CGRectMake(destX,  destY,  self.frame.size.width, self.frame.size.height) duration:duration];
}

- (void)showView:(float)duration relativeDirection:(kDirection)direction
{
    int destX = self.frame.origin.x;
    int destY = self.frame.origin.y;
    
    int startX;
    int startY;
    
    switch (direction)
    {
        case kDirectionFromRight:
            startX = destX+self.frame.size.width;
            startY = destY;
            break;
            
        case kDirectionFromLeft:
            startX = destX-self.frame.size.width;
            startY = destY;
            break;
         
        case kDirectionFromTop:
            startY = destY-self.frame.size.height;
            startX = destX;
            break;
            
        case kDirectionFromBottom:
            startY = destY+self.frame.size.height;
            startX = destX;
            break;
            
        default:
            break;
    }
    
    [self showView:duration];
    [self setFrame:CGRectMake(startX, startY, self.frame.size.width, self.frame.size.height)];
    [self setFrame:CGRectMake(destX,  destY,  self.frame.size.width, self.frame.size.height) duration:duration];
}


- (void)hideView:(float)duration direction:(kDirection)direction mode:(kModes)mode
{
    [self showView:0];
    
    switch (mode)
    {
        case kModeAbsolute:
            [self hideView:duration absoluteDirection:direction];
            break;
            
        case kModeRelative:
            [self hideView:duration relativeDirection:direction];
            break;
            
        default:
            break;
    }
}

- (void)hideView:(float)duration absoluteDirection:(kDirection)direction
{
    int destX = self.frame.origin.x;
    int destY = self.frame.origin.y;
    
    int startX;
    int startY;
    
    switch (direction)
    {
        case kDirectionFromRight:
            startX = -self.frame.size.width;
            startY = destY;
            break;
            
        case kDirectionFromLeft:
            startX = [UIScreen mainScreen].bounds.size.width;
            startY = destY;
            break;
            
        case kDirectionFromTop:
            startY = -self.frame.size.height;
            startX = destX;
            break;
            
        case kDirectionFromBottom:
            startY = [UIScreen mainScreen].bounds.size.height;
            startX = destX;
            break;
            
        default:
            break;
    }
    
    [self hideView:duration];
    [self setFrame:CGRectMake(destX,  destY,  self.frame.size.width, self.frame.size.height)];
    [self setFrame:CGRectMake(startX, startY, self.frame.size.width, self.frame.size.height)
          duration:duration];
}

- (void)hideView:(float)duration relativeDirection:(kDirection)direction
{
    int destX = self.frame.origin.x;
    int destY = self.frame.origin.y;
    
    int startX;
    int startY;
    
    switch (direction)
    {
        case kDirectionFromRight:
            startX = destX+self.frame.size.width;
            startY = destY;
            break;
            
        case kDirectionFromLeft:
            startX = destX-self.frame.size.width;
            startY = destY;
            break;
            
        case kDirectionFromTop:
            startY = destY-self.frame.size.height;
            startX = destX;
            break;
            
        case kDirectionFromBottom:
            startY = destY+self.frame.size.height;
            startX = destX;
            break;
            
        default:
            break;
    }
    
    [self hideView:duration];
    [self setFrame:CGRectMake(destX,  destY,  self.frame.size.width, self.frame.size.height)];
    [self setFrame:CGRectMake(startX, startY, self.frame.size.width, self.frame.size.height) duration:duration];
}


- (void)hideView:(float)duration remove:(BOOL)remove
{
    [UIView animateWithDuration:duration animations:^{ self.alpha = 0; }
    completion:^(BOOL finished)
    {
        if (finished && remove)
            [self removeFromSuperview];
    }];
}

- (void)hideView:(float)duration
{
    [self setAlpha:0 animated:YES duration:duration];
}

- (void)showView:(float)duration
{
    [self setAlpha:1 animated:YES duration:duration];
}

- (void)hideAllSubviewsAnimated:(BOOL)animated duration:(float)duration
{
    for (UIView *v in self.subviews)
        [v setAlpha:0 animated:animated duration:duration];
}

- (void)showAllSubviewsAnimated:(BOOL)animated duration:(float)duration
{
    for (UIView *v in self.subviews)
        [v setAlpha:1 animated:animated duration:duration];
}

- (void)showView:(float)duration cascade:(BOOL)cascade pulse:(BOOL)pulse
{
    if (cascade)
    {
        [self setAlpha:1 animated:NO duration:0];                     //Show container
        [self hideAllSubviewsAnimated:NO duration:0];                 //Hide subviews
        [self showSubviewStartIndex:0 duration:duration pulse:pulse]; //Show subviews one at time
    }
    else
    {
        if (pulse)
        {
            [self showView:duration];
            [self pulsetoSize:1.1 withDuration:duration];
        }
        [self showView:duration];
    }
}
- (void)showSubviewStartIndex:(int)index duration:(float)duration pulse:(BOOL)pulse
{
    [UIView animateWithDuration:duration animations:^(void)
    {
        [self.subviews[index] setAlpha:1];
        
        if (pulse)
            [self.subviews[index] pulsetoSize:1.1 withDuration:duration];
    }
    completion:^(BOOL finished)
    {
        if (index+1 < [self.subviews count])
            [self showSubviewStartIndex:index+1 duration:duration pulse:pulse];
        else
            [self showView:0];
    }];
}


- (void)hideView:(float)duration cascade:(BOOL)cascade pulse:(BOOL)pulse
{
    if (cascade)
    {
        [self hideSubviewStartIndex:0 duration:duration pulse:pulse]; //Show subviews one at time
    }
    else
    {
        if (pulse)
        {
            [self hideView:duration];
            [self pulsetoSize:0.8 withDuration:duration];
        }
        [self hideView:duration];
    }
}
- (void)hideSubviewStartIndex:(int)index duration:(float)duration pulse:(BOOL)pulse
{
    [UIView animateWithDuration:duration animations:^(void)
    {
        [self.subviews[index] setAlpha:0];
     
        if (pulse)
            [self.subviews[index] pulsetoSize:0.8 withDuration:duration];
    }
    completion:^(BOOL finished)
    {
        if (index+1 < [self.subviews count])
            [self hideSubviewStartIndex:index+1 duration:duration pulse:pulse];
        else
            [self hideView:0];
    }];
}


@end
