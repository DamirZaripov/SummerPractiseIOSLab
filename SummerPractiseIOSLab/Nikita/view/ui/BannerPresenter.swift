//
//  BannerPresenter.swift
//  SummerPractiseIOSLab
//
//  Created by Enoxus on 16/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import Foundation
import NotificationBannerSwift

class BannerPresenter {
    static func showTimeIncreaseBanner(time: Int) {
        let banner = NotificationBanner(title: "Верный ответ!", subtitle: "+\(time) с.", style: .success)
        banner.bannerHeight = 50.0
        banner.duration = 1.5
        banner.show(queuePosition: .front, bannerPosition: .bottom)
        banner.bannerQueue.removeAll()
    }
    
    static func showEndGameBanner(score: Int) {
        let banner = NotificationBanner(title: "Игра окончена", subtitle: "Итоговый счет: \(score)", style: .danger)
        banner.bannerHeight = 50.0
        banner.duration = 1.5
        banner.show(queuePosition: .front, bannerPosition: .bottom)
        banner.bannerQueue.removeAll()
    }
}
