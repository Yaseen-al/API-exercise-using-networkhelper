//
//  CharactersViewController.swift
//  2017_12_1 API exercise using networkhelper
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var characterSearchBar: UISearchBar!
    @IBOutlet weak var charactersTableView: UITableView!
    
    var characters = [Character](){
        didSet{
            charactersTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.charactersTableView.delegate = self
        self.charactersTableView.dataSource = self
        self.characterSearchBar.delegate = self
        loadCharacters()
        
        // Do any additional setup after loading the view.
    }
    
    func loadCharacters() {
        print("it is loading the characters")
        let urlStr = "https://swapi.co/api/people/"
        CharacterAPIClient.manager.getCharacter(from: urlStr, completionHandler: {(charactersOnline: [Character]) in
            self.characters = charactersOnline}, errorHandler: {print($0)})
        DispatchQueue.global().async {
                    self.loadMovies()
        }
    }
    func loadMovies(){
        // do stuff
        for i in 0..<self.characters.count{
            // no you have characters
            for j in 0..<self.characters[i].films.count{
                // now you are in films url
                MoviesAPIClient.manager.getMovie(from: self.characters[i].films[j], completionHandler: {self.characters[i].movies?.append($0); print($0.title)}, errorHandler: {print($0)})
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let characterSetup = characters[indexPath.row]
        guard let cell: UITableViewCell = charactersTableView.dequeueReusableCell(withIdentifier: "myCell") else {
            let defaultCell = UITableViewCell()
            defaultCell.textLabel?.text = characterSetup.name
            return defaultCell
        }
        cell.textLabel?.text = characterSetup.name
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
