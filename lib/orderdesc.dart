import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cartlist.dart';
import 'config.dart';
import 'usersform.dart';

class Orderdesc extends StatefulWidget {
  final int id;
  final String img;
  final String title;
  final double price;
  final String desc;

  const Orderdesc(this.id, this.img, this.title, this.price, this.desc,
      {super.key});

  @override
  State<Orderdesc> createState() => _OrderdescState();
}

class _OrderdescState extends State<Orderdesc> {
  final Cartlist putlist = Get.put(Cartlist());
  Cartlist findcartlist = Get.find<Cartlist>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (BuildContext context) => FloatingActionButton.small(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          child: Icon(Icons.shopping_cart_checkout_outlined),
        ),
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                      Text('Total Items In Cart: ${findcartlist.items.length}'),
                ),
              ),
            ),
            const Center(
                child: Icon(
              Icons.shopping_cart_checkout_rounded,
              size: 80,
            )),
            const Divider(),
            findcartlist.items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: findcartlist.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Card(
                              child: ListTile(
                                  leading: Expanded(
                                    child: CircleAvatar(
                                      backgroundColor:
                                          const Color.fromARGB(44, 42, 39, 39),
                                      child: Image.network(
                                        siteimgspathlink +
                                            findcartlist.items[index].img
                                                .toString(),
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.low,
                                      ),
                                    ),
                                  ),
                                  title: Text(findcartlist.items[index].title
                                      .toString()),
                                  subtitle: Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                            'Rs. ${findcartlist.items[index].price}'),
                                        Center(
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      putlist.removequentity(
                                                          index);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      Icons.remove_circle)),
                                              Center(
                                                child: Card(
                                                    child: Text(findcartlist
                                                        .quntity[0]
                                                        .toString())),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      putlist
                                                          .addquentity(index);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      Icons.add_circle)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Expanded(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {});
                                          putlist.removeall();
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                  )),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : const Text('No Items In cart'),
            const Spacer(),
            const Divider(),
            Card(
              child: ListTile(
                title: const Text('Total Price'),
                trailing: findcartlist.items.isNotEmpty
                    ? Text(
                        '${findcartlist.items[0].price! * findcartlist.quntity[0]}')
                    : const Text('0'),
              ),
            ),
            Card(
              child: ElevatedButton.icon(
                  onPressed: findcartlist.quntity[0] < 1
                      ? null
                      : () {
                          Get.to(const Putcartform());
                        },
                  icon: const Icon(Icons.check_circle_rounded),
                  label: const Text('Check Out..')),
            )
          ],
        ),
      ),
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 3 / 8,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Image.network(
                siteimgspathlink + widget.img,
                width: MediaQuery.of(context).size.width * 0.4 / 1,
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(widget.title.toString()),
              subtitle: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(widget.desc.toString()),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {});
                  putlist.addtolist(
                    widget.id,
                    widget.img,
                    widget.title,
                    widget.price,
                    widget.desc,
                  );
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
                },
                icon: Icon(Icons.shopping_cart_checkout_outlined),
              ),
            ),
          ),
          const Spacer(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Price:'),
                Text('${widget.price}'),
                ElevatedButton.icon(
                    onPressed: () {
                      setState(() {});
                      putlist.addtolist(
                        widget.id,
                        widget.img,
                        widget.title,
                        widget.price,
                        widget.desc,
                      );
                      Get.snackbar('Order Submitted', 'Thank You',
                          icon: const Icon(Icons.check),
                          shouldIconPulse: true,
                          mainButton: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.undo_outlined),
                            label: const Text('Undo'),
                          ),
                          duration: const Duration(seconds: 1),
                          snackPosition: SnackPosition.BOTTOM);
                    },
                    icon: const Icon(Icons.shopping_cart_checkout_outlined),
                    label: const Text('Add To Cart')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
