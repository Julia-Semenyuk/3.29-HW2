//
//  CollectionViewController.swift
//  3.29 HW2
//
//  Created by Юлия on 18.09.2022.
//

import UIKit

enum Link: String {
    case alienMortyURL = "https://rickandmortyapi.com/api/character/14"
    case nimbusSecretaryURL = "https://rickandmortyapi.com/api/character/684"
    case rickSanchesURL = "https://rickandmortyapi.com/api/character/290"
}
   

enum UserAction: String, CaseIterable {
    case fetchAlienMorty = "Alien Morty"
    case fetchNimbusSecretary = "Mr. Nimbus Secretary"
    case fetchRickSanches = "Rick Sanches"
}


class CollectionViewController: UICollectionViewController {

    private let userActions = UserAction.allCases

   

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newCell", for: indexPath) as? CollectionViewCell
        else {  return UICollectionViewCell() }
       
        let userAction = userActions[indexPath.item]
        
        cell.userActionLabel.text = userAction.rawValue
    
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
            
        case .fetchAlienMorty: fetchAlienMorty()
        case .fetchNimbusSecretary: fetchNimbusSecretary()
        case .fetchRickSanches: fetchRickSanches()
        }
    }

    //MARK: - Private Methods
    
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug Aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Faild",
                message: "You can see error in the Debug Aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func fetchNimbusSecretary() {
        
    }

    private func fetchRickSanches() {
        
    }
}

    //MARK: - Networking
    extension CollectionViewController {
        private func fetchAlienMorty() {
            guard let url = URL(string: Link.alienMortyURL.rawValue ) else { return }
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, _, error in
                guard let data = data else {
                    print(error?.localizedDescription ?? "No error description")
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let AlienMorty = try jsonDecoder.decode(RickAndMorty.self, from: data)
                    self.successAlert()
                } catch {
                    print(error.localizedDescription)
                    self.failedAlert()
                }
            }
            task.resume()
        }
    }


