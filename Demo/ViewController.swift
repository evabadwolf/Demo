//
//  ViewController.swift
//  FireBaseSocialLogin
//
//  Created by Eva Yang Mesa on 6/21/18.
//  Copyright © 2018 Eva Yang Mesa. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

//import GoogleSignIn

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
//    class ViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFacebookButton()
//        setupGoogleButtons()
    }
    
/*    fileprivate func setupGoogleButtons(){
        //add Google Sign In Button
        let googleButton =  GIDSignInButton()
        googleButton.frame = CGRect(x: 16, y: 116 + 66, width: view.frame.width - 32, height: 50)
        view.addSubview(googleButton)
        GIDSignIn.sharedInstance().uiDelegate = self;
        //[[GIDSignIn sharedInstance] signIn];
    }*/
    
    fileprivate func setupFacebookButton(){
        //standard FB Login Button
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        //frames are obsolete, please use contraints instead
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        loginButton.readPermissions = ["email", "public_profile"]
        loginButton.delegate = self
        //custom FB Login Button
        let customFBButton = UIButton(type: .system)
        customFBButton.backgroundColor = .blue
        customFBButton.frame = CGRect(x: 16, y: 116, width: view.frame.width - 32, height: 50)
        customFBButton.setTitle("Customer FB Login here", for: .normal)
        customFBButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        customFBButton.setTitleColor(.white, for: .normal)
        view.addSubview(customFBButton)
        customFBButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
    }
    
    //Cusom FB Button
    @objc func handleCustomFBLogin(){
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, err) in
            if err != nil {
                print("failed to start fb custom request: ", err!)
                return
            }
            //print(result?.token.tokenString)
            self.showEmailAddress()
        }
    }
    
    
    
    //Login Button Actions
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did logout of FB")
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print (error)
            return
        }
        
        showEmailAddress()
    }
    
    func showEmailAddress(){
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenStrong = accessToken?.tokenString else { return }
        
        //let credentials = firfab
        
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id,name,email"]).start { (connection, result, err) in
            if err != nil {
                print("failed to start request: ", err!)
                return
            }
            print(result!)        }
        print("Succesfully logged into FB")
    }
    
}

