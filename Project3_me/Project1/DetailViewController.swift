//
//  DetailViewController.swift
//  Project1
//
//  Created by Yuta on 2024/02/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var pictureNum: Int?
    var totalNum: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
        }
        
        title = "Picture \(pictureNum!) of \(totalNum!)"
        
        /*
         Q1.ナビゲーションバーにボタンを追加する処理を記述(ボタンからはshareTappedメソッドを実行する)
         */
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    //Q2.shareTappedメソッドの実装
    @objc func shareTapped(){
        guard let image = self.imageView.image?.jpegData(compressionQuality: 0.8)else{
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        present(vc, animated: true)
    }
    //1. 共有対象のもの(解像度0.8の画面画像)を取得
    //2. 共有に必要なViewControllerを初期化
    //3. ポップオーバーを表示
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
