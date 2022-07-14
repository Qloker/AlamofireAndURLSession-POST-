//
//  ViewController.swift
//  Task19JsonAlamofireURL
//
//  Created by Ilia Zakharov on 07.07.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    //MARK: - Views
    private let dateLabel = UILabel(text: "Birth date")
    private let occupationLabel = UILabel(text: "Occupation")
    private let nameLabel = UILabel(text: "Name")
    private let lastNameLabel = UILabel(text: "Last name")
    private let countryLabel = UILabel(text: "Country")
    
    private var dateText = ""
    private var occupationText = ""
    private var nameText = ""
    private var lastNameText = ""
    private var countryText = ""
    
    private let dateTextField = UITextField(placeHolder: "Date", keyboardType: .numberPad)
    private let occupationTextField = UITextField(placeHolder: "Occupation", keyboardType: .default)
    private let nameTextField = UITextField(placeHolder: "Name", keyboardType: .default)
    private let lastNameTextField = UITextField(placeHolder: "Last name", keyboardType: .default)
    private let countryTextField = UITextField(placeHolder: "Contry", keyboardType: .default)
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var alamofirePost = UIButton(backgroundColor: .green, text: "Alamofire", textColor: .black)
    private lazy var urlSessionPost = UIButton(backgroundColor: .orange, text: "URLSession", textColor: .black)
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        alamofirePost.addTarget(self, action: #selector(tappedAlamofire), for: .touchUpInside)
        urlSessionPost.addTarget(self, action: #selector(tappedUrlSession), for: .touchUpInside)

        setupDelegates()
        setupViews()
        setupConstraints()

    }
    
    //MARK: - Actions
    private func setupDelegates() {
        dateTextField.delegate = self
        occupationTextField.delegate = self
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        countryTextField.delegate = self
    }
    
    private func setupViews() {
        
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(dateTextField)
        stackView.addArrangedSubview(occupationLabel)
        stackView.addArrangedSubview(occupationTextField)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(lastNameLabel)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(countryLabel)
        stackView.addArrangedSubview(countryTextField)

        view.addSubview(stackView)
        view.addSubview(alamofirePost)
        view.addSubview(urlSessionPost)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            dateTextField.widthAnchor.constraint(equalToConstant: 200),
            occupationTextField.widthAnchor.constraint(equalToConstant: 200),
            nameTextField.widthAnchor.constraint(equalToConstant: 200),
            lastNameTextField.widthAnchor.constraint(equalToConstant: 200),
            countryTextField.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            alamofirePost.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alamofirePost.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            alamofirePost.widthAnchor.constraint(equalToConstant: 200),
            alamofirePost.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            urlSessionPost.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            urlSessionPost.topAnchor.constraint(equalTo: alamofirePost.bottomAnchor, constant: 20),
            urlSessionPost.widthAnchor.constraint(equalToConstant: 200),
            urlSessionPost.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - Alamofire
    @objc func tappedAlamofire() {
        
        dateText = dateTextField.text ?? ""
        occupationText = occupationTextField.text ?? ""
        nameText = nameTextField.text ?? ""
        lastNameText = lastNameTextField.text ?? ""
        countryText = countryTextField.text ?? ""
    
        if dateText == "" ||
            occupationText == "" ||
            nameText == "" ||
            lastNameText == "" ||
            countryText == "" {
            self.failureAlert()
            return
        }
        
        
        dateTextField.endEditing(true)
        occupationTextField.endEditing(true)
        nameTextField.endEditing(true)
        lastNameTextField.endEditing(true)
        countryTextField.endEditing(true)
        
        let infoPost = InfoModel(
            birth: Int(dateText) ?? 0,
            occupation: occupationText,
            name: nameText,
            lastName: lastNameText,
            country: countryText)
        
        AF.request(
            "https://jsonplaceholder.typicode.com/posts",
                   method: .post,
                   parameters: infoPost,
                   encoder: JSONParameterEncoder.default
        ).response { [weak self] response in
            guard response.error == nil else {
                print(response.error ?? "error")
                self?.failureAlert()
                return
            }
            self!.successAlert()
            debugPrint(response)
        }
    }
    
    //MARK: - URLSession
    @objc private func tappedUrlSession() {
        
        dateText = dateTextField.text ?? ""
        occupationText = occupationTextField.text ?? ""
        nameText = nameTextField.text ?? ""
        lastNameText = lastNameTextField.text ?? ""
        countryText = countryTextField.text ?? ""
        
        if dateText == "" ||
            occupationText == "" ||
            nameText == "" ||
            lastNameText == "" ||
            countryText == "" {
            
            self.failureAlert()
            return
        }
        
        dateTextField.endEditing(true)
        occupationTextField.endEditing(true)
        nameTextField.endEditing(true)
        lastNameTextField.endEditing(true)
        countryTextField.endEditing(true)
        
        let infoPost = InfoModel(
            birth: Int(dateText) ?? 0,
            occupation: occupationText,
            name: nameText,
            lastName: lastNameText,
            country: countryText)
        
        let encoder = JSONEncoder()
        let jsonData: Data? = try? encoder.encode(infoPost)
        
        var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            
            guard let data = data, error == nil else  {
                DispatchQueue.main.async {
                    self?.failureAlert()
                }
                return
            }
            
            DispatchQueue.main.async {
                print(response!)
                self?.successAlert()
            }
        }
        .resume()
    }
    
    //MARK: - Alert
     func createAlert(title: String, message: String, actionTitle: String) -> UIAlertController {
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: nil))
        return alert
    }
    
    private func failureAlert() {
        let alert = self.createAlert(
            title: "Error",
            message: "Try again",
            actionTitle: "Back to text field")
        self.present(alert, animated: true, completion: nil)
    }
    
    private func successAlert() {
        let alert = self.createAlert(
            title: "Successful",
            message: "Post complited",
            actionTitle: "Back to text field")
        self.present(alert, animated: true, completion: nil)
    }
}


extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        self.view.endEditing(true)
    }
}
