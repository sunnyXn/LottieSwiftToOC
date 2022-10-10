//
//  LOTAnimationView.m
//  LottieSwiftToOC
//
//  Created by Sunny on 2022/10/8.
//

#import "LOTAnimationView.h"
#import "lottie-Swift.h"



@interface LOTAnimationView ()

@property(nonatomic, strong) AnimationView *lottieView;


@end



@implementation LOTAnimationView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.lottieView.frame = self.bounds;
}

#pragma mark - overide init
- (instancetype)init {
    self = [super init];
    if (self) {
        [self p_init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)p_init {
    if (!self.lottieView) {
        self.lottieView = [[AnimationView alloc] initWithFrame:self.bounds];
    }
    self.lottieView.frame = self.bounds;
    [self addSubview:self.lottieView];
}

#pragma mark -  +init
+ (instancetype)animationNamed:(NSString *)animationName {
    return [self animationNamed:animationName inBundle:[NSBundle mainBundle]];
}

+ (instancetype)animationNamed:(NSString *)animationName inBundle:(NSBundle *)bundle {
    return [[self alloc] initWithName:animationName bundle:bundle];
}

+ (instancetype)animationWithFilePath:(NSString *)filePath {
    return [[self alloc] initWithFilePath:filePath];
}

- (nonnull instancetype)initWithFilePath:(NSString *)filePath {
    self = [super init];
    if (self) {
        self.lottieView = [[AnimationView alloc] initWithFilePath:filePath];
        [self p_init];
    }
    return self;
}

- (nonnull instancetype)initWithName:(NSString * _Nonnull)name bundle:(NSBundle * _Nonnull)bundle {
    self = [super init];
    if (self) {
        self.lottieView = [[AnimationView alloc] initWithName:name bundle:bundle];
        [self p_init];
    }
    return self;
}


#pragma mark - get
- (BOOL)isAnimationPlaying {
    return [self.lottieView getIsAnimationPlaying];
}

- (BOOL)loopAnimation {
    return [self.lottieView loopAnimation];
}

- (void)setLoopAnimation:(BOOL)loopAnimation {
    [self.lottieView setLoopAnimation:loopAnimation];
}

- (BOOL)autoReverseAnimation {
    return [self.lottieView autoReverseAnimation];
}

- (CGFloat)animationProgress {
    return [self.lottieView getAnimationProgress];
}

- (void)setAnimationProgress:(CGFloat)animationProgress {
    [self.lottieView setAnimationProgress:animationProgress];
}

- (CGFloat)animationSpeed {
    return [self.lottieView getAnimationSpeed];
}

- (void)setAnimationSpeed:(CGFloat)animationSpeed {
    [self.lottieView setAnimationSpeed:animationSpeed];
}

- (CGFloat)animationDuration {
    return [self.lottieView getAnimationDuration];
}

- (NSNumber *)startFrame {
    return @([self.lottieView getStartFrame]);
}

- (NSNumber *)endFrame {
    return @([self.lottieView getEndFrame]);
}

#pragma mark - set
- (void)setContentMode:(UIViewContentMode)contentMode {
    [super setContentMode:contentMode];
    self.lottieView.contentMode = contentMode;
}

- (void)setAnimationNamed:(NSString *)animationName {
    [self.lottieView updateAnimationNamed:animationName];
}


#pragma mark - func
- (void)playToProgress:(CGFloat)toProgress
        withCompletion:(nullable LOTAnimationCompletionBlock)completion {
    [self playFromProgress:0 toProgress:toProgress withCompletion:completion];
}

- (void)playFromProgress:(CGFloat)fromStartProgress
              toProgress:(CGFloat)toEndProgress
          withCompletion:(nullable LOTAnimationCompletionBlock)completion {
    [self.lottieView toPlayFromProgress:fromStartProgress toProgress:toEndProgress completion:completion];
}

- (void)playToFrame:(nonnull NSNumber *)toFrame
     withCompletion:(nullable LOTAnimationCompletionBlock)completion {
    [self playFromFrame:@(0) toFrame:toFrame withCompletion:completion];
}

- (void)playFromFrame:(nonnull NSNumber *)fromStartFrame
              toFrame:(nonnull NSNumber *)toEndFrame
       withCompletion:(nullable LOTAnimationCompletionBlock)completion {
    [self.lottieView toPlayFromFrame:fromStartFrame.doubleValue toFrame:toEndFrame.doubleValue completion:completion];
}

- (void)playWithCompletion:(nullable LOTAnimationCompletionBlock)completion {
    [self.lottieView toPlayWithCompletion:completion];
}

- (void)play {
    [self playWithCompletion:nil];
}

- (void)pause {
    [self.lottieView toPause];
}

- (void)stop {
    [self.lottieView toStop];
}

- (void)setProgressWithFrame:(nonnull NSNumber *)currentFrame {
    [self.lottieView setProgressWithFrame:currentFrame.doubleValue];
}

- (void)forceDrawingUpdate {
    [self.lottieView forceDrawingUpdate];
}



@end
