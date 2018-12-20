#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
@interface urlObject : NSObject
@property (nonatomic , assign)NSUInteger row;
@property (nonatomic , assign)NSUInteger section;
@property (nonatomic , copy)NSString *url;
@property (nonatomic , copy)NSString *Uid;
@property (nonatomic , strong)UIImage *img;
@end



@class SDButton, SDPhotoBrowser;

@protocol SDPhotoBrowserDelegate <NSObject>

@required

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;
- (void)photoBrowser:(SDPhotoBrowser *)browser didDeleteImageForIndex:(NSInteger)index;

- (NSString *)photoBrowser:(SDPhotoBrowser *)browser didChangeLabelNameStringForIndex:(NSInteger)index;
@optional

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;

@end


@interface SDPhotoBrowser : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) UIView *sourceImagesContainerView;
@property (nonatomic, assign) NSInteger currentImageIndex;
@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic, copy) NSMutableArray *imgArr;

@property (nonatomic, weak) id<SDPhotoBrowserDelegate> delegate;

- (void)show;

@end
