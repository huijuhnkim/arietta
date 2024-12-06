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
        
        //testing signin
        homeView.buttonProgressReport.addTarget(self, action: #selector (handleButtonProgressReport), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }

            if user == nil {
                DispatchQueue.main.async {
                    let signInViewController = SignInViewController()
                    self.navigationController?.pushViewController(signInViewController, animated: true)
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
                    self.homeView.labelQuote.text = randomQuote
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
    
    @objc func handleButtonProgressReport() {
        let signinVC = SignInViewController()
        navigationController?.pushViewController(signinVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

