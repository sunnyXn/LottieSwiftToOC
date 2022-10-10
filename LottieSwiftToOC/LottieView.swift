//
//  LottieView.swift
//  LottieSwiftToOC
//
//  Created by Sunny on 2022/10/10.
//

import UIKit
import Lottie


@objcMembers public class LottieView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        p_init()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        p_init()
    }
    
    private func p_init() {
        let button = UIButton(frame: .init(x: 0, y: 0, width: 60, height: 30))
        button.center.x = center.x - 50
        button.setTitle("测试1", for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(btnClick(_ :)), for: .touchUpInside)
        addSubview(button)
    }
    
    @objc func btnClick(_ btn:UIButton) {
        showLottieAnimation()
    }
        
    private lazy var lottieView: AnimationView = {
//        let lottieView = AnimationView()
        let lottieView = AnimationView(name: "lifeRow")
        lottieView.frame = CGRect(x: 0, y: 100, width: 72, height: 72)
        lottieView.loopMode = .loop
        lottieView.contentMode = .scaleAspectFit
        lottieView.backgroundBehavior = .pauseAndRestore//
        lottieView.center.x = center.x
        addSubview(lottieView)
        return lottieView
    }()

    @objc func showLottieAnimation() {
        lottieView.stop()
        lottieView.play()
    }
    
}


