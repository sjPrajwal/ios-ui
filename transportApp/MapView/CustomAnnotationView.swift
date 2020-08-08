//
//  CustomAnnotationView.swift
//  transportApp
//
//  Created by Mac HD on 08/08/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import Foundation
import MapKit
class CustomAnnotationView: MKAnnotationView {
    private let annotationFrame = CGRect(x: 0, y: 0, width: 40, height: 40)
    
    private let occupancyProgressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = UIColor.lightGray
        progressView.tintColor = UIColor.green
        return progressView
    }()
    
    private let incidentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cancel")
        imageView.isHidden = true
        return imageView
    }()
    
    public var progress: Float = 0.0 {
        didSet {
            changeTintColor(float: progress)
            occupancyProgressView.setProgress(progress, animated: true)
        }
    }
    
    public var isIncidentOccured: Bool = false {
        didSet {
            occupancyProgressView.isHidden = isIncidentOccured
            incidentImageView.isHidden = !isIncidentOccured
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        occupancyProgressView.frame = annotationFrame.offsetBy(dx: 11, dy: 0)
        incidentImageView.frame = CGRect(x: annotationFrame.maxX - 20, y: -10, width: 20, height: 20)
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(occupancyProgressView)
        self.addSubview(incidentImageView)
        self.image = UIImage(named: "busIcon")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented!")
    }
    
    func changeTintColor(float: Float) {
        if float >= 0.9 {
            occupancyProgressView.tintColor = .red
        } else if float < 0.9 && float >= 0.8 {
            occupancyProgressView.tintColor = .orange
        } else if float < 0.8 && float >= 0.6 {
            occupancyProgressView.tintColor = .blue
        } else {
            occupancyProgressView.tintColor = .green
        }
    }
    
    
}

