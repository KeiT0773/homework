・事前準備について
    -CloudWatchのアラームアクション
        - 事前にAWSのSimple Notification Serviceからトピックを作成する必要があります
    -RDSのパスワード
        - 事前にAWSのAWS Secrets Managerでシークレットの作成・保存が必要です
・補足
    -EC2のegress
        - 現状は一般的な全開放（0.0.0.0/0）になっていますが、組織ポリシーが変更された場合は制限を設ける修正が必要となります。