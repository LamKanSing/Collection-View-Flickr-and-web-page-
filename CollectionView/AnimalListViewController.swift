//
//  ViewController.swift
//  CollectionView
//
//  Created by kan sing lam
//  Copyright © 2018年 kan sing lam All rights reserved.
//

import UIKit

class MyCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
}

class AnimalListViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate  {
    
    var collecionItem : [Animal] = []
    @IBOutlet weak var sourceSwitch: UISwitch!
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: self.collectionView.bounds.width, height: 300)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInput()
    }
    
    @IBAction func changeSource(_ sender: Any) {
        print("hit the switch")
        if (sourceSwitch.isOn){
            sourceLabel.text = "Wiki"
        } else {
            sourceLabel.text = "Flickr"
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collecionItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.textLabel.text = String(collecionItem[indexPath.row].name)
        cell.imageView.image = UIImage(named: collecionItem[indexPath.row].photoKeyword)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let selectedAnimal = collecionItem[indexPath.row]
        
        if sourceSwitch.isOn{
            
            let destination = storyboard.instantiateViewController(withIdentifier: "WikiViewController") as! WikiViewController
            destination.selectedAnimal = selectedAnimal
            navigationController?.pushViewController(destination, animated: true)
            
        }else {
            
            let destination = storyboard.instantiateViewController(withIdentifier: "FlickrPhotoViewController") as! FlickrPhotoViewController
            destination.selectedAnimal = selectedAnimal
            navigationController?.pushViewController(destination, animated: true)
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
    }
    
    private func setInput(){
        collecionItem.append(Animal("Dog", "Dog", "Dog"))
        collecionItem.append(Animal("Cat", "Cat", "Cat"))
        collecionItem.append(Animal("Horse", "Horse", "Horse"))
        
    }
}




