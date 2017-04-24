//
//  ViewController.swift
//  TicTacToe-ViacomChallenge
//
//  Created by Arvin San Miguel on 4/24/17.
//  Copyright © 2017 Appr1sing Studios. All rights reserved.
//

import UIKit

class TicTacToeViewController: UIViewController {
    
    var collectionView : UICollectionView!
    var player1 = [Int]()
    var player2 = [Int]()
    
    var switchPlayer : Bool = false {
        didSet {
            if switchPlayer {
                gameWinner(player1, winner: "Crosses")
            } else {
                gameWinner(player2, winner: "Noughts")
            }
        }
    }
    
    let resetButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Play again", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(reset(_:)), for: .touchUpInside)
        return btn
    }()
    
    let label : UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.black
        lbl.textAlignment = .center
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        view.backgroundColor = UIColor.white
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TTTCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.black
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func showResetButton() {
        view.addSubview(resetButton)
        resetButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 50).isActive = true
        resetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resetButton.layer.borderWidth = 2.0
    }
    
    func showWinner(_ player: String) {
        view.addSubview(label)
        label.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -30).isActive = true
        label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.text = "\(player) wins!"
        label.font = UIFont(name: "AvenirNext-Medium", size: 15)
    }
    
    func gameWinner(_ combination: [Int], winner: String) {
        
        let winningCombo = [[0, 1, 2], [3, 4, 5],
                            [6, 7, 8], [0, 3, 6],
                            [1, 4, 7], [2, 5, 8],
                            [0, 4, 8], [2, 4, 6]]
        
        for combo in winningCombo {
            let winCombo = Set(combo)
            let playerCombo = Set(combination)
            if winCombo.isSubset(of: playerCombo) {
                collectionView.isUserInteractionEnabled = false
                showResetButton()
                showWinner(winner)
                return
            }
        }
        
        if player1.count + player2.count == 9 { showWinner("No one"); showResetButton() }
        
    }
    
    func reset(_ sender: UIButton) {
        print("reset board")
        collectionView.removeFromSuperview()
        resetButton.removeFromSuperview()
        label.removeFromSuperview()
        player2 = []
        player1 = []
        if !switchPlayer { switchPlayer = false } else { switchPlayer = true }
        setupCollectionView()
    }
    
}

extension TicTacToeViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TTTCollectionViewCell
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/3) - 3 , height: (collectionView.frame.height/3) - 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! TTTCollectionViewCell
        if !switchPlayer {
            cell.imageView.image = #imageLiteral(resourceName: "cross")
            player1.append(indexPath.row)
            switchPlayer = true
        } else {
            cell.imageView.image = #imageLiteral(resourceName: "nought")
            player2.append(indexPath.row)
            switchPlayer = false
        }
        cell.isUserInteractionEnabled = false 
    }
    
}
