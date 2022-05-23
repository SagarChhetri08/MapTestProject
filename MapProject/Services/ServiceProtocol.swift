//
//  ServiceProtocol.swift
//  MapProject
//
//  Created by Sarad Chhetri on 23/5/2022.
//

import Foundation
protocol ServiceProtocol {
    func fetchLocationDatas(completion: @escaping (LocationData?) -> Void)
}
