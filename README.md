# 概要
MVP＋Clean Architectureで実装しました。

他のブランチにMVC, MVVMのパターンで実装。

その他に、セルのアニメーションや、通信中のネットワークインジケータ表示（ステータスバー）、検索結果が０件だった場合の表示など、UXにこだわりを持って作っています。

# 導入
プロジェクトルートにて`pod install`を実行

# その他ツール等
下記に選定理由等を記載します。

|  ライブラリ  |  選定理由  |
| ---- | ---- |
|  CocoaPods  |  使い慣れているから  |
|  SwiftLint  |  コーディング規約を統一する為  |
|  Alamofire  |  通信系が楽に書けるから  |
|  R.swift  |  ハードコーディングを減らす為<br>SwiftGenと悩んだが、アプリの規模が小さい為、導入が簡単なR.swiftを選択  |
|  Kingfisher  |  画像ロードを簡単にするため  |
|  ViewAnimator  |  洒落乙アニメーションが簡単！  |
|  RxSwift  | ＊MVVMパターンのみ  |
|  RxCocoa  | ＊MVVMパターンのみ  |
|  Unio  |  MVの入出力を非常にわかりやすくするフレームワーク  ＊MVVMパターンのみ　|

# 洒落乙アニメーションデモ
![animation](https://user-images.githubusercontent.com/63180526/88397777-68649c00-cdff-11ea-91f3-dff8457ea758.gif)
