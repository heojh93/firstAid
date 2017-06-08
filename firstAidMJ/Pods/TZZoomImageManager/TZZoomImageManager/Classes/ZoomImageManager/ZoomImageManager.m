//
//  ZoomImageManager.m
//  TZZoomImageManager
//
//  Created by Sarinthon on 6/30/2559 BE.
//  Copyright © 2559 Sarinthon Mangkorn-ngam. All rights reserved.
//

#import "ZoomImageManager.h"
#import "GCDSingleton.h"
#import "ZoomImageViewController.h"

@interface ZoomImageManager ()
@property (nonatomic, strong) ZoomImageViewController *zoomImageVC;
@end

@implementation ZoomImageManager

#pragma mark - ZoomImageManager

+ (id)defadefaultManager{
    SINGLETON(^{
        return [[self alloc] init];
    });
}

- (void)zoomWithImage:(UIImage*)image onView:(UIView*)view inController:(UIViewController*)controller isNavigation:(BOOL)isNavigation{
    if (image) {
        self.zoomImageVC = [[ZoomImageViewController alloc] initWithImage:image];
        
        if (isNavigation) {
            [controller.navigationController pushViewController:self.zoomImageVC animated:YES];
        }
        else{
            
            if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [self.zoomImageVC setModalPresentationStyle:UIModalPresentationPopover];
                
                UIPopoverPresentationController *popController = self.zoomImageVC.popoverPresentationController;
                [popController setPermittedArrowDirections:UIPopoverArrowDirectionUp];
                [popController setSourceView:self.zoomImageVC.view];
                [popController setSourceRect:view.frame];
                
                [self.zoomImageVC setPreferredContentSize:CGSizeMake(550, 400)];
            }
            else{
                [self.zoomImageVC setIsAddCloseButton:YES];
            }
            
            [controller presentViewController:self.zoomImageVC animated:YES completion:nil];
        }
    }
}

@end
