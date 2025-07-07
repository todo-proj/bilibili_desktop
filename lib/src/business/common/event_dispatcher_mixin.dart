import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension EventDispatcherNotifierExtension on Notifier {
  static final Map<Notifier, _InternalEventDispatcher> _dispatchers = {};

  _InternalEventDispatcher get _eventDispatcher {
    if (!_dispatchers.containsKey(this)) {
      final dispatcher = _InternalEventDispatcher();
      _dispatchers[this] = dispatcher;
      // 当 Provider 销毁时，清理 static Map 中的引用
      ref.onDispose(() {
        dispatcher.dispose();
        _dispatchers.remove(this);
      });
    }
    return _dispatchers[this]!;
  }

  Stream<T> getStream<T>() => _eventDispatcher.getStream<T>();
  void emitToStream<T>(T value) => _eventDispatcher.emitToStream<T>(value);
}

extension EventDispatcherExtension on AutoDisposeNotifier {
  static final Map<AutoDisposeNotifier, _InternalEventDispatcher> _dispatchers = {};

  _InternalEventDispatcher get _eventDispatcher {
    if (!_dispatchers.containsKey(this)) {
      final dispatcher = _InternalEventDispatcher();
      _dispatchers[this] = dispatcher;
      // 当 Provider 销毁时，清理 static Map 中的引用
      ref.onDispose(() {
        dispatcher.dispose();
        _dispatchers.remove(this);
      });
    }
    return _dispatchers[this]!;
  }

  Stream<T> getStream<T>() => _eventDispatcher.getStream<T>();
  void emitToStream<T>(T value) => _eventDispatcher.emitToStream<T>(value);
}

// 内部事件分发器（仅供扩展函数使用）
class _InternalEventDispatcher {
  final Map<Type, StreamController> _controllers = {};

  void dispose() {
    for (final controller in _controllers.values) {
      controller.close();
    }
    _controllers.clear();
  }

  Stream<T> getStream<T>() {
    final controller = _controllers[T] as StreamController<T>?;
    if (controller != null) {
      return controller.stream;
    }

    final newController = StreamController<T>.broadcast();
    _controllers[T] = newController;
    return newController.stream;
  }

  void emitToStream<T>(T value) {
    final controller = _controllers[T] as StreamController<T>?;
    if (controller != null && !controller.isClosed) {
      controller.add(value);
    } else {
      final newController = StreamController<T>.broadcast();
      _controllers[T] = newController;
      newController.add(value);
    }
  }
}