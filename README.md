# get_event_bus.dart

A minimal and scalable light-weight event bus library for get.dart


[![pub package](https://img.shields.io/pub/v/get_event_bus?style=flat)](https://pub.dev/packages/get_event_bus) ![license](https://img.shields.io/github/license/rua-flutter/get_event_bus.dart?style=flat)  [![stars](https://img.shields.io/github/stars/rua-flutter/get_event_bus.dart?style=social)](https://github.com/rua-flutter/get_event_bus.dart)



## Quick Start

No setup needed.

```dart
void main() {
  // fire a event
  Get.bus.fire(SomeClass());
  // listen a event
  Get.bus.on<SomeClass>((event) => Get.log(event), cancelOnError: true);
  // listen a event for once
  Get.bus.once<SomeClass>((event) => Get.log(event));
  // direct use of stream
  Get.bus.stream.listen((event) => Get.log(event), onData() => Get.log('onData'));
  // customized underlying stream
  Get.bus.streamController = PublishSubject();
  // independent use
  final bus = EventBus();
}
```



## Feature

- Minimal and scalable
- Support **get.dart**
- Support all platforms
- 100% test coverage



## Maintenance

- Maintaining
- Stable API



## Examples

[check out](https://github.com/rua-flutter/get_event_bus/example/example.md)
