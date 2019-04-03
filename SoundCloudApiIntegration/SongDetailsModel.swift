//
//  SongDetailsModel.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 03/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

struct SongDetailsModel : Decodable { //or class tho?
    let id : Int
    let title : String
    let artwork_url : String?
}
