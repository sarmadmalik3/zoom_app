//
//  JoinMeetingController.swift
//  ZoomApp
//
//  Created by Sarmad Ishfaq on 06/06/2021.
//

import UIKit
import MobileRTC

class JoinMeetingController: UIViewController {

    //MARK:-UI-Elements
    let joinmeetingButton : UIButton = {
      let button = UIButton()
        button.setTitle("Join a Meeting", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = appColor.buttonColor
        button.layer.cornerRadius = 12.autoSized
        button.addTarget(self, action: #selector(joinmeetingButtonPressed), for: .touchUpInside)
        return button
    }()
    let meetingIdFeild = CustomTextField(placeHolder: "Meeting ID", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 16))
    let screenNameFeild = CustomTextField(placeHolder: "Display Name", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 16))
    let passwordFeild = CustomTextField(placeHolder: "Meeting Password", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 16))
    let dontConnectToAudioLabel = CustomLabel(text: "Don't Connect To Audio", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alingment: .natural)
    let turnOffVideoLabel = CustomLabel(text: "Turn Off My Video", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alingment: .natural)
    let audioSwitch : UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.onTintColor = appColor.buttonColor
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    let videoSwitch : UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.onTintColor = appColor.buttonColor
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    let audioContainer : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let videoContainer : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK:-ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        passwordFeild.isSecureTextEntry = true
        meetingIdFeild.keyboardType = .numberPad
//        MobileRTC.shared().setMobileRTCRootController(self.navigationController)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    //MARK:-Constraint
    func setupViews(){
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Join a Meeting"
        navigationController?.navigationBar.tintColor = .black
        
        view.addSubview(meetingIdFeild)
        view.addSubview(screenNameFeild)
        view.addSubview(passwordFeild)
        view.addSubview(joinmeetingButton)
        view.addSubview(audioContainer)
        audioContainer.addSubview(dontConnectToAudioLabel)
        audioContainer.addSubview(audioSwitch)
        view.addSubview(videoContainer)
        videoContainer.addSubview(turnOffVideoLabel)
        videoContainer.addSubview(videoSwitch)
        
        
        NSLayoutConstraint.activate([
        
            meetingIdFeild.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 35.widthRatio),
            meetingIdFeild.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -35.widthRatio),
            meetingIdFeild.heightAnchor.constraint(equalToConstant: 50.heightRatio),
            meetingIdFeild.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30.heightRatio),
            
            screenNameFeild.leadingAnchor.constraint(equalTo: meetingIdFeild.leadingAnchor),
            screenNameFeild.trailingAnchor.constraint(equalTo: meetingIdFeild.trailingAnchor),
            screenNameFeild.heightAnchor.constraint(equalTo: meetingIdFeild.heightAnchor),
            screenNameFeild.topAnchor.constraint(equalTo: meetingIdFeild.bottomAnchor, constant: 20.heightRatio),
            
            passwordFeild.leadingAnchor.constraint(equalTo: meetingIdFeild.leadingAnchor),
            passwordFeild.trailingAnchor.constraint(equalTo: meetingIdFeild.trailingAnchor),
            passwordFeild.heightAnchor.constraint(equalTo: meetingIdFeild.heightAnchor),
            passwordFeild.topAnchor.constraint(equalTo: screenNameFeild.bottomAnchor, constant: 20.heightRatio),
            
            
            joinmeetingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            joinmeetingButton.topAnchor.constraint(equalTo: passwordFeild.bottomAnchor , constant: 30.heightRatio),
            joinmeetingButton.widthAnchor.constraint(equalToConstant: 200.widthRatio),
            joinmeetingButton.heightAnchor.constraint(equalToConstant: 50.heightRatio),
            
            audioContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            audioContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            audioContainer.topAnchor.constraint(equalTo: joinmeetingButton.bottomAnchor, constant: 50.heightRatio),
            audioContainer.heightAnchor.constraint(equalToConstant: 50.heightRatio),
            dontConnectToAudioLabel.leadingAnchor.constraint(equalTo: audioContainer.leadingAnchor , constant: 10.widthRatio),
            dontConnectToAudioLabel.centerYAnchor.constraint(equalTo: audioContainer.centerYAnchor),
            audioSwitch.trailingAnchor.constraint(equalTo: audioContainer.trailingAnchor , constant: -20.widthRatio),
            audioSwitch.centerYAnchor.constraint(equalTo: audioContainer.centerYAnchor),
            
            videoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoContainer.topAnchor.constraint(equalTo: audioContainer.bottomAnchor, constant: 5.heightRatio),
            videoContainer.heightAnchor.constraint(equalToConstant: 50.heightRatio),
            
            turnOffVideoLabel.leadingAnchor.constraint(equalTo: videoContainer.leadingAnchor , constant: 10.widthRatio),
            turnOffVideoLabel.centerYAnchor.constraint(equalTo: videoContainer.centerYAnchor),
            
            videoSwitch.trailingAnchor.constraint(equalTo: videoContainer.trailingAnchor , constant: -20.widthRatio),
            videoSwitch.centerYAnchor.constraint(equalTo: videoContainer.centerYAnchor),
        
        ])
    }
    
    //MARK:-Helper Methods
    
    func joinMeeting(meetingID: String, meetingPassword: String , displayName : String , switchAudioOff : Bool , switchVideOff : Bool) {

        if let meetingService = MobileRTC.shared().getMeetingService() {
            meetingService.delegate = self
            
            let joinMeetingParameters = MobileRTCMeetingJoinParam()
            joinMeetingParameters.meetingNumber = meetingID
            joinMeetingParameters.password = meetingPassword
            joinMeetingParameters.userName = displayName
            joinMeetingParameters.noAudio = switchAudioOff
            joinMeetingParameters.noVideo = switchVideOff
            
            meetingService.joinMeeting(with: joinMeetingParameters)
        }
    }
    
    
    //MARK:-#selector
    
    @objc func joinmeetingButtonPressed(){
        
        joinMeeting(meetingID: meetingIdFeild.text!, meetingPassword: passwordFeild.text!, displayName: screenNameFeild.text!, switchAudioOff: audioSwitch.isOn, switchVideOff: videoSwitch.isOn)
        
        
    }
    
}
extension JoinMeetingController : MobileRTCMeetingServiceDelegate {
    // Is called upon in-meeting errors, join meeting errors, start meeting errors, meeting connection errors, etc.
    func onMeetingError(_ error: MobileRTCMeetError, message: String?) {
        switch error {
        case .success:
            print("Successful meeting operation.")
        case .passwordError:
            print("Could not join or start meeting because the meeting password was incorrect.")
        default:
            print("MobileRTCMeetError: \(error) \(message ?? "")")
        }
    }

    // Is called when the user joins a meeting.
    func onJoinMeetingConfirmed() {
        print("Join meeting confirmed.")
    }

    // Is called upon meeting state changes.
    func onMeetingStateChange(_ state: MobileRTCMeetingState) {
        print("Current meeting state: \(state)")
    }
}
