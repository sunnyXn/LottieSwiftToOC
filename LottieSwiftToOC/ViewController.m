//
//  ViewController.m
//  LottieSwiftToOC
//
//  Created by Sunny on 2022/10/10.
//

#import "ViewController.h"
#import <Lottie/Lottie.h>
#import "LottieSwiftToOc-Swift.h"


@interface ViewController ()

@property(nonatomic, strong) LOTAnimationView *lottieView;
@property(nonatomic, strong) LottieView *swiftLottieView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self swiftLottieView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 60, 30)];
    button.center = CGPointMake(self.view.center.x + 50, button.center.y);
    [button setTitle:@"测试2" forState:UIControlStateNormal];
    button.backgroundColor = UIColor.blueColor;
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (LOTAnimationView *)lottieView {
    if (!_lottieView) {
        _lottieView = [LOTAnimationView animationNamed:@"life_red"];
        _lottieView.frame = CGRectMake(0, 300, 242, 84);
        _lottieView.loopAnimation = YES;
        _lottieView.contentMode = UIViewContentModeScaleAspectFit;
//        _lottieView.backgroundBehavior = .pauseAndRestore
        _lottieView.center = CGPointMake(self.view.center.x, _lottieView.center.y);
        [self.view addSubview:_lottieView];
    }
    return _lottieView;
}

- (void)btnClick:(id)sender {
    [self showLottieAnimation];
}

- (void)showLottieAnimation {
    [self.lottieView stop];
    [self.lottieView play];
}

#pragma mark - swift func
- (LottieView *)swiftLottieView {
    if (!_swiftLottieView) {
        _swiftLottieView = [[LottieView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 300)];
        [self.view addSubview:_swiftLottieView];
    }
    return _swiftLottieView;
}



@end
