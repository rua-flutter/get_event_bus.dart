import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_event_bus/get_event_bus.dart';

class EventA {
  String text;

  EventA(this.text);
}

class EventB {
  String text;

  EventB(this.text);
}

class EventWithMap {
  Map myMap;

  EventWithMap(this.myMap);
}

main() {
  group('EventBus', () {
    test('Get mounted', () {
      expect(Get.bus, isA<EventBus>());
    });

    test('Destroy', () async {
      // given
      int calledCount = 0;
      EventBus eventBus = EventBus(sync: true);
      eventBus.once<EventA>((_) => calledCount++);
      eventBus.once<dynamic>((_) => calledCount++);

      // when
      await eventBus.destroy();
      try {
        eventBus.fire(EventA('a1'));
      } catch (e) {
        expect(e, isA<StateError>());
      }
    });

    test('Fire one event', () {
      // given
      int calledCount = 0;
      EventBus eventBus = EventBus(sync: true);
      eventBus.on<EventA>((_) => calledCount++);

      // when
      eventBus.fire(EventA('a1'));
      eventBus.destroy();

      // then
      expect(calledCount, 1);
    });

    test('Listen event once', () {
      // given
      int calledCount = 0;
      int calledCountDynamic = 0;
      EventBus eventBus = EventBus(sync: true);
      eventBus.once<EventA>((_) => calledCount++);
      eventBus.once<dynamic>((_) => calledCountDynamic++);

      // when
      eventBus.fire(EventA('a1'));
      eventBus.fire(EventA('a1'));
      eventBus.fire(EventB('a1'));
      eventBus.destroy();

      // then
      expect(calledCount, 1);
      expect(calledCountDynamic, 1);
    });

    test('Fire two events of same type', () {
      // given
      int calledCount = 0;
      EventBus eventBus = EventBus(sync: true);
      eventBus.on<EventA>((_) => calledCount++);

      // when
      eventBus.fire(EventA('a1'));
      eventBus.fire(EventA('a2'));
      eventBus.destroy();

      // then
      expect(calledCount, 2);
    });

    test('Fire events of different type', () {
      // given
      int calledCountA = 0;
      int calledCountB = 0;
      EventBus eventBus = EventBus(sync: true);
      eventBus.on<EventA>((_) => calledCountA++);
      eventBus.on<EventB>((_) => calledCountB++);

      // when
      eventBus.fire(EventA('a1'));
      eventBus.fire(EventB('b1'));
      eventBus.destroy();

      // then
      expect(calledCountA, 1);
      expect(calledCountB, 1);
    });

    test('Fire events of different type, receive all types', () {
      // given
      int calledCount = 0;
      EventBus eventBus = EventBus(sync: true);
      eventBus.on<dynamic>((_) => calledCount++);

      // when
      eventBus.fire(EventA('a1'));
      eventBus.fire(EventB('b1'));
      eventBus.fire(EventB('b2'));
      eventBus.destroy();

      // then
      expect(calledCount, 3);
    });

    test('Fire event with a map type', () {
      // given
      int calledCount = 0;
      EventBus eventBus = EventBus(sync: true);
      eventBus.on<EventWithMap>((_) => calledCount++);

      // when
      eventBus.fire(EventWithMap({'a': 'test'}));
      eventBus.destroy();

      // then
      expect(calledCount, 1);
    });
  });
}
