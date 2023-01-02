# Examples

## Basic

```dart
import 'package:get/get.dart';
import 'package:get_event_bus/get_event_bus.dart';

class MyEvent {}
class MyEvent1 extends MyEvent {}
class MyEvent2 extends MyEvent {}
class MyEvent3 extends MyEvent {}

void main() {
  Get.bus.on<MyEvent>((event) => Get.log('called')); // will be called 3 times
  Get.bus.once<MyEvent>((event) => Get.log('called')); // will be called 1 times
  Get.bus.on<MyEvent1>((event) => Get.log('called')); // will be called 1 times
  Get.bus.on<MyEvent2>((event) => Get.log('called')); // will be called 0 times
  
  Get.bus.fire(MyEvent1());
  Get.bus.fire(MyEvent2());
  Get.bus.fire(MyEvent3());
}
```



## Customize

```dart
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:get_event_bus/get_event_bus.dart';

class MyEventBus extends EventBus {
  // your customized code HERE
}

void main() {
	Get.bus.streamController = PublishSubject(); // customize StreamController
  
 	GetEventBusExtension.eventBus = MyEventBus(); // customize entire mounted EventBus
}
```

