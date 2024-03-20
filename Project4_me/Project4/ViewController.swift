

import UIKit
//WebViewの表示に必要なフレームワークをインポート
import WebKit

class ViewController: UIViewController, WKNavigationDelegate{
    
    //web用のViewを再利用可能なようにプロパティ化する
    var webView: WKWebView!
    //プログレスビューを変数として準備
    var progressBar: UIProgressView!
    //安全に接続できるURLを保持する変数
    var websites = ["apple.com", "hackingwithswift.com"]
    
    //Webを表示できるようにViewを調整するメソッドを実装(IBを使わずに設定)
    override func loadView() {
        //Web表示用のインスタンスを準備
        webView = WKWebView()
        //デリゲートにこのクラスを指定
        webView.navigationDelegate = self
        //画面初期表示時のViewを変更
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //0: Webの初期表示設定(HWSに繋ぐ)
        //1: url準備(強制アンラップ)
        let url = URL(string: "https://\(websites[1])")!
        //1: urlの読み込み結果を画面に表示する
        webView.load(URLRequest(url: url))
        //1: スワイプでの前後移動を可能に
        webView.allowsBackForwardNavigationGestures = true
        
        //1: ナビゲーションバーの右上にOpenボタンを配置する(押下時、openTappedメソッドを呼び出す)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        //0:プログレスバーの実装
        //1:進行状況を表すビューを作成し、デフォルトのスタイルを指定する
        progressBar = UIProgressView(progressViewStyle: .bar)
        //1:サイズの調整
        progressBar.sizeToFit() //要検証
        //1:作成したビューを新しいバーボタンとして登録
        let progressButton = UIBarButtonItem(customView: progressBar)
        
        //1:ツールバーに設置する柔軟なスペースを追加
        let spacer = UIBarButtonItem(systemItem: .flexibleSpace)
        
        //1:ツールバーに設置するリロードボタンを追加
        let refleshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        //UIToolBarに進行状況ボタン、スペース、リロードボタンを配置
        toolbarItems = [progressButton, spacer, refleshButton]
        //ツールバーを表示する
        navigationController?.isToolbarHidden = false
        //Webの読み込み状況を保持する変数を監視する
        
    }
        
    //openTappedの準備
    @objc func openTapped(){
        //アクションシートのインスタンスを作成
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        //ウェブサイトリストの数だけ、アクションシートの選択肢を設ける。押されたらopenPageメソッドを実行してサイトを開く
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        //アクションシートにキャンセルボタンを設ける
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        //アクションシートの表示
        present(ac, animated: true)
    }
        
    //openPageの実装
    func openPage(action: UIAlertAction){
        //アクションシートで選択されたものを読み込んでurlを組み立てる
        let newURL = URL(string: "https://\(action.title!)")
        //組み立てたurlにアクセスする
        webView.load(URLRequest(url: newURL!))
    }
        
        
    //ナビゲーション終了後に実行されるメソッドの実装
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //ナビゲーションバーの表示を、アクセスしているサイトのドメインに変更する
        title = webView.title
    }
    
        
    //監視している値の変更をトリガーに、プログレスの値を更新するメソッドの実装
        //キーパスの確認をする
        //期待したキーパスだったら、プログレスバーに数値を入力する
        
    //ナビゲーション時のポリシーの設定を行うメソッドの実装
        //ナビゲーションアクションでのリクエストURLを取得する
        //URL内のホストの有無を調べる
        //Webサイトリストの数だけ
        //ホスト名の中にWebサイトの名前があるか確認
        //ある場合は遷移を許可してリターン
        //ない場合は遷移を不許可
}


