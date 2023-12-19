//
//  ViewController.swift
//  horizontal-scrollable-tabs
//
//  Created by Itsuki on 2023/12/18.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    

    @IBOutlet weak var buttonCollectionView: UICollectionView!
    
    @IBOutlet weak var leftScrollButton: UIButton!
    @IBOutlet weak var rightScrollButton: UIButton!
    
    var selectedButtonIndex = 0
    var totalButtonCount = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCollectionView.delegate = self
        buttonCollectionView.dataSource = self
        buttonCollectionView.register(UINib(nibName: TabButtonCell.tableCellIdentifier, bundle: nil), forCellWithReuseIdentifier: TabButtonCell.tableCellIdentifier)
        
        buttonCollectionView.allowsMultipleSelection = false
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let leftLayer = CAGradientLayer()
        leftLayer.colors = [
            UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor
        ]
        leftLayer.locations = [0, 1]
        leftLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        leftLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        leftLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.51, b: 0, c: 0, d: 2, tx: 0.49, ty: -1))
        leftLayer.bounds = leftScrollButton.bounds.insetBy(dx: -0.5*leftScrollButton.bounds.size.width, dy: -0.5*leftScrollButton.bounds.size.height)
        leftLayer.frame = leftScrollButton.bounds
        leftScrollButton.backgroundColor = .clear
        leftScrollButton.layer.addSublayer(leftLayer)
        
        
        let rightLayer = CAGradientLayer()
        rightLayer.colors = [
            UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        ]
        rightLayer.locations = [0, 1]
        rightLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        rightLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        rightLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.51, b: 0, c: 0, d: 2, tx: 0.49, ty: -1))
        rightLayer.bounds = rightScrollButton.bounds.insetBy(dx: -0.5*rightScrollButton.bounds.size.width, dy: -0.5*rightScrollButton.bounds.size.height)
        rightLayer.frame = rightScrollButton.bounds
        rightScrollButton.backgroundColor = .clear
        rightScrollButton.layer.addSublayer(rightLayer)
        
        
        rightScrollButton.backgroundColor = .clear
        rightScrollButton.layer.addSublayer(rightLayer)
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        buttonCollectionView.selectItem(at: IndexPath(item: selectedButtonIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        
        if buttonCollectionView.contentOffset.x <= 0 {
            leftScrollButton.isHidden = true
            rightScrollButton.isHidden = false
        } else if buttonCollectionView.contentOffset.x  >= buttonCollectionView.contentSize.width - buttonCollectionView.bounds.width - 10 {
            rightScrollButton.isHidden = true
            leftScrollButton.isHidden = false
        } else {
            rightScrollButton.isHidden = false
            leftScrollButton.isHidden = false
        }
    }
    
    
    
    
    
    @IBAction func onRightScrollButtonPressed(_ sender: Any) {
        var cellsOnScreen: [UICollectionViewCell] = []

//        let cells = buttonCollectionView.visibleCells
//        print("visible cell count: ", cells.count)
        for i in 0..<totalButtonCount {
            guard let cell = buttonCollectionView.cellForItem(at: IndexPath(item: i, section: 0))
            else {continue}
            if buttonCollectionView.bounds.contains(cell.frame) {
                cellsOnScreen.append(cell)
            }
        }
        
        if cellsOnScreen.count == 0{
            return
        }
        guard let lastCellOnScreen = cellsOnScreen.last, let lastIndex = buttonCollectionView.indexPath(for: lastCellOnScreen) else {return}
        
        print("last index: ", lastIndex)
        print("number of items: ", buttonCollectionView.numberOfItems(inSection: 0) )
        
        if lastIndex.item == buttonCollectionView.numberOfItems(inSection: 0) - 1 {
            return
        }

        buttonCollectionView.scrollToItem(at: IndexPath(item: lastIndex.item + 1, section: 0), at: .centeredHorizontally, animated: true)
             

    }
    
    @IBAction func onLeftScrollButtonPressed(_ sender: Any) {
        var cellsOnScreen: [UICollectionViewCell] = []

//        let visibleCells = buttonCollectionView.visibleCells
//        for cell in visibleCells {
//            if buttonCollectionView.bounds.contains(cell.frame) {
//                print("visible cell: ", cell )
//                cellsOnScreen.append(cell)
//            }
//        }
        
        for i in 0..<totalButtonCount {
            guard let cell = buttonCollectionView.cellForItem(at: IndexPath(item: i, section: 0))
            else {continue}
            if buttonCollectionView.bounds.contains(cell.frame) {
                cellsOnScreen.append(cell)
            }
        }
        
        if cellsOnScreen.count == 0{
            return
        }
        
        guard let firstCellOnScreen = cellsOnScreen.first, let firstIndex = buttonCollectionView.indexPath(for: firstCellOnScreen) else {return}
        
        print("last index: ", firstIndex)
        print("number of items: ", buttonCollectionView.numberOfItems(inSection: 0) )
        
        
        if firstIndex.item == 0 {
            return
        }

        buttonCollectionView.scrollToItem(at: IndexPath(item: firstIndex.item - 1, section: 0), at: .centeredHorizontally, animated: true)

        
    }

    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("start scrolling")
//        print(scrollView.contentOffset.x, scrollView.contentSize.width, scrollView.bounds.width)
        if scrollView.contentOffset.x <= 0 {
            leftScrollButton.isHidden = true
            rightScrollButton.isHidden = false
        } else if scrollView.contentOffset.x  >= scrollView.contentSize.width - scrollView.bounds.width - 10 {
            rightScrollButton.isHidden = true
            leftScrollButton.isHidden = false
        } else {
            rightScrollButton.isHidden = false
            leftScrollButton.isHidden = false
        }
    }

    
    
    
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalButtonCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabButtonCell.tableCellIdentifier, for: indexPath) as! TabButtonCell
        
        if indexPath.item == selectedButtonIndex {
            cell.isSelected = true
        } else {
            cell.isSelected = false
        }

        cell.buttonLabel.text = "\(indexPath)"
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
//        let cell = collectionView.cellForItem(at: indexPath)
//        print(collectionView.indexPathsForSelectedItems)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        selectedButtonIndex = indexPath.row

        
    }

    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        print("unselecting")
        if indexPath.item == selectedButtonIndex {
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        if indexPath.item == selectedButtonIndex {
            return false
        }
        return true
    }
    
}

