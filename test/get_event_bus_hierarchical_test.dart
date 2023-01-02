import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_event_bus/get_event_bus.dart';

class EventA extends SuperEvent {
  String text;

  EventA(this.text);
}

class EventB extends SuperEvent {
  String text;

  EventB(this.text);
}

class SuperEvent {}

main() {
  group('[EventBus] (hierarchical)', () {
    test('Listen on same class', () {
      // given
      int calledCount = 0;
      EventBus eventBus = EventBus(sync: true);
      eventBus.on<EventA>((_) => calledCount++);

      // when
      eventBus.fire(EventA('a1'));
      eventBus.fire(EventB('b1'));
      eventBus.destroy();

      // then
      expect(calledCount, 1);
    });

    test('Listen on superclass', () {
      // given
      int calledCount = 0;
      EventBus eventBus = EventBus(sync: true);
      eventBus.on<SuperEvent>((_) => calledCount++);

      // when
      eventBus.fire(EventA('a1'));
      eventBus.fire(EventB('b1'));
      eventBus.destroy();

      // then
      expect(calledCount, 2);
    });
  });
}
