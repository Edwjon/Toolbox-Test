//
//  ViewController.swift
//  Toolbox Test
//
//  Created by Edward Pizzurro Fortun on 2/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .systemPink
        spinner.showsLargeContentViewer = true
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: view.frame.width - 20).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: view.frame.height - 20).isActive = true
        
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOpacity = 1
        loginButton.layer.shadowOffset = .zero
        loginButton.layer.shadowRadius = 10
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
    }
}


//MARK: - IBActions -
extension ViewController {
    
    @IBAction func loginButtonAction(_ sender: Any) {
        logUser()
    }
    
}


//MARK: - HTTP Methods -
extension ViewController {
    
    func logUser() {
        
        let loginData = LoginQueryData(sub: "ToolboxMobileTest")
        
        spinner.startAnimating()
        
        LoginService().login(parametros: loginData) { loginRes in
            
            self.spinner.stopAnimating()

            switch loginRes {
            case .success(let successResponse):
                
                print("YESSSSS")
                print(successResponse)
                
                UserDefaults.standard.set(successResponse.token, forKey: "token_access")
                UserDefaults.standard.set(successResponse.type, forKey: "token_type")
                
                CarruselesService().getCarruseles { (carruselesResponse) in
                    switch carruselesResponse {
                    case .success(let successResponse):
                        carruseles = successResponse
                        self.performSegue(withIdentifier: "goToCarruseles", sender: nil)
                    case .failure(let errorResponse):
                        print(errorResponse)
                    }
                }
                
            case .failure(let loginError as LoginErrorResponse):
                
                print("NOOOOO")
                print(loginError)
                
                var errorMessage:String = "Error al hacer el registro"
                errorMessage = loginError.message
                
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            case .failure(_):
                return
            }
        }
    }
}
