//
//  ViewController.swift
//  Trail
//
//  Created by kys-2 on 2018/10/5.
//  Copyright © 2018年 kys-2. All rights reserved.
//

import UIKit
import Photos
//public var images =  ["9.jpg", "10.jpg","11.jpg",
//                      "7","8","13"]
var resultData: Array<Any> = []
var datafrist:Dictionary<String,String>!
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @objc var dic = NSDictionary()
    var tableView:UITableView!
    var cellText:String!
    var imgego:UIImageView!
    var animation : CABasicAnimation!
    var imageBack = UIImageView()
    @objc let img = UIImageView()
    var localheadIcon:UIImage?
    
    var assetsFetchResults:NSMutableArray!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        刷新
        self.tableView.reloadData()
        
////        监听
//        let notificationName = Notification.Name(rawValue: "imageArray")
//        NotificationCenter.default.addObserver(self, selector: #selector(imageArray(notification:)), name: notificationName, object: nil)
        
        
        dic = UserManager.default().getUserDict() as NSDictionary
        //缓存目录路径cache
        let cachesPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).last! as NSString
        
        let userName = dic["userName"];
        
        let filePath = String(format: "%@/%@%@", cachesPath ,userName as! CVarArg,"headIcon.png")
        
        let fileManager = FileManager.default
        if (fileManager.fileExists(atPath: filePath))
//            不为空走本地
        {
            
            let picData : NSData = fileManager.contents(atPath: filePath)! as NSData
            let image : UIImage = UIImage(data: picData as Data)!
            localheadIcon = image
//            self.hearder()
        }
        else{
//            本地为空的话
//            self.localheadIcon = UIImage(named: "头像")
//            self.hearder()
            if((localheadIcon) == nil)
            {
                //            云端为空
                POST_GET.get(String(format: "http://47.104.211.62/GlodFish/rsf_list_bucket.php?imageName=\(dic["userName"] ?? 0)"), parameters: nil, succeed: { (result) in
                    let dic = result as! Dictionary<String, String>
                    if (dic["isExit"] == "1")
                    {
                        
                        self.img .sd_setImage(with: NSURL(string: "http://phil0yzo4.bkt.clouddn.com/\(userName ?? "!")")! as URL, placeholderImage: UIImage(named: "头像"))
                    }
                    else
                    {
                        self.localheadIcon = UIImage(named: "头像")
                        self.hearder()
                    }
                }) { (error) in
                    
                }
                
            }

        }
        self.hearder()
    
    }
    
