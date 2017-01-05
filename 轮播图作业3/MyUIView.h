#import <UIKit/UIKit.h>

@interface MyUIView : UIView

@property (nonatomic, assign)          float timerInterval; //接收 timer 的时间间隔
@property (nonatomic, strong) NSMutableArray *imageArray;   //接收自定义的图片数组

-(void)config; //初始化

@end
