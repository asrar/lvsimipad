//
//
//
//
// class Overseer {
//   Map<dynamic, dynamic> repository = {};
//
//   static int HR = 0;
//   static String Pressure = '';
//   static int SPO2=0;
//   static int ABP_low=0;
//   static int ABP_high=0;
//   static int RESP=0;
//   static int HR_speedTime = 200;
//
//
//
//
//   Overseer() {
//
//
//
// // register managers
//   }
//
//   static printWrapped(String text) {
//     final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
//     pattern.allMatches(text).forEach((match) => print(match.group(0)));
//   }
//
//   // register the manager to this overseer to store in repository
//   register(name, object) {
//     repository[name] = object;
//   }
//
//   // get the required manager from overseer when needed
//   fetch(name) {
//     return repository[name];
//   }
// }
import 'dart:async';

class Overseer {
  Map<dynamic, dynamic> repository = {};

  static int HR = 0;
  static String Pressure = '';
  static int SPO2 = 0;
  static int ABP_low = 0;
  static int ABP_high = 0;
  static int RESP = 0;
  static int HR_speedTime = 200;

  // Create a StreamController for heart rate updates
  final _heartRateController = StreamController<dynamic>.broadcast();

  // Expose a getter property for the heart rate stream
  Stream<dynamic> get heartRateStream => _heartRateController.stream;

  Overseer() {
    // Register managers
  }

  static printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
    }

  // Register the manager to this overseer to store in repository
  register(name, object) {
    repository[name] = object;
  }

  // Get the required manager from overseer when needed
  fetch(name) {
    return repository[name];
  }

  // Update the heart rate and notify listeners
  void updateHeartRate(int newHeartRate) {
    HR = newHeartRate;
    _heartRateController.add(newHeartRate);
  }

  // Dispose of the StreamController when it's no longer needed
  void dispose() {
    _heartRateController.close();
  }
}
