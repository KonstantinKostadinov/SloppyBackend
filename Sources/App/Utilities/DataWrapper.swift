//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 28.07.21.
//

import Vapor

struct DataWrapper<T: Content>: Content {
    let data: T

    static func encodeResponse(data: T, for request: Request) -> EventLoopFuture<Response> {
        self.init(data: data).encodeResponse(for: request)
    }
}
