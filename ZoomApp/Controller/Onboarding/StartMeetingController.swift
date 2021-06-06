//
//  StartMeetingController.swift
//  ZoomApp
//
//  Created by Sarmad Ishfaq on 06/06/2021.
//

import UIKit
import paper_onboarding

class StartMeetingController: UIViewController {
    
    //MARK:-UI-Elements
    let items = [
        OnboardingItemInfo(informationImage: UIImage(named: "zoom_intro1")!, title: "Start a Meeting", description: "Start or join a video meeting on the go", pageIcon: UIImage(), color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00), titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: .boldSystemFont(ofSize: 36), descriptionFont: .systemFont(ofSize: 14)),
        
        OnboardingItemInfo(informationImage: UIImage(named: "zoom_intro2")!, title: "Share Your Content", description: "They see what you see", pageIcon: UIImage(), color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00), titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: .boldSystemFont(ofSize: 36), descriptionFont: .systemFont(ofSize: 14)),
        
        OnboardingItemInfo(informationImage: UIImage(named: "zoom_intro3")!, title: "Message Your Team", description: "Send texts, voice message, files and images", pageIcon: UIImage(), color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00), titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: .boldSystemFont(ofSize: 36), descriptionFont: .systemFont(ofSize: 14)),
        
        OnboardingItemInfo(informationImage: UIImage(named: "zoom_intro4")!, title: "Get Zooming!", description: "Work anywhere, with anyone, on any device", pageIcon: UIImage(), color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: .boldSystemFont(ofSize: 36), descriptionFont: .systemFont(ofSize: 14))
    
    
    ]
    let joinmeetingButton : UIButton = {
      let button = UIButton()
        button.setTitle("Join a Meeting", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 12.autoSized
        button.addTarget(self, action: #selector(joinMeetingButtonPressed), for: .touchUpInside)
        return button
    }()
    let signInButton : UIButton = {
      let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var onboarding : PaperOnboarding = {
    let view = PaperOnboarding()
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK:-ViewControllerLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = ""
        setupViews()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupViews(){
        view.addSubview(onboarding)
        onboarding.addSubview(joinmeetingButton)
        onboarding.addSubview(signInButton)
        onboarding.bringSubviewToFront(joinmeetingButton)
        NSLayoutConstraint.activate([
            onboarding.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboarding.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboarding.topAnchor.constraint(equalTo: view.topAnchor),
            onboarding.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            joinmeetingButton.widthAnchor.constraint(equalToConstant: 200.widthRatio),
            joinmeetingButton.heightAnchor.constraint(equalToConstant: 50.heightRatio),
            joinmeetingButton.bottomAnchor.constraint(equalTo: onboarding.bottomAnchor, constant: -180.heightRatio),
            joinmeetingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: joinmeetingButton.bottomAnchor, constant: 20.heightRatio),
            
        
        ])
    }
    
    //MARK:-Selector
    @objc func joinMeetingButtonPressed(){
        let controller = JoinMeetingController()
        navigationController?.pushViewController(controller, animated: true)
    }
    @objc func signInButtonPressed(){
        
    }
    
}
extension StartMeetingController : PaperOnboardingDelegate , PaperOnboardingDataSource {
    func onboardingWillTransitonToIndex(_ index: Int) {
//        joinmeetingButton.isHidden = index == 3 ? false : true
    }
    
    func onboardingItemsCount() -> Int {
        return 4
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }
    
    
}
