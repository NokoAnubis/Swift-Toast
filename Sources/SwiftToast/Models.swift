//
//  Models.swift
//  Olympsis
//
//  Created by Joel Joseph on 7/15/23.
//

import Foundation

public struct Toast: Equatable {
    public var style: ToastStyle
    public var actor: String?
    public var title: String
    public var message: String
    public var duration: Double = 3
    public var width: Double = 300
}

public enum ToastStyle: String {
    case error = "error"
    case warning = "warning"
    case success = "success"
    case info = "info"
    case newPost = "new_post"
    case message = "message"
    case newEvent = "new_event"
    case eventStatus = "event_status"
}
