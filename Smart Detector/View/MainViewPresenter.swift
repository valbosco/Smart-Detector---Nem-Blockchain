//
//  MainViewPresenter.swift


import Foundation
import UIKit

class MainViewPresenter {
    private var model = MainModel(liked: false)
    var likeButtonTitle: String {
        return model.liked ? "Dislike" : "Like"
    }
    var viewColor: UIColor {
        return model.liked ? UIColor.red.withAlphaComponent(0.5) : .clear
    }

    func updateLike() {
        model.liked = !model.liked
    }
}

struct MainModel {
    var liked: Bool
}
