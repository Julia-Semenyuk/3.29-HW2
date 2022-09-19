//
//  File.swift
//  3.29 HW2
//
//  Created by Юлия on 18.09.2022.
//

import Foundation

struct RickAndMorty: Decodable {
    let name: String?
    let status: String?
    let species: String?
    let gender: String?
    let image: String?
    let episode: [String?]
    
}
