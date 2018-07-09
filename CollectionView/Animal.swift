//
//  Animal.swift
//  CollectionView
//
//  Created by kan sing lam
//  Copyright © 2018年 kan sing lam All rights reserved.
//

struct Animal {
    var name : String
    var wikiLinkWord : String
    var photoKeyword : String
    
    
    init(_ name : String, _ wikiLinkWord : String, _ photoKeyword : String) {
        self.name = name
        self.wikiLinkWord = "https://en.wikipedia.org/wiki/" + wikiLinkWord
        self.photoKeyword = photoKeyword
    }
}
