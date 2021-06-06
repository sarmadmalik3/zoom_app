//
//  ViewController.swift
//  ZoomApp
//
//  Created by Sarmad Ishfaq on 06/06/2021.
//

import UIKit
import MobileRTC

class ViewController: UIViewController {

    let joinMeetingButton : UIButton = {
        let button = UIButton()
        button.setTitle("Join Meeting", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(joinmeetingbuttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let instantMeetingButtonPressed : UIButton = {
        let button = UIButton()
        button.setTitle("Start Instant Meeting", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(startInstantMeetingButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        MobileRTC.shared().setMobileRTCRootController(self.navigationController)
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: NSNotification.Name(rawValue: "userLoggedIn"), object: nil)
    }
    
    func setupViews(){
        view.addSubview(joinMeetingButton)
        view.addSubview(instantMeetingButtonPressed)
        NSLayoutConstraint.activate([
        
            joinMeetingButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            joinMeetingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            instantMeetingButtonPressed.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instantMeetingButtonPressed.topAnchor.constraint(equalTo: joinMeetingButton.bottomAnchor, constant: 20),
        
        ])
    }
    //MARK:-Selectors
    @objc func joinmeetingbuttonPressed(){
        presentJoinMeetingAlert()
    }
    @objc func startInstantMeetingButtonPressed(){
        if let authorizationService = MobileRTC.shared().getAuthService(), authorizationService.isLoggedIn() {
            startMeeting()
        } else {
            presentLogInAlert()
        }
    }
    // MARK: - Zoom SDK Examples
    func joinMeeting(meetingNumber: String, meetingPassword: String) {

        if let meetingService = MobileRTC.shared().getMeetingService() {
            meetingService.delegate = self
            
            let joinMeetingParameters = MobileRTCMeetingJoinParam()
            joinMeetingParameters.meetingNumber = meetingNumber
            joinMeetingParameters.password = meetingPassword
            
            meetingService.joinMeeting(with: joinMeetingParameters)
        }
    }

    func logIn(email: String, password: String) {

        if let authorizationService = MobileRTC.shared().getAuthService() {
            authorizationService.login(withEmail: email, password: password, rememberMe: true)
            
        }
    }

    func startMeeting() {

        if let meetingService = MobileRTC.shared().getMeetingService() {
            meetingService.delegate = self
            let startMeetingParameters = MobileRTCMeetingStartParam4LoginlUser()
            meetingService.startMeeting(with: startMeetingParameters)
        }
    }

    // MARK: - Convenience Alerts
    func presentJoinMeetingAlert() {
        let alertController = UIAlertController(title: "Join meeting", message: "", preferredStyle: .alert)

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Meeting number"
            textField.keyboardType = .phonePad
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Meeting password"
            textField.keyboardType = .asciiCapable
            textField.isSecureTextEntry = true
        }

        let joinMeetingAction = UIAlertAction(title: "Join meeting", style: .default, handler: { alert -> Void in
            let numberTextField = alertController.textFields![0] as UITextField
            let passwordTextField = alertController.textFields![1] as UITextField

            if let meetingNumber = numberTextField.text, let password = passwordTextField.text {
                self.joinMeeting(meetingNumber: meetingNumber, meetingPassword: password)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })

        alertController.addAction(joinMeetingAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

    /// Creates alert for prompting the user to enter their Zoom credentials for starting a meeting.
    func presentLogInAlert() {
        let alertController = UIAlertController(title: "Log in", message: "", preferredStyle: .alert)

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Email"
            textField.keyboardType = .emailAddress
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Password"
            textField.keyboardType = .asciiCapable
            textField.isSecureTextEntry = true
        }

        let logInAction = UIAlertAction(title: "Log in", style: .default, handler: { alert -> Void in
//            let emailTextField = alertController.textFields![0] as UITextField
//            let passwordTextField = alertController.textFields![1] as UITextField

//            if let email = emailTextField.text, let password = passwordTextField.text {
                self.logIn(email: "sarmadishfaq59@gmail.com", password: "61B573Ba")
//            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })

        alertController.addAction(logInAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Internal

    /// Selector that is used to start a meeting upon log in success.
    @objc func userLoggedIn() {
        startMeeting()
    }
}

// MARK: - MobileRTCMeetingServiceDelegate
extension ViewController: MobileRTCMeetingServiceDelegate , MobileRTCCustomizedUIMeetingDelegate{
    func onInitMeetingView() {
        print("custommeeting init")
    }
    
    func onDestroyMeetingView() {
        
    }
    

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
