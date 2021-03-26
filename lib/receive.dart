import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class Receive {
  StreamSubscription<RangingResult> _streamRanging;
  StreamSubscription<MonitoringResult> _streamMonitoring;

  Future<void> receiveOn() async {
    print("ReceiveOn");

    try {
      // if you want to manage manual checking about the required permissions
      //必要な権限に関する手動チェックを管理する場合
      await flutterBeacon.initializeScanning;

      // or if you want to include automatic checking permission
      //または自動チェック権限を含める場合
      await flutterBeacon.initializeAndCheckScanning;
    } on PlatformException catch (e) {
      // library failed to initialize, check code and message
      //ライブラリの初期化に失敗しました。コードとメッセージを確認してください
    }
    final regions = <Region>[];

    if (Platform.isIOS) {
      print("isIOS");
      // iOS platform, at least set identifier and proximityUUID for region scanning
      // iOSプラットフォーム、少なくともリージョンスキャン用の識別子とproximityUUIDを設定します
      regions.add(Region(
          identifier: 'Apple Airlocate',
          proximityUUID: "00008030-00054D821AFB802E"));
    } else {
      print("isAndroid");
      // android platform, it can ranging out of beacon that filter all of Proximity UUID
      // Androidプラットフォーム、すべてのプロキシミティUUIDをフィルタリングするビーコンの範囲外にすることができます
      regions.add(Region(identifier: 'com.beacon'));
    }
    print("regions");
    print(regions);

    // to start ranging beacons
    //ビーコンの測距を開始します
    _streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
      print("RangingResult");
      // result contains a region and list of beacons found
      // list can be empty if no matching beacons were found in range
      // 結果には、見つかったビーコンの地域とリストが含まれます
      // 一致するビーコンが範囲内に見つからなかった場合、リストは空になる可能性があります
    });

    // to start monitoring beacons
    _streamMonitoring =
        flutterBeacon.monitoring(regions).listen((MonitoringResult result) {
      print("MonitoringResult");
      // result contains a region, event type and event state
      // 結果には、地域、イベントタイプ、イベント状態が含まれます
    });
  }

  void receiveOff() {
    print("ReceiveOff");
    // to stop ranging beacons
    //ビーコンのレンジングを停止します
    _streamRanging.cancel();
    // to stop monitoring beacons
    //ビーコンの監視を停止します
    _streamMonitoring.cancel();
  }
}
