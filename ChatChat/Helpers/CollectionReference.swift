//
//  CollectionReference.swift
//  ChatChat
//
//  Created by Angela Zhang on 8/24/19.
//  Copyright © 2019 qinyuanzhang.com. All rights reserved.
//


import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case User
    case Typing
    case Recent
    case Message
    case Group
    case Call
}


func reference(_ collectionReference: FCollectionReference) -> CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}

