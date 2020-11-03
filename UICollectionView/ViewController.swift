//
//  ViewController.swift
//  UICollectionView
//
//  Created by Steven Lipton on 10/27/20.
//

import UIKit

class ViewController: UIViewController{
    var sections = [0]
    var itemCount = 10
    var items = ["pencil","highlighter","paperclip","scissors","paintbrush","ruler","pin"]
    var dataSource: UICollectionViewDiffableDataSource<Int, String>! = nil
    var collectionView: UICollectionView! = nil
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //select a layout
        let layout = UICollectionViewCompositionalLayout.list(using: UICollectionLayoutListConfiguration(appearance: .insetGrouped))
        
        
        //set the layout
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        //allow for resizing
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //add the view
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
        //collectionView.delegate = self
        
        //Data source stuff replaces cellForRow
        //first register a cell, and include how to add data in the clusure.
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item
            content.image = UIImage(systemName:item)
            cell.contentConfiguration = content
        }
        //set the diffable data source, again in a closure.
        dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        //and put in the initial data, assigning the snapshot to the data source.
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections(sections)
        snapshot.appendItems(items)
        var moreItems = [String]()
        for newItem in 0...50{
            moreItems += ["\(newItem).circle"]
        }
        snapshot.appendItems(moreItems)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
}
