//
//  BreedsSearchModel.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation

struct Breeds: Codable {
    let response: [Breed]
}

struct Breed: Codable {
    let weight: Weight
    let height: Height
    let id: String
    let name: String
    let breed_for: String
    let breed_group: String
    let life_span: String
    let temperament: String
    let reference_image_id: String
}
