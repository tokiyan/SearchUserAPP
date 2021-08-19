# 概要
MVP＋Clean Architectureで実装しました。

他のブランチにてMVC, MVVMの実装パターンもあり。

その他に、セルのアニメーションや、検索結果が０件だった場合の表示など、UI・UXにこだわりを持って作っています。

# 導入
プロジェクトルートにて`pod install`を実行

# その他ツール等
下記に選定理由等を記載します。

|  ライブラリ  |  選定理由  |
| ---- | ---- |
|  CocoaPods  |  使い慣れているから  |
|  SwiftLint  |  コーディング規約を統一する為  |
|  Alamofire  |  通信系が楽に書けるから  |
|  R.swift  |  ハードコーディングを減らす為  |
|  Kingfisher  |  画像ロードを簡単にするため  |
|  ViewAnimator  |  アニメーションが簡単！  |
|  RxSwift  | ＊MVVMパターンのみ  |
|  RxCocoa  | ＊MVVMパターンのみ  |
|  Unio  |  MVの入出力を非常にわかりやすくするフレームワーク  ＊MVVMパターンのみ　|

# アニメーションデモ
![animation](https://user-images.githubusercontent.com/63180526/88397777-68649c00-cdff-11ea-91f3-dff8457ea758.gif)
