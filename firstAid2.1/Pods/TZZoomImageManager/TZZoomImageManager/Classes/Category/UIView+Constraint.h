//
//  UIView+Constraint.h
//  FamilyCare_iOS
//
//  Created by Sarinthon Mangkorn-ngam on 4/11/2559 BE.
//  Copyright © 2559 Sarinthon Mangkorn-ngam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    AUTO = -1,
    NOFIXED = -2
} ConstraintType;

@interface UIView (Constraint)

- (void)setConstraintWithWidth:(ConstraintType)width height:(ConstraintType)height marginLeft:(CGFloat)marginLeft marginRight:(CGFloat)marginRight marginTop:(CGFloat)marginTop marginBottom:(CGFloat)marginBottom;

@end
