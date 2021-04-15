//
//  FileManager+Extensions.swift
//  MyClock
//
//  Created by Huy Ong on 4/12/21.
//

import Foundation

extension FileManager {
    private static func documentsURL() -> URL {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { fatalError("Failed to load url directory") }
        return url
    }
    
    static func userDataUpdatesDataPath() -> URL {
        let url = documentsURL().appendingPathComponent("data_updates.json")
        let doesExist = FileManager.default.fileExists(atPath: url.path)
        if doesExist {
            return url
        } else {
            do {
                let data = TimeData.initilizeData()
                let dataEncode = try JSONEncoder().encode(data)
                try dataEncode.write(to: documentsURL().appendingPathComponent("data_updates.json"), options: .atomic)
                return url
            } catch {
                fatalError("Failed to encode data \(error)")
            }
        }
    }
}
