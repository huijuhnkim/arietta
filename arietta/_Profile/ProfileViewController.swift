//
//  ProfileViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/8/24.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    
    var progress = [ETResult]()
    let database = Firestore.firestore()

    override func loadView() {
        view = profileView
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

        
        currentUser = Auth.auth().currentUser

            
            //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
            handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
                if user == nil {
                    //MARK: not signed in...
                    self.currentUser = nil
                    let launchVC = LaunchViewController()
                    self.navigationController?.pushViewController(launchVC, animated: true)
                    
                } else {
                    self.profileView.labelUsername.text = user?.displayName
                    self.profileView.labelEmail.text = user?.email

                    self.downloadAndDisplayProfilePicture()

                    
                    
                    self.database.collection("users")
                        .document((self.currentUser?.uid)!)
                        .collection("earTrainingResults")
                        .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                            if let documents = querySnapshot?.documents{
                                self.progress.removeAll()
                                for document in documents{
                                    do{
                                        let results = try document.data(as: ETResult.self)
                                        self.progress.append(results)
                                    }catch{
                                        print(error)
                                    }
                                }
                                self.profileView.tableViewResults.reloadData()
                            }
                        })
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileView.buttonSignOut.addTarget(self, action: #selector(onButtonSignOutTapped), for: .touchUpInside)

        
        profileView.buttonProfilePicture.addTarget(self, action: #selector(editProfilePictureTapped), for: .touchUpInside)
        profileView.tableViewResults.delegate = self
        profileView.tableViewResults.dataSource = self

    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            Auth.auth().removeStateDidChangeListener(handleAuth!)
        }
    
    @objc func onButtonSignOutTapped() {
        let logoutAlert = UIAlertController(title: "Sign Out", message: "Are you sure want to sign out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Sign Out", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)

    }
    
    func uploadProfilePicture(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.4),
              let userId = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("profile_pictures/\(userId)/avatar.jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error)")
            } else {
                print("Profile picture uploaded successfully")
                self.downloadAndDisplayProfilePicture()  // Refresh the displayed image
            }
        }
    }
    
    func downloadAndDisplayProfilePicture() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("profile_pictures/\(userId)/avatar.jpg")
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error)")
            } else if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileView.buttonProfilePicture.setImage(image, for: .normal)
                }
            }
        }
    }
    
    @objc func editProfilePictureTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let editedImage = info[.editedImage] as? UIImage else { return }
        uploadProfilePicture(image: editedImage)
        picker.dismiss(animated: true, completion: nil)
    }


}

