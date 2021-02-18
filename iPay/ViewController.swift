//
//  ViewController.swift
//  iPay
//
//  Created by Felipe Miranda on 17/02/21.
//

import UIKit
import PopupDialog

class ViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var usersTableView: UITableView!
    
    private var arrayImages:[String] = ["Image-1","Image-2","Image-3","Image-4","Image-5"]
    private var arrayUsers:[User] = []
    
    private var userSorted: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        self.usersTableView.delegate =  self
        self.usersTableView.dataSource = self
        self.sortButton.layer.cornerRadius = 8
        self.enableButton(value: false)
        // Do any additional setup after loading the view.
    }
    
    
    private func enableButton(value: Bool) {
        
        if value == true {
            self.sortButton.alpha = 1.0
        }else{
            self.sortButton.alpha = 0.8
        }
        
        self.sortButton.isUserInteractionEnabled =  value
    }
    
    @IBAction func tappedSortButton(_ sender: UIButton) {
        
        self.userSorted = self.arrayUsers.randomElement()
        self.enableButton(value: false)
    }
    
    private func showAlert(){
        // Prepare the popup assets
        let title = "Aeeeee :) "
        let message = "Você foi o premiado da vez, entregue seu cartão e faça a boa para os seus amigos da mesa, pague a conta!!!"
        let image = UIImage(named: "Image")
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)
        popup.view.backgroundColor = .black
        // Create buttons
        let buttonOne = DefaultButton(title: "OK") {
            print("You canceled the car dialog.")
            
            self.enableButton(value: false)
            self.arrayUsers.removeAll()
            self.nameTextField.becomeFirstResponder()
        }
        
        buttonOne.backgroundColor = UIColor(cgColor: CGColor(red: 75/255.0, green: 162/255.0, blue: 218/255.0, alpha: 1))
        buttonOne.titleColor = .white
        

        
        // Add buttons to dialog
        // Alternatively, you can use popup.addButton(buttonOne)
        // to add a single button
        popup.addButtons([buttonOne])

        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let user: User = User(name: textField.text ?? "", imageName: arrayImages.randomElement() ?? "")
        self.arrayUsers.append(user)
        self.usersTableView.reloadData()
        
        if self.arrayUsers.count > 1 {
            self.enableButton(value: true)
        }else{
            self.enableButton(value: false)
        }
        
        textField.text = nil
        
        return true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UserCell?  = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell
        
        cell?.setup(value: self.arrayUsers[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userSelected = self.arrayUsers[indexPath.row]
        
        if self.userSorted === userSelected {
            
            print("vc vai pagar a conta ;(")
            self.showAlert()
        }else{
            self.arrayUsers.remove(at: indexPath.row)
            tableView.reloadData()
            print("vc não vai pagar, se deu bem :) ")
        }
    }
    
}
