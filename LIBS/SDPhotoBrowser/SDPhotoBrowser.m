//
//  SDPhotoBrowser.m
//  photobrowser
//
//  Created by aier on 15-2-3.
//  Copyright (c) 2015年 aier. All rights reserved.
//

#import "SDPhotoBrowser.h"
#import "UIImageView+WebCache.h"
#import "SDBrowserImageView.h"

 
//  ============在这里方便配置样式相关设置===========

//                      ||
//                      ||
//                      ||
//                     \\//
//                      \/

#import "SDPhotoBrowserConfig.h"

//  =============================================
#import "XAOrderWaringView.h"

@implementation urlObject

@end

@interface SDPhotoBrowser()
@property (nonatomic , strong)XAOrderWaringView *shanchuWaringView;
@property (nonatomic , strong)UIScrollView *scrollView;
@property (nonatomic , strong)UILabel *indexLabel;
@property (nonatomic , strong)UIView *navigaitonView;
@end
@implementation SDPhotoBrowser 
{
    BOOL _hasShowedFistView;
    UILabel *_indexLabel;
    UIButton *_deleteBtn;
    UIActivityIndicatorView *_indicatorView;
    BOOL _willDisappear;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = SDPhotoBrowserBackgrounColor;
    }
    return self;
}


- (void)didMoveToSuperview
{
    if (self.imageCount>0) {
        [self setupScrollView];
        [self setupNavagitionbars];
    }
;
}

- (void)dealloc
{
    [[UIApplication sharedApplication].keyWindow removeObserver:self forKeyPath:@"frame"];
}

- (void)setupNavagitionbars
{
    self.navigaitonView = [[UIView alloc] init];
    self.navigaitonView.frame = CGRectMake(screen_Width, 0, screen_Width, 64);
    self.navigaitonView.backgroundColor = RGBColor(34, 34, 34, 1);
    
    [self addSubview:self.navigaitonView];

    // 1. 序标
    UILabel *indexLabel = [[UILabel alloc] init];
    indexLabel.bounds = CGRectMake(0, 0, 300, 50);
    indexLabel.textAlignment = NSTextAlignmentCenter;
    indexLabel.textColor = [UIColor whiteColor];
    indexLabel.font = FontNomrol(17);
    if (self.imageCount >= 1) {
        indexLabel.text = [self didChangeLabelNameForIndex:self.currentImageIndex];
    }
    _indexLabel = indexLabel;
    [self.navigaitonView addSubview:indexLabel];
    // 2.保存按钮
    UIButton *deleteBtn = [[UIButton alloc] init];
    [deleteBtn setImage:Image(@"icon_Trash") forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.frame = CGRectMake(screen_Width-50,25, 50, 30);
    _deleteBtn = deleteBtn;
    indexLabel.center = deleteBtn.center;

    [self.navigaitonView addSubview:deleteBtn];
    
//    UIButton *backBtn = [[UIButton alloc] init];
//    [backBtn setImage:Image(@"pay_tanchukuangicon_fanhui") forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(photoClick:) forControlEvents:UIControlEventTouchUpInside];
//    backBtn.frame = CGRectMake(0,25, 50, 30);
//    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//    
//    [self.navigaitonView addSubview:backBtn];
    
    
    UIImageView * bacImg = [[UIImageView alloc]initWithFrame:CGRectMake(13, 31, 11, 20)];
    bacImg.image = [UIImage imageNamed:@"fanhui"];
    [self.navigaitonView  addSubview:bacImg];
    UIButton * bacBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 100, 44)];
    [bacBt addTarget:self action:@selector(photoClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigaitonView addSubview:bacBt];

    
    
    
    
    
}

- (void)saveImage
{
    
    [[[UIApplication sharedApplication] keyWindow] addSubview: self.shanchuWaringView];
    WeakSelf;
    self.shanchuWaringView.gotoSend = ^{
        [weakSelf.shanchuWaringView removeFromSuperview];
        [weakSelf.scrollView.subviews[weakSelf.currentImageIndex] removeFromSuperview];

        
        [weakSelf didDeleteImageForIndex:weakSelf.currentImageIndex];
        weakSelf.imageCount--;
        if (weakSelf.scrollView.subviews.count ==0) {
            [weakSelf didapper];
            return;
        }else{
            if (weakSelf.currentImageIndex ==  weakSelf.imageCount) {
                CGFloat offsetY = weakSelf.scrollView.contentOffset.x;
                weakSelf.scrollView.contentOffset = CGPointMake(offsetY-weakSelf.scrollView.frame.size.width, 0);
            }
            [weakSelf setNeedsLayout];
            [weakSelf layoutIfNeeded];
            [weakSelf setupImageOfImageViewForIndex:weakSelf.currentImageIndex];
            weakSelf.indexLabel.text = [weakSelf didChangeLabelNameForIndex:weakSelf.currentImageIndex];
        }
        
        

    };
    
    
    

//    int index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
//    UIImageView *currentImageView = _scrollView.subviews[index];
//    
//    UIImageWriteToSavedPhotosAlbum(currentImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//    
//    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
//    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
//    indicator.center = self.center;
//    _indicatorView = indicator;
//    [[UIApplication sharedApplication].keyWindow addSubview:indicator];
//    [indicator startAnimating];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    [_indicatorView removeFromSuperview];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.bounds = CGRectMake(0, 0, 150, 30);
    label.center = self.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
    if (error) {
        label.text = SDPhotoBrowserSaveImageFailText;
    }   else {
        label.text = SDPhotoBrowserSaveImageSuccessText;
    }
    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}

