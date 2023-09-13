//
//  ViewController.swift
//  LoginUIKIT
//
//  Created by Deepak Basavaraj Kamatad on 08/09/23.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Login: UIButton!
    var iconClick=false
    let imageicon = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUnderline(to: Username)
        addUnderline(to: Password)
        Password.isSecureTextEntry = true
        Login.layer.cornerRadius = 5
        imageicon.image = UIImage(named: "closedeye")
        let contentView = UIView()
        contentView.addSubview(imageicon)
        contentView.frame=CGRect(x: 0, y: 0, width: UIImage(named: "closedeye")!.size.width, height: UIImage(named: "closedeye")!.size.height)
        
        imageicon.frame=CGRect(x: -10, y: 0, width: UIImage(named: "closedeye")!.size.width, height: UIImage(named: "closedeye")!.size.height)
        
        Password.rightView = contentView
        Password.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageicon.isUserInteractionEnabled = true
        imageicon.addGestureRecognizer(tapGestureRecognizer)
        
        Username.delegate = self
        Password.delegate = self
        updateLoginButtonState()
    }
    @IBAction func Login(_ sender: Any) {
        let username = Username.text
        let password = Password.text
        updateLoginButtonState()
        showAlert(title: "Successfull", message: "Login SuccessFull")
        print("Username: \(username), Password: \(password)")
    }
    
    @IBAction func ForgotPassword(_ sender: Any) {
        showAlert(title: "Forgot Password", message: "Please check your email for password reset instructions.")
    }
    
    private func addUnderline(to textField: UITextField) {

            let bottomBorder = CALayer()
            bottomBorder.frame = CGRect(x: 0.0, y: textField.frame.size.height - 1, width: textField.frame.size.width, height: 1.0)
            bottomBorder.backgroundColor = UIColor.black.cgColor
            textField.layer.addSublayer(bottomBorder)

        }
    
    private func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    
    private func updateLoginButtonState() {
            guard let username = Username.text, !username.isEmpty,
                  let password = Password.text, !password.isEmpty else {
                // If either username or password is empty, disable the login button
                Login.isEnabled = false
                return
            }
            // If both fields are non-empty, enable the login button
            Login.isEnabled = true
        }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateLoginButtonState()
        return true
    }
    
    @objc func imageTapped(tapGestureRecognizer:UITapGestureRecognizer){
        let tappedImage=tapGestureRecognizer.view as! UIImageView
        
        if iconClick{
            iconClick = false
            tappedImage.image = UIImage(named: "openedeye")
            Password.isSecureTextEntry = false
        }
        else {
            iconClick = true
            tappedImage.image = UIImage(named: "closedeye")
            Password.isSecureTextEntry = true
        }
    }
    
}

