//
//  LoginViewController.swift
//  BBangChinJa
//
//  Created by EoJin Choi on 5/22/24.
//

import Foundation
import AuthenticationServices
import SnapKit

class LoginViewController: UIViewController {
    private lazy var signInButton: ASAuthorizationAppleIDButton = {
        let signInButton = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
        signInButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: UIControl.Event.touchUpInside)
        return signInButton
    }()
    
    @objc private func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = []
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        autoLayout()
    }
}

extension LoginViewController {
    private func addSubView() {
        view.addSubview(signInButton)
    }
    
    private func autoLayout() {
        signInButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(44)
        }
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    //로그인 성공
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userId = appleIDCredential.user
            
            if let authorizationCode = appleIDCredential.authorizationCode,
               let identityToken = appleIDCredential.identityToken,
               let authCodeString = String(data: authorizationCode, encoding: .utf8),
               let identifyTokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authCodeString: \(authCodeString)")
                print("identifyTokenString: \(identifyTokenString)")
            }
            print("userId: \(userId)")
        }
    }
    
    //로그인 실패
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("login failed - \(error.localizedDescription)")
    }
    
    //자동 로그인
}
