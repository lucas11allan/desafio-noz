//
//  DogDetailModel.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation

struct DogDetailModel: Decodable {
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
