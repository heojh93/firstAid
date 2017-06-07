//
//  ZoomImageManager.h
//  TZZoomImageManager
//
//  Created by Sarinthon on 6/30/2559 BE.
//  Copyright © 2559 Sarinthon Mangkorn-ngam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZoomImageManager : NSObject

+ (id)defadefaultManager;
- (void)zoomWithImage:(UIImage*)image onView:(UIView*)view inController:(UIViewController*)controller isNavigation:(BOOL)isNavigation;

@end
