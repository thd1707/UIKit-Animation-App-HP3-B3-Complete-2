//
//  ViewController.swift
//  AnimationApp
//
//  Created by Tony Pham on 25/8/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: - Properties
    var imgIndex: Int = 1
    var timer: Timer!
    var isAnimating: Bool = false
    var audioPlayer: AVAudioPlayer!
    var isSoundOn: Bool = false
    
    // MARK: - Outlets
    @IBOutlet weak var imgGoodnight: UIImageView!
    @IBOutlet weak var btnToggleAnimation: UIButton!
    @IBOutlet weak var btnResetAnimation: UIButton!
    @IBOutlet weak var swToggleSound: UISwitch!
    
    // MARK: - Actions
    @IBAction func changeToNextImage(_ sender: UIButton) {
        if (imgIndex >= 37) {
            imgIndex = 1
        } else {
            imgIndex += 1
        }
        updateImage()
    }
    
    @IBAction func toggleAnimating(_ sender: UIButton) {
        if (isAnimating) {
            isAnimating = false
            btnToggleAnimation.tintColor = .systemBlue
            btnToggleAnimation.setTitle("Animate", for: .normal)
            pauseAnimation()
            btnResetAnimation.isHidden = true
        } else {
            isAnimating = true
            btnToggleAnimation.tintColor = .systemRed
            btnToggleAnimation.setTitle("Pause", for: .normal)
            startAnimation()
            btnResetAnimation.isHidden = false
        }
    }
    
    @IBAction func resetAnimation() {
        pauseAnimation()
        imgIndex = 1
        updateImage()
        toggleAnimating(btnToggleAnimation)
        isSoundOn = true
        swToggleSound.isOn = isSoundOn
        prepareAudioPlayer()
    }
    
    @IBAction func toggleSound(_ sender: Any) {
        if (isSoundOn) {
            isSoundOn = false
            audioPlayer.stop()
        } else {
            isSoundOn = true
            audioPlayer.play()
        }
    }
    
    // MARK: - Helper Methods
    func updateImage() {
        print("goodnight-images/goodnight\(imgIndex)")
        imgGoodnight.image = UIImage(named: "goodnight-images/goodnight\(imgIndex)")
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.changeToNextImage(_:)), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func startAnimation() {
        startTimer()
        if (isSoundOn) {
            audioPlayer.play()
        }
        updateImage()
    }
    
    func pauseAnimation() {
        stopTimer()
        audioPlayer.stop()
    }
    
    func prepareAudioPlayer() {
        guard let url = Bundle.main.url(forResource: "goodnight-sound", withExtension: "mp3") 
        else {
            print("Music file is not found!")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
        } catch {
            print("Error initializing AVAudioPlayer: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgIndex = 1
        isSoundOn = true
        swToggleSound.isOn = isSoundOn
        updateImage()
        prepareAudioPlayer()
    }

}
