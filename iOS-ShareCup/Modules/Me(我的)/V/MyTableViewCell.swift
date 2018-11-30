//
//  MyTableViewCell.swift
//  Trail
//
//  Created by kys-2 on 2018/10/5.
//  Copyright © 2018年 kys-2. All rights reserved.
//

import UIKit
import Photos
class MyTableViewCell:UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource{
    var collectionView:UICollectionView!
    
    
    var assetsFetchResults:PHFetchResult<AnyObject>!
    var imageManager:PHCachingImageManager!
    var assetGridThumbnailSize:CGSize!
    var images:NSMutableArray!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpUI() {
        
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width,height:165), collectionViewLayout: flowLayout)
        //设置item的size
        flowLayout.itemSize = CGSize.init(width:100,height:165)
//        设置PHP缩略图大小
        assetGridThumbnailSize = CGSize(width: 100, height: 165)
        //设置item的排列方式
        flowLayout.scrollDirection = .horizontal
        //设置item的四边边距
        flowLayout.sectionInset = UIEdgeInsets(top: 0,left: UIScreen.main.bounds.width*1/20, bottom:0, right: UIScreen.main.bounds.width*1/20)
        //列间距
        flowLayout.minimumLineSpacing = 20
        
        collectionView.backgroundColor = UIColor.clear
        
        //设置水平滚动是否滚到item的最右边
        // collectionView.alwaysBounceHorizontal = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier:"MyCollectionViewCell")
        self.addSubview(collectionView)
        
        self.fetchAllUserCreatedAlbum()
        
        
    }
    func fetchAllUserCreatedAlbum() {
        
        //获取自定义的相册
        let topLevelUserCollections:PHFetchResult = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        //topLevelUserCollections中保存的是各个用户创建的相册对应的PHAssetCollection
//        print("用户创建\(topLevelUserCollections.count)个")
        
        for i in 0..<topLevelUserCollections.count {
            //获取一个相册
            let collection = topLevelUserCollections[i]
            if collection.isKind(of: PHAssetCollection.classForCoder()) {
                //赋值
                let assetCollection = collection
                
                //从每一个智能相册中获取到的PHFetchResult中包含的才是真正的资源(PHAsset)
//                let assetsFetchResults:PHFetchResult = PHAsset.fetchAssets(in: assetCollection as! PHAssetCollection, options: nil)
                
//                print("\(assetCollection.localizedTitle)相册，共有照片数:\(assetsFetchResults.count)")
                
                //遍历自定义相册，存储相片在自定义相册
                if assetCollection.localizedTitle == "iOS-ShareCup"
                {
//                    //则获取所有资源
//                    let allPhotosOptions = PHFetchOptions()
//                    //按照创建时间倒序排列
//                    allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",ascending:false)]
//                    //只获取图片
//
//                    allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
//                    //assetsFetchResults = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: allPhotosOptions)
//                    let fetchResults:PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: allPhotosOptions)
                    
                    let assetsFetchResults:PHFetchResult = PHAsset.fetchAssets(in: assetCollection as! PHAssetCollection, options: nil)
                    self.assetsFetchResults = assetsFetchResults as? PHFetchResult<AnyObject>
//                    self.assetsFetchResults = fetchResults as? PHFetchResult <AnyObject>
                    //    debugPrint("get all img",fetchResults)
                    // 初始化和重置缓存
                    self.imageManager = PHCachingImageManager()
                    self.resetCachedAssets()
                }
                
//                assetsFetchResults.enumerateObjects({ (asset, i, nil) in
//                    print("\(asset)")
//                })
            }
        }
    
        
        
     
        
    }
    func resetCachedAssets(){
        self.imageManager.stopCachingImagesForAllAssets()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetsFetchResults!.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celle  = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell",
                                                        for: indexPath) as! MyCollectionViewCell
        
//        celle.tableimage.image = UIImage(named: images[indexPath.row])
        

        let asset = self.assetsFetchResults?[indexPath.row] as! PHAsset
        self.imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: PHImageContentMode.aspectFill, options: nil) { (img, info) in
            celle.tableimage.image = img
//            self.images.add(img as Any)
            

            //                    发送通知
//            let notificationName = Notification.Name(rawValue: "imageArray")
//            NotificationCenter.default.post(name: notificationName, object: self,
//                                            userInfo: ["images":self.assetsFetchResults])
        }
        
        
        return celle
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    
}