//解答
/*
class ViewController: UIViewController, WKNavigationDelegate {

    //2. webViewは再利用可能なようにプロパティ化する
    var webView: WKWebView!
    //プログレスビューを変数として準備
    var progressView: UIProgressView!
    //安全に接続できるURLを保持する変数
    var websites = ["apple.com", "hackingwithswift.com"]

    //3. Webを表示できるようにViewを調整(IBを使わずに設定)　その際、プロトコルに準拠する
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let url = URL(string: "https://" + websites[0])!
        //4. urlの読み込み結果を画面に表示する
        webView.load(URLRequest(url: url))
        //5. スワイプで画面を前後できるようにする
        webView.allowsBackForwardNavigationGestures = true
        //6. ナビゲーションバーの右上にOpenボタンを配置する(openTappedメソッドを呼び出す)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        //7. (前提: プログレスビューを格納する変数がプロパティに存在している)進行状況を表すビューを作成し、デフォルトのスタイルを指定する
        progressView = UIProgressView(progressViewStyle: .default)
        //8. サイズの調整
        progressView.sizeToFit()
        //9. 作成したビューを新しいバーボタンとして登録
        let progressButton = UIBarButtonItem(customView: progressView)
        //10. 柔軟なスペースを追加
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //11. リロードボタンを追加
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        //12. UIToolBarに進行状況ボタン、スペース、リロードボタンを配置
        toolbarItems = [progressButton, spacer, refresh]
        //13. ツールバーを表示する
        navigationController?.isToolbarHidden = false
        //14. Webの読み込み状況を保持する変数を監視する
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
    }
    
    //openTappedの準備
    @objc func openTapped(){
        //アクションシートのインスタンスか
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        //ウェブサイトリストの数だけ、アクションシートの選択肢を設ける。押されたらopenPageメソッドを実行してサイトを開く
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        //アクションシートにキャンセルボタンを設ける
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
        //アクションシートの表示
        present(ac, animated: true)
    }
    
    //openPageの実装
    func openPage(action: UIAlertAction){
        //アクションシートで選択されたものを参考にurlを組み立てる
        let url = URL(string: "https://\(action.title!)")!
        //組み立てたurlにアクセスする
        webView.load(URLRequest(url: url))

    }
    
    //ナビゲーション終了後に実行されるメソッドの実装
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //ナビゲーションバーの表示を、アクセスしているサイトのドメインに変更する
        title = webView.title
    }

    //監視している値(Webの進行状況)の変更をトリガーに、プログレスの値を更新するメソッドの実装
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //キーパスの確認をする
        if keyPath == "estimatedProgress" {
            //期待したキーパスだったら、プログレスバーに数値を入力する
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    //ナビゲーション時のポリシーの設定を行うメソッドの実装
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //ナビゲーションアクションでのリクエストURLを取得する
        let url = navigationAction.request.url
        //URL内のホストの有無を調べる
        if let host = url?.host{
            //Webサイトリストの数だけ
            for website in websites {
                //ホスト名の中にWebサイトの名前があるか確認
                if host.contains(website){
                    //ある場合は遷移を許可してリターン
                    decisionHandler(.allow)
                    return
                }
            }
        }
        //ない場合は遷移を不許可
        decisionHandler(.cancel)
    }

}
*/

//レベル1(全ての処理コメント付き)
/*
import UIKit
//WebViewの表示に必要なフレームワークをインポート

class ViewController: UIViewController{
    
    //web用のViewを再利用可能なようにプロパティ化する
    //プログレスビューを変数として準備
    //安全に接続できるURLを保持する変数
    var websites = ["apple.com", "hackingwithswift.com"]
    
    //Webを表示できるようにViewを調整するメソッドを実装(IBを使わずに設定)
    override func loadView() {
        //Web表示用のインスタンスを準備
        //デリゲートにこのクラスを指定
        //画面初期表示時のViewを変更
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Webの初期表示設定(HWSに繋ぐ)
        //url準備
        //urlの読み込み結果を画面に表示する
        //スワイプでの前後移動を可能に
        
        
        //ナビゲーションバーの右上にOpenボタンを配置する(押下時、openTappedメソッドを呼び出す)
        
        
        //プログレスバーの実装
        //進行状況を表すビューを作成し、デフォルトのスタイルを指定する
        //サイズの調整
        //作成したビューを新しいバーボタンとして登録
        
        //ツールバーに設置する柔軟なスペースを追加
        
        //ツールバーに設置するリロードボタンを追加
        
        //UIToolBarに進行状況ボタン、スペース、リロードボタンを配置
        //ツールバーを表示する
        //Webの読み込み状況を監視する変数を作成する
        
        //openTappedの準備
        //アクションシートのインスタンスを作成
        //ウェブサイトリストの数だけ、アクションシートの選択肢を設ける。押されたらopenPageメソッドを実行してサイトを開く
        //アクションシートにキャンセルボタンを設ける
        //アクションシートの表示
        
        //openPageの実装
        //アクションシートで選択されたものを読み込んでurlを組み立てる
        //組み立てたurlにアクセスする
        
        
        //ナビゲーション終了後に実行されるメソッドの実装
        //ナビゲーションバーの表示を、アクセスしているサイトのドメインに変更する
        
        //監視している値の変更をトリガーに、プログレスの値を更新するメソッドの実装
        //キーパスの確認をする
        //期待したキーパスだったら、プログレスバーに数値を入力する
        
        //ナビゲーション時のポリシーの設定を行うメソッドの実装
        //ナビゲーションアクションでのリクエストURLを取得する
        //URL内のホストの有無を調べる
        //Webサイトリストの数だけ
        //ホスト名の中にWebサイトの名前があるか確認
        //ある場合は遷移を許可してリターン
        //ない場合は遷移を不許可
    }
}
*/
