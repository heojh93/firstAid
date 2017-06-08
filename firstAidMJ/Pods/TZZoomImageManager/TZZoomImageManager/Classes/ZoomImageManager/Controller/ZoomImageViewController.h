//
//  ZoomImageViewController.h
//  TZZoomImageManager
//
//  Created by Sarinthon on 6/30/2559 BE.
//  Copyright © 2559 Sarinthon Mangkorn-ngam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomImageViewController : UIViewController

@property (nonatomic) BOOL isAddCloseButton;

- (instancetype)initWithImage:(UIImage*)image;

@end