//    监听事件
//    @objc func imageArray(notification: Notification) {
//        let userInfo = notification.userInfo as! [String: AnyObject]
//        self.assetsFetchResults = userInfo["images"] as! NSMutableArray
//    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    
        
        //设置导航栏背景色
    self.navigationController?.navigationBar.barTintColor=UIColor.white
        
        tableView = UITableView(frame:CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 90))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
         tableView.backgroundColor = UIColor.clear
        //  tableView.isScrollEnabled = false
        self.view.addSubview(tableView)
        
        
        
        //json数据
        dic = UserManager.default().getUserDict() as NSDictionary
        let url = URL(string:String(format: "http://47.104.211.62/GlodFish/selectArticle.php?phone=\(dic["userName"] ?? 0)"))
        
        let request = URLRequest(url: url!)
        
        let data = try?NSURLConnection.sendSynchronousRequest(request, returning: nil)
        let dataString = String(data:data!, encoding: .utf8)
        
        let dataA =  getDictionaryFromJSONString(jsonString: dataString!)
        
        resultData = dataA["result"]! as! Array<Any>
        resultData.reverse()
        //        print(resultData)
        //        print(resultData[0])
        
        
    }
    /*func stp(){
     
     HttpTool.getRequest("http://47.104.211.62/GlodFish/selectArticle.php?phone=18732337243", success: { (result) in})
     { (error) in
     print("error")
     } }*/
    
    //numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return resultData.count}
        else {return 1}
    }
    
    /*   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     self.tableView.deselectRow(at: indexPath, animated: true)
     
     if indexPath.row == 0{
     print("点击第一行Cell")
     } }*/
    
    //cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //判断tableviewcell内容
        if indexPath.section == 0{
            let cell = MyTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
            return cell}
            
        else {
            let cellw = secondcell(style:UITableViewCellStyle.default, reuseIdentifier: "Cell")
            
            cellw.selectionStyle = .none
            
            datafrist = resultData[indexPath.row] as? Dictionary<String,String>
            
            cellw.timeLab.text = datafrist["year"]!
            cellw.labelscrollview.text = datafrist["article"]!
            cellw.timelbe.text = datafrist["time"]!
            
            let strSize = cellw.labelscrollview.text!.boundingRect(with: CGSize(width:340,height:58013), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18)], context: nil).size
            cellw.labelscrollview.frame = CGRect(x:78,y:30,width:strSize.width,height:strSize.height)
            
            return cellw
        }
    }
    
    //heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0 {
            return self.view.bounds.height*6/20
        }
            
        else{
            let cellw = secondcell(style:UITableViewCellStyle.default, reuseIdentifier: "Cell")
            
            datafrist = resultData[indexPath.row] as? Dictionary<String,String>
            cellw.labelscrollview.text = datafrist["article"]!
            
            let strSize = cellw.labelscrollview.text!.boundingRect(with: CGSize(width:340,height:58013), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18)], context: nil).size
            if strSize.height > 70{
                return  strSize.height+30}
            else {
                return 100
            }
        }
    }
    
    //heightForHeaderInSection
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50//self.view.bounds.height*1/20
    }
    
    /* func scrollViewDidScroll(_ scrollView: UIScrollView) {
     //组头高度
     let sectionHeaderHeight:CGFloat = 70
     //获取是否有默认调整的内边距
     let defaultEdgeTop:CGFloat = navigationController?.navigationBar != nil
     && self.automaticallyAdjustsScrollViewInsets ?64 : 0
     
     if scrollView.contentOffset.y >= -defaultEdgeTop &&
     scrollView.contentOffset.y <= sectionHeaderHeight - defaultEdgeTop  {
     scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
     }
     else if (scrollView.contentOffset.y>=sectionHeaderHeight - defaultEdgeTop) {
     scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight + defaultEdgeTop,
     0, 0, 0)
     }
     }*/
    
    //viewForHeaderInSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
        
        //判断组头点击事件
        if section == 1{
            
            let image = UIImageView()
            image.frame = CGRect(x: 10, y: 14, width: 20, height: 20)
            image.image = UIImage(named: "笔记")
            let lable = UILabel(frame: CGRect(x: 33, y: 0, width: self.view.bounds.width*1/2, height: 50))
            lable.textColor = UIColor.black
            lable.font = UIFont.systemFont(ofSize: 20)
            lable.text = "我的鱼文"
            //            let tlable = UILabel(frame: CGRect(x:self.view.bounds.width*15/32-20, y:0, width:self.view.bounds.width*1/2, height:50))
            //            tlable.textColor = UIColor.gray
            //            tlable.font = UIFont.systemFont(ofSize: 15)
            //            tlable.textAlignment = .right
            //            animation = CABasicAnimation(keyPath: "transform.rotation.z")
            //            animation.toValue = 2 * Double.pi //旋转角度
            //            animation.repeatCount = MAXFLOAT //旋转次数
            //            animation.duration = 10 //旋转周期
            //            animation.isCumulative = true //旋转累加角度
            
            //MARK:刷新按钮的imageview
            imgego = UIImageView(frame: CGRect(x:self.view.bounds.width*31/32-35, y: 10, width: 30, height: 30))
            imgego.image = UIImage(named: "刷新-2")
            
            view.addSubview(lable)
            view.addSubview(image)
            view.addSubview(imgego)
            
            let viewn = UIView(frame: CGRect(x: self.view.bounds.width*4/7, y: 0, width: self.view.bounds.width*3/7, height: 50))
            viewn.backgroundColor = UIColor.clear
            
            let tap = UITapGestureRecognizer(target:self, action: #selector(ticket))
            viewn.isUserInteractionEnabled=true
            viewn.addGestureRecognizer(tap)
            
            view.backgroundColor = UIColor.white
            
            view.addSubview(viewn)
            
        }
        else{
            
            let viewf = UIView(frame: CGRect(x: self.view.bounds.width*4/7, y: 0, width: self.view.bounds.width*3/7, height: 50))
            
            viewf.backgroundColor = UIColor.clear
            
//            let tap3 = UITapGestureRecognizer(target:self, action: #selector(ticket1))
//            viewf.isUserInteractionEnabled=true
//            viewf.addGestureRecognizer(tap3)
//            view.addSubview(viewf)
//            view.backgroundColor = UIColor.clear
        }
        return view
    }
    //getDictionaryFromJSONString
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    func hearder(){
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height*33/100)
        self.view.addSubview(view)
        tableView.tableHeaderView = view
        let viewh = UIView(frame: CGRect(x: 0, y: self.view.bounds.height*33/100, width: self.view.bounds.width, height: 50))
        let lables = UILabel(frame: CGRect(x: 33, y: 0, width: self.view.bounds.width*1/2, height: 50))
        lables.textColor = UIColor.black
        lables.font = UIFont.systemFont(ofSize: 20)
        lables.text = "我的收藏"
        let tlables = UILabel(frame: CGRect(x:self.view.bounds.width*15/32-15, y: 0, width: self.view.bounds.width*1/2, height: 50))
        tlables.textColor = UIColor.gray
        tlables.font = UIFont.systemFont(ofSize: 15)
        tlables.textAlignment = .right
        tlables.text = "更多"
        
        let imageo = UIImageView(frame: CGRect(x: 10, y: 15, width: 20, height: 20))
        imageo.image = UIImage(named: "收藏")
        let imgego = UIImageView(frame: CGRect(x: self.view.bounds.width-self.view.bounds.width*1/32-20, y: 10, width: 30, height: 30))
        imgego.image = UIImage(named: "go")
        viewh.addSubview(imageo)
        viewh.addSubview(lables)
        viewh.addSubview(imgego)
        viewh.addSubview(tlables)
        view.addSubview(viewh)
        
        let viewhead = UIView()
        viewhead.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height*2/11)
        viewhead.layer.cornerRadius = self.view.bounds.height*9/152
        viewhead.layer.masksToBounds = true
        view.addSubview(viewhead)
        let bfn = UILabel()
        bfn.frame = CGRect(x: self.view.bounds.width*1/3, y:self.view.bounds.height*3/130, width: self.view.bounds.width*1/2, height: 30)
        bfn.textColor = UIColor.black
        bfn.textAlignment = .left
        bfn.font = UIFont.systemFont(ofSize:20)
        
        
        
        bfn.text = dic["nickName"] as? String
        
        viewhead.addSubview(bfn)
        
        let bftw = UILabel()
        
        bftw.text = dic["signature"] as? String
        
        let new =  bftw.text!.boundingRect(with: CGSize(width:324,height:53719), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13)], context: nil).size
        bftw.frame = CGRect(x:bfn.frame.minX, y: bfn.frame.maxY/*+viewhead.frame.height*1/12*/, width: new.width, height: bfn.frame.height)
        let peging = UIImageView(frame: CGRect(x: new.width+viewhead.frame.width*1/3+5, y: bfn.frame.maxY, width: 15, height: 30))
        peging.image = UIImage(named: "")
        bftw.textColor = UIColor.gray
        bftw.textAlignment = .left
        bftw.font = UIFont.systemFont(ofSize: 13)
        
        viewhead.addSubview(peging)
        viewhead.addSubview(bftw)
        
        img.frame = CGRect(x: self.view.bounds.width*1/18, y: self.view.bounds.height*14/912, width: self.view.bounds.height*9/76, height: self.view.bounds.height*9/76)
        
    
        
        img.image = localheadIcon
        img.layer.cornerRadius = self.view.bounds.height*9/152
        img.layer.masksToBounds = true
        viewhead.addSubview(img)
        let viewt = UIView()
        viewt.frame = CGRect(x:self.view.bounds.width*1/20, y: viewhead.frame.height, width:self.view.bounds.width-self.view.bounds.width*1/10 , height:self.view.bounds.height*2/17 )
        viewt.backgroundColor = UIColor.white
        viewt.layer.cornerRadius = 15
        //viewt.backgroundColor = UIColor.clear
        viewt.layer.shadowColor = UIColor.gray.cgColor
        viewt.layer.shadowRadius = 1
        viewt.layer.shadowOpacity = 1
        viewt.layer.shadowOffset = CGSize.init(width:0.5,height:0.5)
        
        /* let maskPath = UIBezierPath.init(roundedRect:viewt.bounds, byRoundingCorners: [.topLeft,.bottomLeft], cornerRadii: CGSize(width: 15, height: 15))
         let maskLayer = CAShapeLayer.init()
         maskLayer.frame = viewt.bounds
         maskLayer.path = maskPath.cgPath
         viewt.layer.mask = maskLayer
         */
        //UIView圆角
        //viewt.layer.cornerRadius = 10
        // viewt.corner(byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], radii: 10)
        
        view.addSubview(viewt)
        
        //每一个Gesture Recognizer关联一个View，但是一个view可以关联多个Gesture Recognizer
        let fishArticleTap = UITapGestureRecognizer(target: self, action: #selector(fishArticleTapEvent))
        
        let fishArticle = UITapGestureRecognizer(target: self
            , action: #selector(fishArticleTapEvent))
        
        let fishPhotoesTap = UITapGestureRecognizer(target: self, action: #selector(fishPhotoesTapEvent))
        
        let fishPhotoes = UITapGestureRecognizer(target: self, action: #selector(fishPhotoesTapEvent))
        
        let fishAnswerTap = UITapGestureRecognizer(target: self, action: #selector(fishAnswerTapEvent))
        
        let fishAnswer = UITapGestureRecognizer(target: self, action: #selector(fishAnswerTapEvent))
        
        let s = UILabel()
        s.frame = CGRect(x: viewt.frame.width*1/10, y:viewt.frame.height/2-13, width: 60, height: 30)
        s.text = "鱼文"
        s.textColor = UIColor.gray
        s.textAlignment = .center
        s.font = UIFont.systemFont(ofSize: 20)
        s.isUserInteractionEnabled = true
        s.addGestureRecognizer(fishArticleTap)
        viewt.addSubview(s)
        let sub = UILabel()
        
//        sub.frame = CGRect(x: s.frame.minX, y: s.frame.maxY, width: 60, height: 20)
//        sub.text = "130"
//        sub.textColor = UIColor.black
//        sub.textAlignment = .center
//        sub.font = UIFont.systemFont(ofSize: 18)
//        sub.isUserInteractionEnabled = true
//        sub.addGestureRecognizer(fishArticle)
//        viewt.addSubview(sub)
        let gz = UILabel()
        gz.frame = CGRect(x: s.frame.minX+self.view.bounds.width*3/11, y:s.frame.minY , width: 60, height: 30)
        gz.text = "鱼拍"
        gz.textAlignment = .center
        gz.textColor = UIColor.gray
        gz.font = UIFont.systemFont(ofSize: 20)
        gz.isUserInteractionEnabled = true
        gz.addGestureRecognizer(fishPhotoesTap)
        viewt.addSubview(gz)
        let gzs = UILabel()
//        gzs.frame = CGRect(x: s.frame.minX+self.view.bounds.width*3/11, y:s.frame.maxY , width: 60, height: 20)
//        gzs.text = "339"
//        gzs.textAlignment = .center
//        gzs.textColor = UIColor.black
//        gzs.font = UIFont.systemFont(ofSize: 18)
//        gzs.isUserInteractionEnabled = true
//        gzs.addGestureRecognizer(fishPhotoes)
//        viewt.addSubview(gzs)
        let fs = UILabel()
        fs.frame = CGRect(x: gz.frame.minX+self.view.bounds.width*3/11, y:gz.frame.minY , width: 60, height: 30)
        fs.text = "鱼问"
        fs.textAlignment = .center
        fs.textColor = UIColor.gray
        fs.font = UIFont.systemFont(ofSize: 20)
        fs.isUserInteractionEnabled = true
        fs.addGestureRecognizer(fishAnswerTap)
        viewt.addSubview(fs)
//        let fss = UILabel()
//        fss.frame = CGRect(x: gz.frame.minX+self.view.bounds.width*3/11, y:gz.frame.maxY , width: 60, height: 20)
//        fss.text = "567"
//        fss.textAlignment = .center
//        fss.textColor = UIColor.black
//        fss.font = UIFont.systemFont(ofSize: 18)
//        fss.isUserInteractionEnabled = true
//        fss.addGestureRecognizer(fishAnswer)
//        viewt.addSubview(fss)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let notes = GFMyNotesViewController()
        
        var secondCell = secondcell()
        
        secondCell = tableView.cellForRow(at: indexPath) as! secondcell
        
        cellText = secondCell.labelscrollview.text ?? String()
        notes.str = cellText
        
        notes.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(notes, animated: true)
    }
    
    //鱼文点击事件
    @objc func fishArticleTapEvent(){
        print("点击了鱼文")
    }
    //鱼拍点击事件
    @objc func fishPhotoesTapEvent(){
        print("点击了鱼拍")
    }
    //鱼问点击事件
    @objc func fishAnswerTapEvent(){
        print("点击了鱼问")
    }
    
    //点击事件的响应 直接传递这个Php的东西在下一个类里面做判断判断是否为空选择加载那个
    @objc func ticket1(){
//        let vc = Favorite()
//        self.navigationController!.pushViewController(vc, animated:true)
        
      
        
//        let asset = self.assetsFetchResults?[indexPath.row] as! PHAsset
//        self.imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: PHImageContentMode.aspectFill, options: nil) { (img, info) in
//            celle.tableimage.image = img
        
//        }
        
        
        let VC = GFShowImageMssViewController()
        VC.imageArray = self.assetsFetchResults
        VC.titleStr = "";
        VC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(VC, animated: true)
        
//        GFShowImageMssViewController *VC = [[GFShowImageMssViewController alloc] init];
//        VC.imageArray = (NSMutableArray *)imageArray;
//        VC.titleStr =((GFShowImageModel *)_dataArray[indexPath.item]).contentTitle;
//        [self.navigationController pushViewController:VC animated:YES];
    }
    
    //MARK:点击刷新按钮不能实现刷新图片的旋转
    //刷新日志
    @objc func ticket(){
        
        
        
        UIView .animate(withDuration: 1.0) {
            
            
            let animation = CABasicAnimation(keyPath: "transform.rotation.z")
            animation.toValue = 2 * Double.pi //旋转角度
            animation.repeatCount = MAXFLOAT //旋转次数
            animation.duration = 10 //旋转周期
            animation.isCumulative = true //旋转累加角度
            animation.fromValue = 1.0
            self.imgego.layer.add(animation, forKey: nil)
            //            imgego.layer.layoutIfNeeded()
            //            imgego.layer.superlayer?.layoutIfNeeded()
        }
        
        
        
        resultData.removeAll()
        
        let request = URLRequest(url: URL(string:
            "http://47.104.211.62/GlodFish/selectArticle.php?phone=\(dic["userName"] ?? 0)")!)
        
        //        request.timeoutInterval = 30
        
        let data = try?NSURLConnection.sendSynchronousRequest(request, returning: nil)
        
        let dataString = String(bytes: data!, encoding: .utf8)
        
        let dataA = getDictionaryFromJSONString(jsonString: dataString!)
        
        resultData = dataA["result"]!as!Array<Any>
        
        resultData.reverse()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
            //            self.animation.isRemovedOnCompletion = true
            //            self.imgego.layer.removeAllAnimations()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//    //    MARK:- lifecycle
//    deinit {
//        //记得移除通知监听
//        NotificationCenter.default.removeObserver(self)
//    }
    
}



