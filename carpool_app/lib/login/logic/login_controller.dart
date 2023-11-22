import 'package:carpool_app/login/state/login_state.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class LoginController extends GetxController {
  final LoginState state = LoginState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void toggleObsecureText() {
    state.obscureText.value = !state.obscureText.value;
  }

  Future<dynamic> getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) _serviceEnabled = await location.requestService();

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    _locationData = await location.getLocation();
    return _locationData;
  }
}
