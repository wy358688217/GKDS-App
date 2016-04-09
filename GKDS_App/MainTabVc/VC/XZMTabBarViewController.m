
#import "XZMTabBarViewController.h"
#import "XZMTabbarExtension.h"
#import "XZMPublishViewController.h"
#import "GKNavigationControllerProxy.h"
#import "GKAboutMeViewController.h"
#import "GKNavigationController.h"
#import "GKWebViewController.h"
#import "GKWeiXinPayViewController.h"
#import "GKAttentionViewController.h"
@interface XZMTabBarViewController ()<UITabBarDelegate>

@end

@implementation XZMTabBarViewController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
//    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    /** 设置默认状态 */
    NSMutableDictionary *norDict = @{}.mutableCopy;
    norDict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    norDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    [tabBarItem setTitleTextAttributes:norDict forState:UIControlStateNormal];
    
    /** 设置选中状态 */
    NSMutableDictionary *selDict = @{}.mutableCopy;
    selDict[NSFontAttributeName] = norDict[NSFontAttributeName];
    selDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [tabBarItem setTitleTextAttributes:selDict forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*添加子控制器 */
    /** 精华 */
    GKWebViewController * firstVc = [[GKWebViewController alloc]init];
    firstVc.view.backgroundColor = [UIColor whiteColor];
    [self setUpChildControllerWith:firstVc
                          norImage:[UIImage imageNamed:@"tabBar_essence_icon"]
                          selImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]
                             title:@"精华"
                             index:Moduel_Tab_Left_One];
    
    /** 新帖 */
    GKWeiXinPayViewController * twoVc = [[GKWeiXinPayViewController alloc]init];
    twoVc.view.backgroundColor = [UIColor redColor];
    [self setUpChildControllerWith:twoVc
                          norImage:[UIImage imageNamed:@"tabBar_new_icon"]
                          selImage:[UIImage imageNamed:@"tabBar_new_click_icon"]
                             title:@"新帖"
                             index:Moduel_Tab_Left_Two];
    
    /** 关注 */
    GKAttentionViewController * fourVc = [[GKAttentionViewController alloc]init];
    fourVc.view.backgroundColor = [UIColor greenColor];
    [self setUpChildControllerWith:fourVc
                          norImage:[UIImage imageNamed:@"tabBar_friendTrends_icon"]
                          selImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"]
                             title:@"关注"
                             index:Moduel_Tab_Left_Four];
    
    /** 我的 */
    GKAboutMeViewController * fiveVc = [[GKAboutMeViewController alloc]init];
//    fiveVc.view.backgroundColor = [UIColor blueColor];
    [self setUpChildControllerWith:fiveVc
                          norImage:[UIImage imageNamed:@"tabBar_me_icon"]
                          selImage:[UIImage imageNamed:@"tabBar_me_click_icon"]
                             title:@"我的"
                             index:Moduel_Tab_Left_Five];
    
    /** 配置中间按钮 */
    [self.tabBar setUpTabBarCenterButton:^(UIButton *centerButton) {
        [centerButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        
        [centerButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        [centerButton addTarget:self action:@selector(chickCenterButton) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    /** 设置tabar工具条 */
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
}

- (void)chickCenterButton
{
    NSLog(@"点击了中间按钮");
    XZMPublishViewController * vc = [[XZMPublishViewController alloc]init];
    vc.title = @"发现";
    [self presentViewController:vc animated:NO completion:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        [GK_NAV_PROXY insertNavigationController:nav key:@(Moduel_Tab_Left_Three)];
    });
    [GK_NAV_PROXY setCurNavIndex:Moduel_Tab_Left_Three];
}

- (void)setUpChildControllerWith:(UIViewController *)childVc norImage:(UIImage *)norImage selImage:(UIImage *)selImage title:(NSString *)title index:(Moduel_Tab_Index)index
{
    GKNavigationController *nav = [[GKNavigationController alloc] initWithRootViewController:childVc];
    childVc.title = title;
    childVc.tabBarItem.image = norImage;
    childVc.tabBarItem.selectedImage = selImage;
    [childVc.tabBarItem setTag:index];
    [self addChildViewController:nav];
//    nav.delegate = nav;
    [GK_NAV_PROXY insertNavigationController:nav key:@(index)];
}

#pragma mark -- UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [GK_NAV_PROXY setCurNavIndex:(Moduel_Tab_Index)item.tag];
}

@end
