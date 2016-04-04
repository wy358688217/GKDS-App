
#import <UIKit/UIKit.h>

@interface UIView (XZMFrame)
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;

- (BOOL)isShowingOnKeyWindow;

+ (instancetype)viewFromXib;
@end
