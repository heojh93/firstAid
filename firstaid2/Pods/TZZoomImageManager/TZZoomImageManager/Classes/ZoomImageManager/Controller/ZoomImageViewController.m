//
//  ZoomImageViewController.m
//  TZZoomImageManager
//
//  Created by Sarinthon on 6/30/2559 BE.
//  Copyright © 2559 Sarinthon Mangkorn-ngam. All rights reserved.
//

#import "ZoomImageViewController.h"
#import "UIView+Constraint.h"

@interface ZoomImageViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic, strong) UIButton *closeButton;
@end

@implementation ZoomImageViewController

- (instancetype)initWithImage:(UIImage*)image{
    if (self = [super init]) {
        self.image = image;
    }
    return self;
}

#pragma mark - Overriding

- (UIScrollView *)scrolView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _imageView;
}

- (UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"closeButton"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(pressCloseButton) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setContentMode:UIViewContentModeScaleAspectFit];
        
        CGRect frame = _closeButton.frame;
        frame.size = CGSizeMake(30, 30);
        
        _closeButton.frame = frame;
    }
    return _closeButton;
}

#pragma mark - ZoomImageManager

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.scrolView];
    [self.scrollView setBackgroundColor:[UIColor blackColor]];
    
    [self.scrollView setConstraintWithWidth:AUTO height:AUTO marginLeft:AUTO marginRight:AUTO marginTop:AUTO marginBottom:AUTO];
    
    [self.imageView setImage:self.image];
    CGRect frame = self.imageView.bounds;
    frame.size = self.image.size;
    [self.imageView setFrame:frame];
    
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 0.6;
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.bouncesZoom = YES;
    self.scrollView.contentSize = self.imageView.bounds.size;
    
    [self.scrollView addSubview:self.imageView];
    
    [self setZoomScale];
    [self setupGestureRecognizer];
    
    if (self.isAddCloseButton) {
        [self.view addSubview:self.closeButton];
        [self.closeButton setConstraintWithWidth:30 height:30 marginLeft:NOFIXED marginRight:10 marginTop:10 marginBottom:NOFIXED];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [self setZoomScale];
    [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:NO];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

- (void)setZoomScale{
    CGSize imageViewSize = self.imageView.bounds.size;
    CGSize scrollViewSize = self.scrollView.bounds.size;
    CGFloat widthScale = scrollViewSize.width / imageViewSize.width;
    CGFloat heightScale = scrollViewSize.height / imageViewSize.height;
    
    self.scrollView.minimumZoomScale = MIN(widthScale, heightScale);
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGSize imageViewSize = self.imageView.frame.size;
    CGSize scrollViewSize = scrollView.bounds.size;
    
    CGFloat verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0;
    CGFloat horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0;
    scrollView.contentInset = UIEdgeInsetsMake(verticalPadding, horizontalPadding, verticalPadding, horizontalPadding);
}

#pragma mark - Gesture

- (void)setupGestureRecognizer{
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.scrollView addGestureRecognizer:doubleTap];
}

- (void)handleDoubleTap:(UITapGestureRecognizer*)recoginzer{
    if (self.scrollView.zoomScale > self.scrollView.minimumZoomScale) {
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    }
    else{
        [self.scrollView setZoomScale:self.scrollView.maximumZoomScale animated:YES];
    }
}

#pragma mark - Action

- (void)pressCloseButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
