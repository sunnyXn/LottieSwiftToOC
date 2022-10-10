//
//  AnimationViewOCInit.swift
//  LottieSwiftToOC
//
//  Created by Sunny on 2022/10/8.
//

import Foundation


@objc extension AnimationView {

    // MARK: Lifecycle

    /// Loads a Lottie animation from a JSON file in the supplied bundle.
    ///
    /// - Parameter name: The string name of the lottie animation with no file
    /// extension provided.
    /// - Parameter bundle: The bundle in which the animation is located.
    /// Defaults to the Main bundle.
    /// - Parameter imageProvider: An image provider for the animation's image data.
    /// If none is supplied Lottie will search in the supplied bundle for images.
    @objc public convenience init(
    name: String,
    bundle: Bundle = Bundle.main)
    {
    let animation = Animation.named(name, bundle: bundle, subdirectory: nil, animationCache: nil)
    let provider = BundleImageProvider(bundle: bundle, searchPath: nil)
    let configuration: LottieConfiguration = .shared
    self.init(animation: animation, imageProvider: provider, configuration: configuration)
    }

    /// Loads a Lottie animation from a JSON file in a specific path on disk.
    ///
    /// - Parameter name: The absolute path of the Lottie Animation.
    /// - Parameter imageProvider: An image provider for the animation's image data.
    /// If none is supplied Lottie will search in the supplied filepath for images.
    @objc public convenience init(
    filePath: String)
    {
    let animationCache = LRUAnimationCache.sharedCache
    let animation = Animation.filepath(filePath, animationCache: animationCache)
    let provider = FilepathImageProvider(filepath: URL(fileURLWithPath: filePath).deletingLastPathComponent().path)
    let configuration: LottieConfiguration = .shared
    self.init(animation: animation, imageProvider: provider, configuration: configuration)
    }

    /// Loads a Lottie animation asynchronously from the URL
    ///
    /// - Parameter url: The url to load the animation from.
    /// - Parameter imageProvider: An image provider for the animation's image data.
    /// If none is supplied Lottie will search in the main bundle for images.
    /// - Parameter closure: A closure to be called when the animation has loaded.
    @objc public convenience init(
    url: URL,
    closure: @escaping AnimationView.DownloadClosure)
    {
    let animationCache = LRUAnimationCache.sharedCache
    let imageProvider: AnimationImageProvider? = nil
    let configuration: LottieConfiguration = .shared
    if let animation = animationCache.animation(forKey: url.absoluteString) {
      self.init(animation: animation, imageProvider: imageProvider, configuration: configuration)
      closure(nil)
    } else {
      self.init(animation: nil, imageProvider: imageProvider, configuration: configuration)

      Animation.loadedFrom(url: url, closure: { animation in
        if let animation = animation {
          self.animation = animation
          closure(nil)
        } else {
          closure(LottieDownloadError.downloadFailed)
        }
      }, animationCache: animationCache)
    }
    }

    /// Loads a Lottie animation from a JSON file located in the Asset catalog of the supplied bundle.
    /// - Parameter name: The string name of the lottie animation in the asset catalog.
    /// - Parameter bundle: The bundle in which the animation is located.
    /// Defaults to the Main bundle.
    /// - Parameter imageProvider: An image provider for the animation's image data.
    /// If none is supplied Lottie will search in the supplied bundle for images.

    // MARK: Public

//    public typealias DownloadClosure = (Error?) -> Void

    @objc public func updateAnimationNamed(_ name: String?) {
        let animation = Animation.named(name ?? "", bundle: Bundle.main, subdirectory: nil, animationCache: nil)
        self.animation = animation
    }
    
    @objc public func getIsAnimationPlaying() -> Bool {
        return isAnimationPlaying
    }
    
    @objc public func loopAnimation() -> Bool {
        return loopMode == .loop
    }
    
    @objc public func setLoopAnimation(_ loop: Bool) {
        loopMode = loop ? .loop : .playOnce;
    }
    
    @objc public func autoReverseAnimation() -> Bool {
        return loopMode == .autoReverse
    }
    
    @objc public func setAnimationProgress(_ progress: CGFloat) {
        currentProgress = progress
    }
    
    @objc public func getAnimationProgress() -> CGFloat {
        return currentProgress
    }
    
    @objc public func setAnimationSpeed(_ speed: CGFloat) {
        animationSpeed = speed
    }
    
    @objc public func getAnimationSpeed() -> CGFloat {
        return animationSpeed
    }
    
    @objc public func getAnimationDuration() -> TimeInterval {
        return animation?.duration ?? 0
    }
    
    @objc public func getStartFrame() -> CGFloat {
        return animation?.startFrame ?? 0
    }
    
    @objc public func getEndFrame() -> CGFloat {
        return animation?.endFrame ?? 1
    }
    
    @objc public func toPlay(completion: LottieCompletionBlock? = nil) {
        play(completion: completion)
    }
    
    @objc public func toPlay(fromProgress: CGFloat, toProgress: CGFloat, completion: LottieCompletionBlock? = nil) {
        play(fromProgress: fromProgress, toProgress: toProgress, completion: completion)
    }
    
    @objc public func toPlay(fromFrame: CGFloat, toFrame: CGFloat, completion: LottieCompletionBlock? = nil) {
        play(fromFrame: fromFrame, toFrame: toFrame, completion: completion)
    }
    
    @objc public func toPause() {
        pause()
    }
    
    @objc public func toStop() {
        stop()
    }
    
    @objc public func setProgressWithFrame(_ toFrame: CGFloat) {
        currentFrame = toFrame
    }
    
    @objc public func forceDrawingUpdate() {
        forceDisplayUpdate()
    }
    
}

func jsonToData(jsonDic:[String: Any]) -> Data? {
    if (!JSONSerialization.isValidJSONObject(jsonDic)) {
        return nil
    }
    
    let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
    
    return data
}

