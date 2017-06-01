//
//  UIView+Constraint.m
//  FamilyCare_iOS
//
//  Created by Sarinthon Mangkorn-ngam on 4/11/2559 BE.
//  Copyright © 2559 Sarinthon Mangkorn-ngam. All rights reserved.
//

#import "UIView+Constraint.h"

@implementation UIView (Constraint)

- (void)setConstraintWithWidth:(ConstraintType)width height:(ConstraintType)height marginLeft:(CGFloat)marginLeft marginRight:(CGFloat)marginRight marginTop:(CGFloat)marginTop marginBottom:(CGFloat)marginBottom{
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if (constraint.firstItem == self) {
            [self.superview removeConstraint:constraint];
        }
    }
    
    NSDictionary *dicView = NSDictionaryOfVariableBindings(self);
    NSString *marginLeftToStr = marginLeft == AUTO?@"|-0-":marginLeft == NOFIXED?@"":[NSString stringWithFormat:@"|-%f-", marginLeft];
    
    NSString *marginRightToStr = marginRight == AUTO?@"-0-|":marginRight == NOFIXED?@"":[NSString stringWithFormat:@"-%f-|", marginRight];
    NSString *marginTopToStr = marginTop == AUTO?@"|-0-":marginTop == NOFIXED?@"":[NSString stringWithFormat:@"|-%f-", marginTop];
    NSString *marginBottomToStr = marginBottom == AUTO?@"-0-|":marginBottom == NOFIXED?@"":[NSString stringWithFormat:@"-%f-|", marginBottom];
    NSString *widthToStr = width == AUTO?@"":width == NOFIXED?@"":[NSString stringWithFormat:@"(%ld)", (long)width];
    NSString *heightToStr = height == AUTO?@"":height == NOFIXED?@"":[NSString stringWithFormat:@"(%ld)", (long)height];
    
    NSString *strXConstraint = [NSString stringWithFormat:@"H:%@[self%@]%@", marginLeftToStr, widthToStr, marginRightToStr];
    NSString *strYConstraint = [NSString stringWithFormat:@"V:%@[self%@]%@", marginTopToStr, heightToStr, marginBottomToStr];
    
    NSArray *xConstraint = [NSLayoutConstraint constraintsWithVisualFormat:strXConstraint options:0 metrics:nil views:dicView];
    NSArray *yConstraint = [NSLayoutConstraint constraintsWithVisualFormat:strYConstraint options:0 metrics:nil views:dicView];
    
    [self.superview addConstraints:xConstraint];
    [self.superview addConstraints:yConstraint];
    
    if (marginLeft == NOFIXED && marginRight == NOFIXED) {
        [self.superview addConstraint:
         [NSLayoutConstraint constraintWithItem:self
                                      attribute:NSLayoutAttributeCenterX
                                      relatedBy:0
                                         toItem:self.superview
                                      attribute:NSLayoutAttributeCenterX
                                     multiplier:1
                                       constant:0]];
    }
    if (marginTop == NOFIXED && marginBottom == NOFIXED) {
        [self.superview addConstraint:
         [NSLayoutConstraint constraintWithItem:self
                                      attribute:NSLayoutAttributeCenterY
                                      relatedBy:0
                                         toItem:self.superview
                                      attribute:NSLayoutAttributeCenterY
                                     multiplier:1
                                       constant:0]];
    }
}

@end
