//
//  Models.swift
//  Olympsis
//
//  Created by Joel Joseph on 7/15/23.
//

import Foundation

struct Toast: Equatable {
    var style: ToastStyle
    var actor: String?
    var title: String
    var message: String
    var duration: Double = 3
    var width: Double = SCREEN_WIDTH
}

enum ToastStyle: String {
    case error = "error"
    case warning = "warning"
    case success = "success"
    case info = "info"
    case newPost = "new_post"
    case message = "message"
    case newEvent = "new_event"
    case eventStatus = "event_status"
}
