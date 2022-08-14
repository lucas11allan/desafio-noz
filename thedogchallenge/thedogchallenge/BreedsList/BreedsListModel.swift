//
//  DogsListModel.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation

struct BreedImage: Codable {
    let breeds: [BreedDetail]?
    let id: String?
    let url: String?
    let width: Int?
    let height: Int?
}

struct BreedDetail: Codable {
    let weight: Weight
    let height: Height
    let id: Int?
    let name: String?
    let country_code: String?
    let breed_for: String?
    let breed_group: String?
    let life_span: String?
    let temperament: String?
    let reference_image_id: String?
}

struct Weight: Codable {
    let imperial: String?
    let metric: String?
}

struct Height: Codable {
    let imperial: String?
    let metric: String?
}
