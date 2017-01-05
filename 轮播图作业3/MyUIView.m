#import "MyUIView.h"

@interface MyUIView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;  //轮播图片的控件
@property (nonatomic, strong) UIPageControl *pageControl; //控制图片的控件
@property (nonatomic, strong) NSTimer       *timer;       //控制轮播节奏的定时器
@property (nonatomic, assign) int           imageCount;   //图片总数

@end

@implementation MyUIView

//依次设置各个子控件
-(void)config
{
    [self addScrollView ];
    [self addPageControl];
    [self addImages     ];
    [self addTimer      ];
}

#pragma mark 设置并添加 轮播图片的控件, 设置了横向操控范围,分页,隐藏指示条等
-(void)addScrollView
{
    self.scrollView                              = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.contentSize                  = CGSizeMake(self.imageCount * self.frame.size.width, 0);
    self.scrollView.backgroundColor              = [UIColor blackColor];
    self.scrollView.delegate                     = self;
    self.scrollView.pagingEnabled                = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollView];
}

#pragma mark 设置并添加 控制图片的控件, 设置了默认起始页,页数,页码颜色
-(void)addPageControl
{
    self.pageControl                               = [[UIPageControl alloc] initWithFrame:
                                                      CGRectMake(0, self.frame.size.height - 10, self.frame.size.width, 10)];
    self.pageControl.currentPage                   = 0;
    self.pageControl.numberOfPages                 = self.imageCount;
    self.pageControl.pageIndicatorTintColor        = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:self.pageControl];
}

#pragma mark 导入传递来的图片数组, 并添加到轮播图片的控件
-(void)addImages
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.frame.size.width;
    CGFloat imageH = self.frame.size.height;
    
    //横向排列 UIImageView
    for (int imageIndex = 0; imageIndex < self.imageCount; imageIndex ++)
    {
        UIImageView *imageView = [UIImageView new];
        imageX                 = imageIndex * imageW;
        imageView.frame        = CGRectMake(imageX, imageY, imageW, imageH);
        imageView.image        = self.imageArray[imageIndex];
        
        [self.scrollView addSubview:imageView];
    }
}


#pragma mark 设置并添加定时器
-(void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timerInterval
                                                  target:self
                                                selector:@selector(nextImage)
                                                userInfo:nil
                                                 repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer
                                 forMode:NSRunLoopCommonModes];
}


#pragma mark 设置定时器触发的切图方法
-(void)nextImage
{
    NSInteger currentPageIndex = self.pageControl.currentPage;
    
    if (currentPageIndex == self.imageCount - 1) {
        currentPageIndex = 0;
    }else{
        currentPageIndex ++;
    }
    
    [self.scrollView setContentOffset:CGPointMake(currentPageIndex * self.frame.size.width, 0)
                             animated:YES];
}

//获取图片数量
-(int)imageCount
{
    return (int)self.imageArray.count;
}


//开始拖拽时, 停止定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
     self.timer = nil;
}


//拖拽时图片的显示, 计算了当前要显示的页码
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPageIndex         = (scrollView.contentOffset.x + self.frame.size.width / 2) / self.frame.size.width;
    self.pageControl.currentPage = currentPageIndex;
}


//停止拖拽后加上定时器
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                 willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

@end
