#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GCDSingleton.h"
#import "UIView+Constraint.h"
#import "ZoomImageViewController.h"
#import "ZoomImageManager.h"

FOUNDATION_EXPORT double TZZoomImageManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char TZZoomImageManagerVersionString[];

