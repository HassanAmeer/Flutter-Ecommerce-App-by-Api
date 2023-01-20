import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

class Cartlist extends GetxController {
  final int? id;
  final String? img;
  final String? title;
  final double? price;
  final String? desc;

  late int vsenderresp = 0;

  Cartlist({
    this.id,
    this.img,
    this.title,
    this.price,
    this.desc,
  });

  final List<double> quntity = [0, 100];

  late List<Cartlist> items = [];
// no need to use.obs(); if late with static need
  addtolist(
    int id,
    String img,
    String title,
    double price,
    String desc,
  ) {
    items.clear();
    dynamic nestedlist = Cartlist(
      id: id,
      img: img,
      title: title,
      price: price,
      desc: desc,
    );
    items.add(nestedlist);
    quntity.clear();
    quntity.add(1);
    quntity.add(price);
  }

  removeall() {
    items.clear();
    quntity.clear();
    quntity.add(0);
    quntity.add(0);
  }

  removequentity(index) {
    double quantity = quntity[0];
    quantity--;
    if (quantity > 0) {
      quntity.clear();
      quntity.add(quantity);
      quntity.add(quantity * items[0].price!);
    }
  }

  addquentity(index) {
    double quantity = quntity[0];
    quantity++;
    quntity.clear();
    quntity.add(quantity);
    quntity.add(quantity * items[0].price!);
  }

  senddata(dynamic name, dynamic phone, dynamic email, dynamic address,
      dynamic country, dynamic city, dynamic postalcode, dynamic descr) async {
    Uri url = Uri.parse('http://localhost/appdatainsert.php');
    dynamic id = items[0].id.toString();
    dynamic title = items[0].title.toString();
    dynamic img = items[0].img.toString();
    dynamic price = items[0].price.toString();
    dynamic quntityno = quntity[0].toString();
    dynamic totalprice = quntity[1].toString();
    dynamic res = await http.post(url, body: {
      id: id,
      title: title,
      img: img,
      price: price,
      quntityno: quntityno,
      totalprice: totalprice,
      name: name,
      phone: phone,
      email: email,
      address: address,
      country: country,
      city: city,
      postalcode: postalcode,
      descr: descr
    });

    if (res.statusCode == 200) {
      try {
        print('statuse code 200000000000000000000000000000000000000');
        return vsenderresp = 1;
      } catch (e) {
        return vsenderresp = 0;
      }
    } else {
      print('status codeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee not 200');
    }
  }
}
