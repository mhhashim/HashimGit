//
//  AnalyticsEvent.swift
//  HashimGit
//
//  Created by Hashim M H on 27/02/21.
//

import Foundation

class AnalyticsEvent {
    private var catagory:String!
    private var action:String
    private var platform:String?
    private var params:[String: String] = [:]
    public static let get = { Builder() }
    private init() {
        action = ""
        platform = "ios"
    }

    private func send() {

    }

    class Builder {
        private var event: AnalyticsEvent = AnalyticsEvent()
        func setCatagory (catagory: String) -> Self {
            event.catagory = catagory
            return self
        }

        func addParams (key: String, value: String) -> Self {
            event.params[key] = value
            return self
        }

        func build() -> AnalyticsEvent {
            event
            kkk
        }

        func send() {
            precondition(event.catagory != nil)
            event.send()
        }

    }
}

class Analytics {
    static func tag() {
        AnalyticsEvent.get()
            .setCatagory(catagory:  "catagory")
            .addParams(key: "akey", value: "avalue")
            .send()
    }

}

