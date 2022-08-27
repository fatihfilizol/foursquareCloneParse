//
//  PlacesViewController.swift
//  FoursquareCloneParse
//
//  Created by Fatih Filizol on 21.08.2022.
//

import UIKit
import Parse

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    
    var placesNameArray = [String]()
    var placesIdArray = [String]()
    var selectedPlaceId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem.init(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
        
        tblView.delegate = self
        tblView.dataSource = self
        
        getDataFromParse()
    }
    
    func getDataFromParse(){
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            if error != nil{
                self.makeAlert(titleInput: "Error", messageınput: error?.localizedDescription ?? "Error")
            }else{
                
                if objects != nil{
                    
                    self.placesNameArray.removeAll(keepingCapacity: false)
                    self.placesIdArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String{
                            if let placeId = object.objectId{
                                self.placesNameArray.append(placeName)
                                self.placesIdArray.append(placeId)
                            }
                        }
                    }
                    
                    self.tblView.reloadData()
                    
                }
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.chosenPlaceId = selectedPlaceId
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceId = placesIdArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    @objc func addButtonClicked(){
        
        self.performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
        
    }
    
    
    @objc func logoutButtonClicked(){
        
        PFUser.logOutInBackground { error in
            if error != nil{
                self.makeAlert(titleInput: "Error", messageınput: error?.localizedDescription ?? "Error")
            }else{
                self.performSegue(withIdentifier: "toSıgnUpVC", sender: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesNameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placesNameArray[indexPath.row]
        return cell
    }
    
    func makeAlert(titleInput: String, messageınput: String){
        let alert = UIAlertController(title: titleInput, message: messageınput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}
