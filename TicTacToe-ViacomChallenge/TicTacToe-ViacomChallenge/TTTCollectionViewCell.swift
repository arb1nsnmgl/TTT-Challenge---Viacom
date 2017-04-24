//
//  TTTCollectionViewCell.swift
//  TicTacToe-ViacomChallenge
//
//  Created by Arvin San Miguel on 4/24/17.
//  Copyright © 2017 Appr1sing Studios. All rights reserved.
//

import UIKit

class TTTCollectionViewCell: UICollectionViewCell {
    
    let imageView : UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
}
