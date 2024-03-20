

import UIKit

class ViewController: UITableViewController {

    //MARK: - Property
    var pictures = [String]()
    
    //MARK: - Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "StormViewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items{
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        
        //picturesの並び替え
        pictures.sort{
            $0 < $1
        }
        
        print(pictures)
        
        //Chapter3の練習問題
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.pictureNum = indexPath.row + 1
            vc.totalNum = pictures.count
            
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //Chapter3の練習用
    @objc func shareTapped(){
        guard let appURL = URL(string: "https://apps.apple.com/jp/app/%E5%A4%A2%E3%82%92%E3%81%8B%E3%81%AA%E3%81%88%E3%82%8B1%E4%B8%87%E6%99%82%E9%96%93%E3%82%BF%E3%82%A4%E3%83%9E%E3%83%BC/id6478161695")else{
            return
        }
        let vc = UIActivityViewController(activityItems: [appURL], applicationActivities: [])
        present(vc, animated: true)
    }
    
}

