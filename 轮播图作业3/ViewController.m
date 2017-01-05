#import "ViewController.h"
#import "MyUIView.h"

@interface ViewController ()

@property (nonatomic, weak  ) IBOutlet MyUIView *myUIView; //显示 scrollView 和 pageControl
@property (nonatomic, strong)    NSMutableArray *photoArray; //可以自定义图片的数组

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自定义图片数组

    self.photoArray = [NSMutableArray array];
    
    for (int index = 0; index < 8; index ++)
    {
        NSString *imageName = [NSString stringWithFormat:@"%d",index + 1];
        UIImage  *image     = [UIImage imageNamed:imageName];
        
        [self.photoArray addObject:image];
    }
    
    self.myUIView.imageArray = self.photoArray;
    
    
    
    //自定义图片切换间隔
    self.myUIView.timerInterval = 0.75f;
    
    
    
    //根据以上参数来配置 整体轮播控件
    [self.myUIView config];
}
@end