//
//  LoginViewController.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import UIKit

protocol LoginDisplayLogic {
    func loginFail(error: LoginErrorType)
}

class LoginViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    var interactor: (LoginBusinessLogic & LoginDataStore)?
    var router: (LoginRoutingLogic & LoginDataPassing)?
    
    class func viewController() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)

        guard let controller = storyboard.instantiateInitialViewController() as? LoginViewController else {
            fatalError("missing load controller from storyboard")
        }

        return controller
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let presenter = LoginPresenter(viewController: self)
        interactor = LoginInteractor(presenter: presenter)
        guard let interactor = interactor else { return }
        router =  LoginRouter(viewController: self, dataStore: interactor)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        interactor?.login(email: emailTextField.text, password: passwordTextField.text)
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        router?.openRegister()
    }
}

extension LoginViewController: LoginDisplayLogic {
    func loginFail(error: LoginErrorType) {
        router?.showDialog(error: error)
    }
}
