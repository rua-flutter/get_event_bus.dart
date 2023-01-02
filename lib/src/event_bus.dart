import 'dart:async';

/// Special thanks to package https://github.com/marcojakob/dart-event-bus
///
/// Dispatches events to listeners using the Dart [Stream] API. The [EventBus]
/// enables decoupled applications. It allows objects to interact without
/// requiring to explicitly define listeners and keeping track of them.
///
/// Not all events should be broadcasted through the [EventBus] but only those of
/// general interest.
///
/// Events are normal Dart objects. By specifying a class, listeners can
/// filter events.
///
class EventBus {
  /// Underlying stream controller
  late StreamController _streamController;

  /// Event bus stream.
  Stream get stream => _streamController.stream;

  /// Creates an [EventBus].
  ///
  /// If [sync] is true, events are passed directly to the stream's listeners
  /// during a [fire] call. If false (the default), the event will be passed to
  /// the listeners at a later time, after the code creating the event has
  /// completed.
  EventBus({
    bool sync = false,
    StreamController? streamController,
  }) {
    _streamController = streamController ?? StreamController.broadcast(sync: sync);
  }

  /// Listen for specific event [T], don't forget cancel the subscription
  ///
  /// If [cancelOnError] is `true`, the subscription is automatically canceled
  /// when the first error event is delivered. The default is `false`.
  StreamSubscription<T> on<T>(void Function(T event) onData, {bool? cancelOnError}) {
    if (T == dynamic) {
      return (stream as Stream<T>).listen(
        onData,
        cancelOnError: cancelOnError,
      );
    } else {
      return stream.where((event) => event is T).cast<T>().listen(
            onData,
            cancelOnError: cancelOnError,
          );
    }
  }

  /// Listen for specific event [T] for only once
  StreamSubscription<T> once<T>(void Function(T event) onData) {
    StreamSubscription<T>? subscription;

    if (T == dynamic) {
      subscription = (stream as Stream<T>).listen(
        (event) {
          onData(event);
          subscription?.cancel();
        },
        onDone: () => subscription?.cancel(),
        cancelOnError: true,
      );
    } else {
      subscription = stream.where((event) => event is T).cast<T>().listen(
        (event) {
          onData(event);
          subscription?.cancel();
        },
        onDone: () => subscription?.cancel(),
        cancelOnError: true,
      );
    }

    return subscription;
  }

  /// Fires a new event on the event bus with the specified [event].
  void fire(event) {
    _streamController.add(event);
  }

  /// Destroy this [EventBus]. This is generally only in a testing context.
  Future<void> destroy() {
    return _streamController.close();
  }
}
