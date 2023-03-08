//
//  RegisterViewController.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 7/3/2566 BE.
//

import UIKit

protocol RegisterDisplayLogic {
    func registerSuccess()
    func registerFail(type: RegisterErrorType)
}

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    var interactor: (RegisterBusinessLogic & RegisterDataStore)?
    var router: (RegisterRoutingLogic & RegisterDataPassing)?

    class func viewController() -> RegisterViewController {
        let storyboard = UIStoryboard(name: "Register", bundle: Bundle.main)

        guard let controller = storyboard.instantiateInitialViewController() as? RegisterViewController else {
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
        let presenter = RegisterPresenter(viewController: self)
        interactor = RegisterInteractor(presenter: presenter)
        guard let interactor = interactor else { return }
        router = RegisterRouter(viewController: self, dataStore: interactor)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        interactor?.register(email: emailTextfield.text, password: passwordTextField.text, conformPassword: confirmPasswordTextField.text)
    }
}

extension RegisterViewController: RegisterDisplayLogic {
    func registerSuccess() {
        router?.openLogin()
    }

    func registerFail(type: RegisterErrorType) {
        router?.showDialog(error: type)
    }
}
