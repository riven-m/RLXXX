//
//  TestViewController.m
//  GlobalVillage
//
//  Created by RivenL on 15/1/26.
//  Copyright (c) 2015年 RivenL. All rights reserved.
//

#import "TestViewController.h"
#import "RLActivityShare.h"
#import "RLSocialShareKit.h"

#import "NewsChannelsVC.h"


#if 0
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"TestVC";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height/2, 100, 30);
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"Test" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(clickTest:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)clickTest:(UIButton *)btn {
#if 0
    btn.enabled = NO;
    __block UIButton *blockItem = btn;
    id block /*= ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        blockItem.enabled = YES;
    }*/;
    
//    [RLSocialShareKit sharedShareKit].weChatAuthVC = self;
//    
//    [[RLSocialShareKit sharedShareKit] registerAppWithType:kRLSocialShareKitTypeWeChatSession];
//    [[RLSocialShareKit sharedShareKit] targetAppAuthLogin:kRLSocialShareKitTypeWeChatSession];

    RLSinaWeiboActivity *sinaWeiboActivity = [[RLSinaWeiboActivity alloc] init];
    sinaWeiboActivity.callback = @selector(sendMessageToTargetApp:);
    sinaWeiboActivity.delegate = self;
    RLShareMessageModel *message = sinaWeiboActivity.message;
    message.appType = kRLSocialShareKitTypeSinaWebo;
    message.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SinaWeibo" ofType:@"png"]];
    
    RLWeChatSessionActivity *weChatSessionActivity = [[RLWeChatSessionActivity alloc] init];
    weChatSessionActivity.callback = @selector(sendMessageToTargetApp:);
    weChatSessionActivity.delegate = self;
    weChatSessionActivity.message.appType = kRLSocialShareKitTypeWeChatSession;
    weChatSessionActivity.message.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SinaWeibo" ofType:@"png"]];
    
    RLWeChatTimeLineActivity *weChatTimelineActivity = [[RLWeChatTimeLineActivity alloc] init];
    weChatTimelineActivity.callback = @selector(sendMessageToTargetApp:);
    weChatTimelineActivity.delegate = self;
    weChatTimelineActivity.message.appType = kRLSocialShareKitTypeWeChatTimeline;
    weChatTimelineActivity.message.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SinaWeibo" ofType:@"png"]];
    
    block = ^(NSString *  activityType, BOOL completed) {
        blockItem.enabled = YES;
    };
    
    RLActivityShare *activityShare = [[RLActivityShare alloc] init];
//    NSArray *activityItems = [[NSArray alloc]initWithObjects:NSLocalizedString(@"一款免费发送广告的APP！手机号、微信号、地球号一个都不能少！", nil), @"http://www.dqcc.com.cn", [UIImage imageNamed:@"qq_icon.png"], nil];
    activityShare.showVC = self;
//    activityShare.showItems = nil;//activityItems;
    activityShare.completionHandler = block;
    activityShare.appActivities = @[weChatSessionActivity, weChatTimelineActivity, sinaWeiboActivity];
    
    [activityShare showActivityViewController];
#endif
    
#if 0
    NewsChannelsVC *vc = [[NewsChannelsVC alloc] init];
    [ChangeVCController pushViewControllerByNavigationController:self.navigationController pushVC:vc];
#endif
}

- (void)sendMessageToTargetApp:(RLShareMessageModel *)message {
    [[RLSocialShareKit sharedShareKit] sendMessageToTargetApp:message];
}
@end

#endif

#if 1
#import "SegmentBar.h"
@interface TestViewController () <SegmentBarDataSource>
@property (nonatomic, strong) SegmentBar *bar;
@end

@implementation TestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    if([[UIDevice currentDevice].systemVersion floatValue] >= 7.0){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.bar = [[SegmentBar alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 90)];
    self.bar.dataSource = self;
    [self.view addSubview:self.bar];
}

- (NSInteger)itemViewsNumberOfSegmentBar:(SegmentBar *)segmentBar {
    return 10;
}

- (CGFloat)itemWidthOfSegmentBar:(SegmentBar *)segmentBar forIndex:(NSInteger)index {
    return 90;
}

- (SegmentItemView *)itemView:(SegmentBar *)sgementBar forIndex:(NSInteger)index {
    SegmentItemView *item = nil;
    if((item = [sgementBar dequeueReusableItemView]) == nil) {
        item = (SegmentItemView *)[ViewConstructor constructDefaultButton:[SegmentItemView class] withFrame:CGRectZero];
    }
    
    [item setTitle:[NSString stringWithFormat:@"button%ld", (long)index] forState:UIControlStateNormal];
    item.delegate = self.bar;
    
    return item;
}
@end
#endif
