//
//  FlickrPhotoViewController.swift
//  CollectionView
//
//  Created by kan sing lam
//  Copyright © 2018年 kan sing lam All rights reserved.
//

import UIKit

class FlickrPhotoViewController : UIViewController{
    
    var selectedAnimal : Animal?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queryURL : URL = flickrURLFromParameters(selectedAnimal?.photoKeyword ?? "Dog")
        
        let session = URLSession.shared
        let request = URLRequest(url: queryURL)
        
        let task = session.dataTask(with:request){(data, response, error) in
            if error == nil {
                let statusCode : Int! = (response as? HTTPURLResponse)?.statusCode
                if (statusCode >= 200  && statusCode <= 299){
                    
                    guard let data = data else {
                        print("the data is null")
                        return
                    }
                    
                    let parsedResult: [String:AnyObject]!
                    do {
                        parsedResult = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
                    }catch {
                        print("Could not parse the data as JSON: '\(data)'")
                        return
                    }
                    
                    guard let photoDictionary = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String : AnyObject]
                        , let photoArray = photoDictionary[Constants.FlickrResponseKeys.Photo] as? [[String:AnyObject]] else {
                            print("photoDictionary deadd")
                            return
                    }
                    
                    let singlePhoto = photoArray[1] as [String:AnyObject]
                    
                    let imageUrlString = singlePhoto[Constants.FlickrResponseKeys.MediumURL] as? String
                    
                    if let imageURL = URL(string: imageUrlString!), let data = try? Data(contentsOf: imageURL){
                        
                        DispatchQueue.main.async {
                            print("load image end")
                            self.imageView.image = UIImage(data: data)
                        }
                    }
                    
                    
                    
                }
            } else {
                print(error!.localizedDescription)
            }
            
        }
        
        task.resume()
        
        
    }
    
    private func flickrURLFromParameters(_ searchString: String) -> URL {
        
        var methodParameters: [String: AnyObject] = [Constants.FlickrParameterKeys.Text: searchString as AnyObject]
        methodParameters[Constants.FlickrParameterKeys.SafeSearch] = Constants.FlickrParameterValues.UseSafeSearch as AnyObject
        methodParameters[Constants.FlickrParameterKeys.Extras] = Constants.FlickrParameterValues.MediumURL as AnyObject
        methodParameters[Constants.FlickrParameterKeys.APIKey] = Constants.FlickrParameterValues.APIKey as AnyObject
        methodParameters[Constants.FlickrParameterKeys.Method] = Constants.FlickrParameterValues.SearchMethod as AnyObject
        methodParameters[Constants.FlickrParameterKeys.Format] = Constants.FlickrParameterValues.ResponseFormat as AnyObject
        methodParameters[Constants.FlickrParameterKeys.NoJSONCallback] = Constants.FlickrParameterValues.DisableJSONCallback as AnyObject
        
        var components = URLComponents()
        components.scheme = Constants.Flickr.APIScheme
        components.host = Constants.Flickr.APIHost
        components.path = Constants.Flickr.APIPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in methodParameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }

}
