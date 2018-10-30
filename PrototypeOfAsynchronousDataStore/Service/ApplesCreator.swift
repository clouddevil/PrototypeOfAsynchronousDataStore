//
//  ApplesCreator.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by user on 25/09/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return (index < count) ? self[index] : nil
    }
}

class ApplesCreator {

    private var lastId = 0
    private let titlesDatasource: Array<String> = ["Антоновка", "Грушовка", "Синева", "Сливовка", "Ананасовка", "Капустовка", "Маркововка", "Егоровка"]
    private let colorsDatasource: Array<String> = ["green", "red", "yellow"]
    private let statesDatasource: Array<String> = ["eaten", "needToEat", "onATree"]
    private var existingApples = [JsonApple]()

    // TODO:
    func eatApple(_ appleId: Int) -> [JsonApple] {
        let apple = existingApples.first(where: { $0.id == appleId })
        apple?.state = "eaten"
        return [apple ?? nil].compactMap({ $0 })
    }

    func getApples(editCount: Int, createCount: Int, removeCount: Int) -> [JsonApple] {

        if (editCount > 0 && existingApples.count > 0) {
            for _ in 0..<editCount {
                let randAppleIndex = randomInt(min: 0, max: existingApples.count)
                let appleId = existingApples[randAppleIndex].id
                existingApples.remove(at: randAppleIndex)
                existingApples.append(configureRandomApple(id: appleId))
            }
        }

        if (createCount > 0) {
            for _ in 0..<createCount {
                lastId += 1
                existingApples.append(configureRandomApple())
            }
        }

        if (removeCount > 0 && removeCount < existingApples.count) {
            for _ in 0..<removeCount {
                let randAppleIndex = randomInt(min: 0, max: existingApples.count)
                existingApples.remove(at: randAppleIndex)
            }
        }

        return existingApples
    }

    private func configureRandomApple(id: Int? = nil) -> JsonApple {

        let randTitleIndex = randomInt(min: 0, max: titlesDatasource.count)
        let randColorIndex = randomInt(min: 0, max: colorsDatasource.count)
        let randStateIndex = randomInt(min: 0, max: statesDatasource.count)

        let appleId = id ?? lastId
        return JsonApple(appleId: appleId,
                title: titlesDatasource[randTitleIndex],
                color: colorsDatasource[randColorIndex],
                state: statesDatasource[randStateIndex])
    }
}
