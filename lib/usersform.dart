import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cartlist.dart';
import 'config.dart';

class Putcartform extends StatefulWidget {
  const Putcartform({super.key});

  @override
  State<Putcartform> createState() => _PutcartformState();
}

class _PutcartformState extends State<Putcartform> {
  final formvalidation = GlobalKey<FormState>();
  dynamic name = TextEditingController();
  dynamic phone = TextEditingController();
  dynamic email = TextEditingController();
  dynamic address = TextEditingController();
  dynamic country = TextEditingController();
  dynamic city = TextEditingController();
  dynamic postalcode = TextEditingController();
  dynamic descr = TextEditingController();
  final Cartlist putlist = Get.put(Cartlist());
  final Cartlist findcartlist = Get.find<Cartlist>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Form'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: ExpansionTile(
                leading: Image.network(
                    siteimgspathlink + findcartlist.items[0].img.toString()),
                title: Text('${findcartlist.items[0].title}'),
                subtitle: const Text('Veiw details'),
                children: [
                  Image.network(
                      siteimgspathlink + findcartlist.items[0].img.toString()),
                  Text(
                    '${findcartlist.items[0].title}',
                    style: const TextStyle(fontSize: 25),
                  ),
                  Text('${findcartlist.items[0].desc}'),
                  Card(
                      child: ListTile(
                    title: const Text('total items'),
                    trailing: Text('${findcartlist.quntity[0]}'),
                  )),
                  Card(
                      child: ListTile(
                    title: const Text('total Price'),
                    trailing: Text('${findcartlist.quntity[1]}'),
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Fill All Details',
              style: TextStyle(fontSize: 30),
            ),
            Form(
              key: formvalidation,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                        hintText: 'Enter Name',
                        label: Text('Name'),
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'plz fill Name fields';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: phone,
                      decoration:
                          const InputDecoration(hintText: 'Enter Phone'),
                      validator: (value) {
                        if (value == '') {
                          return 'plz fill Phone No fields';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: email,
                      decoration:
                          const InputDecoration(hintText: 'Enter Email'),
                      validator: (value) {
                        if (value == '') {
                          return 'plz fill Email fields';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 2.5 / 4,
                            child: Expanded(
                              child: TextFormField(
                                controller: address,
                                decoration: const InputDecoration(
                                    hintText: 'Enter Address'),
                                validator: (value) {
                                  if (value == '') {
                                    return 'plz fill Address fields';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 1.2 / 4,
                            child: Expanded(
                              child: TextFormField(
                                controller: country,
                                decoration: const InputDecoration(
                                    hintText: 'Country Name'),
                                validator: (value) {
                                  if (value == '') {
                                    return 'plz fill Country fields';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 1.9 / 4,
                            child: Expanded(
                              child: TextFormField(
                                controller: city,
                                decoration: const InputDecoration(
                                    hintText: 'Enter City'),
                                validator: (value) {
                                  if (value == '') {
                                    return 'plz fill City fields';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 1.9 / 4,
                            child: Expanded(
                              child: TextFormField(
                                controller: postalcode,
                                decoration: const InputDecoration(
                                    hintText: 'Postal Code Name'),
                                validator: (value) {
                                  if (value == '') {
                                    return 'plz fill Postal Code fields';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: descr,
                      decoration: const InputDecoration(
                          hintText: 'Write Some Thing About Shipping Products'),
                    ),
                    CheckboxListTile(
                      value: true,
                      onChanged: (c) {},
                      title: Text('Cash On Delivery'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (formvalidation.currentState!.validate()) {
                          putlist.senddata(
                              name.toString(),
                              phone.toString(),
                              email.toString(),
                              address.toString(),
                              country.toString(),
                              city.toString(),
                              postalcode.toString(),
                              descr.toString());
                          if (findcartlist.vsenderresp == 1) {
                            Get.snackbar('Order Submitted', 'Thank You',
                                icon: const Icon(Icons.check),
                                shouldIconPulse: true,
                                mainButton: TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.undo_outlined),
                                  label: const Text('Undo'),
                                ),
                                duration: const Duration(seconds: 2),
                                snackPosition: SnackPosition.BOTTOM);
                          } else {
                            Get.snackbar('try Again', 'Some Thing Went Wrong',
                                icon: const Icon(Icons.check),
                                shouldIconPulse: true,
                                mainButton: TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.history),
                                  label: const Text('Again Try'),
                                ),
                                duration: const Duration(seconds: 2),
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        }
                      },
                      icon: const Icon(Icons.price_check),
                      label: const Text('Confirm Order'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
