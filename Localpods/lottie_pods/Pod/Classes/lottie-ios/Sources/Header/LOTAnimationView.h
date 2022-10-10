//
//  LOTAnimationView.h
//  LottieSwiftToOC
//
//  Created by Sunny on 2022/10/8.
//

#import <UIKit/UIKit.h>


typedef void (^LOTAnimationCompletionBlock)(BOOL animationFinished);


@interface LOTAnimationView : UIView

/// Load animation by name from the default bundle, Images are also loaded from the bundle
+ (nonnull instancetype)animationNamed:(nonnull NSString *)animationName NS_SWIFT_NAME(init(name:));

/// Loads animation by name from specified bundle, Images are also loaded from the bundle
+ (nonnull instancetype)animationNamed:(nonnull NSString *)animationName inBundle:(nonnull NSBundle *)bundle NS_SWIFT_NAME(init(name:bundle:));

/// Loads an animation from a specific file path. WARNING Do not use a web URL for file path.
+ (nonnull instancetype)animationWithFilePath:(nonnull NSString *)filePath NS_SWIFT_NAME(init(filePath:));


/// Load animation by name from the default bundle. Use when loading LOTAnimationView via Interface Builder.
- (void)setAnimationNamed:(nonnull NSString *)animationName NS_SWIFT_NAME(setAnimation(named:));

/// Flag is YES when the animation is playing
@property (nonatomic, readonly) BOOL isAnimationPlaying;

/// Tells the animation to loop indefinitely.
@property (nonatomic, assign) BOOL loopAnimation;

/// The animation will play forward and then backwards if loopAnimation is also YES
@property (nonatomic, assign) BOOL autoReverseAnimation;

/// Sets a progress from 0 - 1 of the animation. If the animation is playing it will stop and the compeltion block will be called.
/// The current progress of the animation in absolute time.
/// e.g. a value of 0.75 always represents the same point in the animation, regardless of positive
/// or negative speed.
@property (nonatomic, assign) CGFloat animationProgress;

/// Sets the speed of the animation. Accepts a negative value for reversing animation.
@property (nonatomic, assign) CGFloat animationSpeed;

/// Read only of the duration in seconds of the animation at speed of 1
@property (nonatomic, readonly) CGFloat animationDuration;

/// Sets a completion block to call when the animation has completed
@property (nonatomic, copy, nullable) LOTAnimationCompletionBlock completionBlock;

/// get the amimation frame data
@property (nonatomic, readonly, nullable) NSNumber *startFrame;

@property (nonatomic, readonly, nullable) NSNumber *endFrame;


/*
 * Plays the animation from its current position to a specific progress.
 * The animation will start from its current position.
 * If loopAnimation is YES the animation will loop from start position to toProgress indefinitely.
 * If loopAnimation is NO the animation will stop and the comletion block will be called.
 */
- (void)playToProgress:(CGFloat)toProgress
        withCompletion:(nullable LOTAnimationCompletionBlock)completion;

/*
 * Plays the animation from specific progress to a specific progress
 * The animation will start from its current position..
 * If loopAnimation is YES the animation will loop from the startProgress to the endProgress indefinitely
 * If loopAnimation is NO the animation will stop and the comletion block will be called.
 */
- (void)playFromProgress:(CGFloat)fromStartProgress
              toProgress:(CGFloat)toEndProgress
          withCompletion:(nullable LOTAnimationCompletionBlock)completion;

/*
 * Plays the animation from its current position to a specific frame.
 * The animation will start from its current position.
 * If loopAnimation is YES the animation will loop from beginning to toFrame indefinitely.
 * If loopAnimation is NO the animation will stop and the comletion block will be called.
 */
- (void)playToFrame:(nonnull NSNumber *)toFrame
     withCompletion:(nullable LOTAnimationCompletionBlock)completion;

/*
 * Plays the animation from specific frame to a specific frame.
 * The animation will start from its current position.
 * If loopAnimation is YES the animation will loop start frame to end frame indefinitely.
 * If loopAnimation is NO the animation will stop and the comletion block will be called.
 */
- (void)playFromFrame:(nonnull NSNumber *)fromStartFrame
              toFrame:(nonnull NSNumber *)toEndFrame
       withCompletion:(nullable LOTAnimationCompletionBlock)completion;


- (void)playWithCompletion:(nullable LOTAnimationCompletionBlock)completion;

/// Plays the animaiton
- (void)play;

/// Stops the animation at the current frame. The completion block will be called.
- (void)pause;

/// Stops the animation and rewinds to the beginning. The completion block will be called.
- (void)stop;

/// Sets progress of animation to a specific frame. If the animation is playing it will stop and the completion block will be called.
- (void)setProgressWithFrame:(nonnull NSNumber *)currentFrame;

/// Forces a layout and drawing update for the current frame.
- (void)forceDrawingUpdate;





@end