- (void)setupScrollView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    for (int i = 0; i < self.imageCount; i++) {
        SDBrowserImageView *imageView = [[SDBrowserImageView alloc] init];
        imageView.tag = i;

        // 单击图片
      //  UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoClick:)];
        
        // 双击放大图片
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDoubleTaped:)];
        doubleTap.numberOfTapsRequired = 2;
        
      //  [singleTap requireGestureRecognizerToFail:doubleTap];
        
       // [imageView addGestureRecognizer:singleTap];
        [imageView addGestureRecognizer:doubleTap];
        [_scrollView addSubview:imageView];
    }
    
    [self setupImageOfImageViewForIndex:self.currentImageIndex];
    
}

// 加载图片
- (void)setupImageOfImageViewForIndex:(NSInteger)index
{
    SDBrowserImageView *imageView = _scrollView.subviews[index];
    self.currentImageIndex = index;
    if (imageView.hasLoadedImage) return;
    if ([self highQualityImageURLForIndex:index]) {
        [imageView setImageWithURL:[self highQualityImageURLForIndex:index] placeholderImage:[self placeholderImageForIndex:index]];
    } else {
        imageView.image = [self placeholderImageForIndex:index];
    }
    imageView.hasLoadedImage = YES;
}

- (void)photoClick:(UITapGestureRecognizer *)recognizer
{
//    _scrollView.hidden = YES;
//    _willDisappear = YES;
//    
//    SDBrowserImageView *currentImageView = (SDBrowserImageView *)recognizer.view;
//    NSInteger currentIndex = currentImageView.tag;
//    
//    UIView *sourceView = nil;
//    if ([self.sourceImagesContainerView isKindOfClass:UICollectionView.class]) {
//        UICollectionView *view = (UICollectionView *)self.sourceImagesContainerView;
//        NSIndexPath *path = [NSIndexPath indexPathForItem:currentIndex inSection:0];
//        sourceView = [view cellForItemAtIndexPath:path];
//    }else {
//        sourceView = self.sourceImagesContainerView.subviews[currentIndex];
//    }
//    
//    
//    
//    CGRect targetTemp = [self.sourceImagesContainerView convertRect:sourceView.frame toView:self];
//    
//    UIImageView *tempView = [[UIImageView alloc] init];
//    tempView.contentMode = sourceView.contentMode;
//    tempView.clipsToBounds = YES;
//    tempView.image = currentImageView.image;
//    CGFloat h = (self.bounds.size.width / currentImageView.image.size.width) * currentImageView.image.size.height;
//    
//    if (!currentImageView.image) { // 防止 因imageview的image加载失败 导致 崩溃
//        h = self.bounds.size.height;
//    }
//    
//    tempView.bounds = CGRectMake(0, 0, self.bounds.size.width, h);
//    tempView.center = self.center;
//    
//    [self addSubview:tempView];
//
//    _deleteBtn.hidden = YES;
//    
    [self didapper];
    
}
- (void)didapper{
    [UIView animateWithDuration:SDPhotoBrowserHideImageAnimationDuration animations:^{
        self.frame = CGRectMake(375, 0, 375, 667);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];}

- (void)imageViewDoubleTaped:(UITapGestureRecognizer *)recognizer
{
    SDBrowserImageView *imageView = (SDBrowserImageView *)recognizer.view;
    CGFloat scale;
    if (imageView.isScaled) {
        scale = 1.0;
    } else {
        scale = 2.0;
    }
    
    SDBrowserImageView *view = (SDBrowserImageView *)recognizer.view;

    [view doubleTapToZommWithScale:scale];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    rect.size.width += SDPhotoBrowserImageViewMargin * 2;
    
    _scrollView.bounds = CGRectMake(0, 0, rect.size.width, 667-68);
    _scrollView.center = self.center;
    _scrollView.center = CGPointMake(self.center.x, self.center.y+34);

    
    CGFloat y = 0;
    CGFloat w = _scrollView.frame.size.width - SDPhotoBrowserImageViewMargin * 2;
    CGFloat h = _scrollView.frame.size.height;

    [_scrollView.subviews enumerateObjectsUsingBlock:^(SDBrowserImageView *obj, NSUInteger idx, BOOL *stop) {
        CGFloat x = SDPhotoBrowserImageViewMargin + idx * (SDPhotoBrowserImageViewMargin * 2 + w);
        obj.frame = CGRectMake(x, y, w, h);
    }];

    _scrollView.contentSize = CGSizeMake(_scrollView.subviews.count * _scrollView.frame.size.width, 0);
    _scrollView.contentOffset = CGPointMake(self.currentImageIndex * _scrollView.frame.size.width, 0);
    
    
    if (!_hasShowedFistView) {
        [self showFirstImage];
    }
    _indexLabel.center = CGPointMake(self.bounds.size.width * 0.5, _deleteBtn.center.y);
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addObserver:self forKeyPath:@"frame" options:0 context:nil];
    [window addSubview:self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIView *)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        self.frame = object.bounds;
        SDBrowserImageView *currentImageView = _scrollView.subviews[_currentImageIndex];
        if ([currentImageView isKindOfClass:[SDBrowserImageView class]]) {
            [currentImageView clear];
        }
    }
}

