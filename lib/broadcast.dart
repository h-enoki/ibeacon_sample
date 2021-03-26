import 'package:beacon_broadcast/beacon_broadcast.dart';

class Broadcast {
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();
  Future<void> broadcastOn() async {
    print("BroadcastOn");
    bool isAdvertising = await beaconBroadcast.isAdvertising();
    BeaconStatus transmissionSupportStatus =
        await beaconBroadcast.checkTransmissionSupported();

    if (!isAdvertising &&
        (transmissionSupportStatus == BeaconStatus.supported)) {
      print("*****");
      await beaconBroadcast
          .setUUID("00008030-00054D821AFB802E")
          .setMajorId(1)
          .setMinorId(100)
          .setIdentifier('com.beacon.sample')
          .start();
    }
  }

  void broadcastOff() {
    print("BroadcastOff");
    // beaconBroadcast.stop();
  }
}
