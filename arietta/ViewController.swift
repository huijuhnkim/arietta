//
//  ViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 11/19/24.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {
    
    let homeView = HomeView()
    let SRlevelView = SightReadingChooseLevelView()
    let SRExerciseView = SightReadingExerciseView()
    let SRResultsView = SightReadingResultsView()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    let db = Firestore.firestore()
    
    override func loadView() {
        view = homeView
        
        let newNavigationTitle = UILabel()
        let attributedTitle = UtilityFunctions.attributedNavigationTitle(text: "Arietta")
        newNavigationTitle.attributedText = attributedTitle
        navigationItem.titleView = newNavigationTitle
        
        homeView.buttonEarTraining.addTarget(self, action: #selector(handleButtonEarTraining), for: .touchUpInside)
        homeView.buttonSightReading.addTarget(self, action: #selector (handleButtonSightReading), for: .touchUpInside)
        homeView.buttonProfile.addTarget(self, action: #selector(handleButtonProfile), for: .touchUpInside)
    }
    
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
         //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
         handleAuth = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
             guard let self = self else { return }

             if user == nil {
                 DispatchQueue.main.async {
                     let launchViewController = LaunchViewController()
                     self.navigationController?.pushViewController(launchViewController, animated: true)
                 }
             } else {
                 self.currentUser = user
             }
         }
         self.showRandomQuote()
     }
    
     func showRandomQuote() {
         let quoteDocument = db.collection("quotes").document("quotes")
        
         quoteDocument.getDocument { (document, error) in
             if let document = document, document.exists {
                 let dataDescription = document.data()
                 if let quotes = dataDescription?.values.compactMap({ $0 as? String }) {
                     let randomQuote = quotes.randomElement() ?? "No quote found"
                     print("Random Quote: \(randomQuote)")
                     self.homeView.labelQuote.attributedText = UtilityFunctions.attributedBlackBodyText(text: randomQuote, fontSize: 36)
                 }
             } else {
                 print("Document does not exist or error: \(error?.localizedDescription ?? "unknown error")")
             }
         }

     }
    
    @objc func handleButtonEarTraining() {
        let ETChooseLevelVC = EarTrainingChooseLevelViewController()
        navigationController?.pushViewController(ETChooseLevelVC, animated: true)
    }
    
    @objc func handleButtonSightReading() {
        let SRChooseLevelVC = SightReadingChooseLevelViewController()
        navigationController?.pushViewController(SRChooseLevelVC, animated: true)
    }
    

    @objc func handleButtonProfile() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
}

