import 'package:get/get.dart';
import 'package:get_event_bus/src/event_bus.dart';

/// GetEventBusExtension
///
/// mount [EventBus] to [GetInterface]
extension GetEventBusExtension on GetInterface {
  static final EventBus _bus = EventBus();

  EventBus get bus => _bus;
}