- (void)showFirstImage
{
    UIView *sourceView = nil;
    if ([self.sourceImagesContainerView isKindOfClass:UICollectionView.class]) {
        urlObject *object =  self.imgArr[self.currentImageIndex];
        UICollectionView *view = (UICollectionView *)self.sourceImagesContainerView;
        NSIndexPath *path = [NSIndexPath indexPathForItem:object.row inSection:object.section];
       sourceView = [view cellForItemAtIndexPath:path];
    }else {
        sourceView = self.sourceImagesContainerView.subviews[self.currentImageIndex];
    }
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.image = [self placeholderImageForIndex:self.currentImageIndex];
    UIView *blackView = [[UIView alloc] init];
    blackView.frame = CGRectMake(screen_Width, 64, screen_Width, screen_Height-64);
    blackView.backgroundColor = [UIColor blackColor];
    CGRect targetTemp = [_scrollView.subviews[self.currentImageIndex] bounds];
    tempView.frame = CGRectMake(0, 4, targetTemp.size.width, targetTemp.size.height);
    NSLog(@"333---%@",tempView);

    [blackView addSubview:tempView];
    [self addSubview:blackView];

    tempView.contentMode = [_scrollView.subviews[self.currentImageIndex] contentMode];
    _scrollView.hidden = YES;
    [UIView animateWithDuration:SDPhotoBrowserShowImageAnimationDuration animations:^{
        blackView.frame = CGRectMake(0, 64, screen_Width, screen_Height-64);
        self.navigaitonView.frame = CGRectMake(0, 0, screen_Width, 64);
    } completion:^(BOOL finished) {
        _hasShowedFistView = YES;
        [blackView removeFromSuperview];
        _scrollView.hidden = NO;
        self.backgroundColor = SDPhotoBrowserBackgrounColor;
    }];
}

- (UIImage *)placeholderImageForIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(photoBrowser:placeholderImageForIndex:)]) {
        return [self.delegate photoBrowser:self placeholderImageForIndex:index];
    }
    return nil;
}

- (NSURL *)highQualityImageURLForIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(photoBrowser:highQualityImageURLForIndex:)]) {
        return [self.delegate photoBrowser:self highQualityImageURLForIndex:index];
    }
    return nil;
}


- (void)didDeleteImageForIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(photoBrowser:didDeleteImageForIndex:)]) {
        [self.delegate photoBrowser:self didDeleteImageForIndex:index];
    }
}

- (NSString *)didChangeLabelNameForIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(photoBrowser:didChangeLabelNameStringForIndex:)]) {
        return [self.delegate photoBrowser:self didChangeLabelNameStringForIndex:index];
    }
    return nil;

}
#pragma mark - scrollview代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = (scrollView.contentOffset.x + _scrollView.bounds.size.width * 0.5) / _scrollView.bounds.size.width;
    
    // 有过缩放的图片在拖动一定距离后清除缩放
    CGFloat margin = 150;
    CGFloat x = scrollView.contentOffset.x;
    if ((x - index * self.bounds.size.width) > margin || (x - index * self.bounds.size.width) < - margin) {
        SDBrowserImageView *imageView = _scrollView.subviews[index];
        if (imageView.isScaled) {
            [UIView animateWithDuration:0.5 animations:^{
                imageView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [imageView eliminateScale];
            }];
        }
    }
    
    
    if (!_willDisappear) {
        
        _indexLabel.text = [self didChangeLabelNameForIndex:index];
    }
    [self setupImageOfImageViewForIndex:index];
}

- (XAOrderWaringView *)shanchuWaringView{
    if (!_shanchuWaringView) {
        _shanchuWaringView = [[XAOrderWaringView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) withDataArray:@[@"要删除这张图片吗？",@"保留",@"删除"]];
        WeakSelf;
        _shanchuWaringView.gotoSend = ^{
            [weakSelf.shanchuWaringView removeFromSuperview];
            
            
        };
        
        _shanchuWaringView.gotoCancel = ^{
            [weakSelf.shanchuWaringView removeFromSuperview];
        };
    }
    return _shanchuWaringView;
}

@end
