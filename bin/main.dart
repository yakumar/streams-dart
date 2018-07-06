import 'dart:async';

main(List<String> arguments) {
  final controller = new StreamController();

  final order = new Order('chocolate');

  final baker =
      new StreamTransformer.fromHandlers(handleData: (orderType, inpu) {
    if (orderType == 'chocolate') {
      inpu.add(new Cake());
    } else {
      inpu.addError('I cant bake that thing!!');
    }
  });
  controller.sink.add(order);

  controller.stream
      .map((order) {
        return order.type;
      })
      .transform(baker)
      .listen((cake) => print('here is ur cake ${cake}'),
          onError: (err) => print('$err'));
}

class Cake {}

class Order {
  String type;

  Order(this.type);
}
