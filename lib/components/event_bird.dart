

//订阅者回调签名
typedef EventCallback = void Function(dynamic arg);

class EventBird {
  //私有构造函数
  EventBird._internal();

  //保存单例
  static final EventBird _singleton = EventBird._internal();

  //工厂构造函数
  factory EventBird()=> _singleton;

  //保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者
  final Map<Object, List<EventCallback>> _emap = {};

  //添加订阅者
  void on(eventName, void Function(dynamic arg) f) {
    if (eventName == null) return;
    _emap[eventName] ??= [];
    _emap[eventName]?.add(f);

  }

  //移除订阅者
  void off(eventName,[EventCallback? f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _emap[eventName] = [];
    } else {
      list.remove(f);
    }
  }

  //触发事件，事件触发后该事件所有订阅者会被调用
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    //反向遍历，防止在订阅者在回调中移除自身带来的下标错位 
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

EventBird eventBird = EventBird();
