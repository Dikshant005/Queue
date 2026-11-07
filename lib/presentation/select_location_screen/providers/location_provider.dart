import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/text_constants.dart';

class LocationNotifier extends Notifier<String> {
  @override
  String build() => TextConstants.defaultLocation;

  void setLocation(String newLocation) {
    state = newLocation;
  }
}

final locationProvider = NotifierProvider<LocationNotifier, String>(
  LocationNotifier.new,
);

final popularLocationsProvider = Provider<List<String>>((ref) {
  return const [
    TextConstants.defaultLocation,
    TextConstants.sampleLocationDehradun,
    TextConstants.sampleLocationDelhi,
    TextConstants.sampleLocationNoida,
  ];
});

