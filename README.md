# 概要
MVPで実装しました。

その他に、セルのアニメーションや、通信中のネットワークインジケータ表示（ステータスバー）、検索結果が０件だった場合の表示など、UXにこだわりを持って作っています。

# 導入
プロジェクトルートにて`pod install`を実行

以上！

# その他ツール等
下記に選定理由等を記載します。

|  ライブラリ  |  選定理由  |
| ---- | ---- |
|  CocoaPods  |  使い慣れているから（小並感）  |
|  SwiftLint  |  コーディング規約を統一する為  |
|  Alamofire  |  通信系が楽に書けるから  |
|  R.swift  |  ハードコーディングを減らす為<br>SwiftGenと悩んだが、アプリの規模が小さい為、導入が簡単なR.swiftを選択  |
|  Kingfisher  |  URLSessionが面倒で、[この記事](https://qiita.com/H_Crane/items/422811dfc18ae919f8a4#%E6%AF%94%E8%BC%831-%E6%A9%9F%E8%83%BD)より個人的に良いと思ったものを選定  |
|  ViewAnimator  |  洒落乙アニメーションが簡単！  |

# 洒落乙アニメーションデモ
![animation](https://user-images.githubusercontent.com/63180526/88397777-68649c00-cdff-11ea-91f3-dff8457ea758.gif)
