import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:multistore/orderdesc.dart';

import 'dart:async';
import 'cartlist.dart';
import 'config.dart';
import 'itemsjsonapi.dart';
import 'usersform.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool islight = true;
  dynamic _tabsbtnval1 = 1;
  final Cartlist putlist = Get.put(Cartlist());
  Cartlist findcartlist = Get.find<Cartlist>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi Store',
      theme: islight
          ? ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.red,
              // textTheme: const TextTheme(
              //   titleLarge: TextStyle(
              //     color: Colors.red,
              //     shadows: [
              //       Shadow(
              //         color: Colors.black,
              //         offset: Offset(1, 1),
              //       ),
              //     ],
              //   ),
              // ),
              // iconTheme: IconThemeData(color: Colors.lime),
            )
          : ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.amber,
              // textTheme: const TextTheme(
              //   titleMedium: TextStyle(
              //     color: Colors.amberAccent,
              //     shadows: [
              //       Shadow(
              //         color: Colors.black,
              //         offset: Offset(1, 1),
              //       ),
              //     ],
              //   ),
              // ),
              // iconTheme: IconThemeData(color: Colors.amber),
            ),
      home: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton.small(
                child: const Icon(Icons.add_shopping_cart),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                  setState(() {});
                });
          }),
          endDrawer: Drawer(
            child: Column(
              children: [
                Card(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          'Total Items In Cart: ${findcartlist.items.length}'),
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
                                          backgroundColor: const Color.fromARGB(
                                              44, 42, 39, 39),
                                          child: Image.network(
                                            siteimgspathlink +
                                                findcartlist.items[index].img
                                                    .toString(),
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.low,
                                          ),
                                        ),
                                      ),
                                      title: Text(findcartlist
                                          .items[index].title
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
                                                          putlist
                                                              .removequentity(
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
                                                          putlist.addquentity(
                                                              index);
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
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture:
                      const CircleAvatar(child: Icon(Icons.person)),
                  otherAccountsPictures: [
                    IconButton(
                        onPressed: () {
                          navigator?.pop(context);
                        },
                        icon: const Icon(Icons.logout_outlined))
                  ],
                  accountName: const Text('User Name'),
                  accountEmail: const Text('Name@gmail.com'),
                ),
                const SizedBox(height: 20),
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.shopping_cart_checkout_outlined,
                      shadows: [
                        Shadow(
                            color: Color.fromARGB(152, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 1)
                      ],
                    ),
                    title: const Text(
                      'View Orders',
                    ),
                    subtitle: const Text('Last Order Items'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        shadows: [
                          Shadow(
                              color: Colors.grey,
                              offset: Offset(1, 1),
                              blurRadius: 1)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                          Icons.keyboard_double_arrow_right_outlined),
                    ),
                  ),
                ),
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('Favorit'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                          Icons.keyboard_double_arrow_right_outlined),
                    ),
                  ),
                ),
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.open_in_browser),
                    title: const Text('Our Site'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                          Icons.keyboard_double_arrow_right_outlined),
                    ),
                  ),
                ),
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.category_outlined),
                    title: const Text('All Category'),
                    trailing: IconButton(
                      onPressed: () {
                        navigator?.pop(context);
                      },
                      icon: const Icon(
                          Icons.keyboard_double_arrow_right_outlined),
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text('Exit From APP'),
                    icon: const Icon(Icons.exit_to_app),
                  ),
                )
              ],
            ),
          ),
          /* Place into the body */
          appBar: AppBar(
            title: const Text('Multi Store'),
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                    setState(() {});
                  },
                  icon: const Icon(Icons.sort));
            }),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  islight = !islight;
                  setState(() {});
                },
                icon: Icon(
                  islight
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  shadows: const [
                    Shadow(
                        color: Color.fromARGB(255, 33, 33, 33),
                        offset: Offset(1, 1),
                        blurRadius: 1)
                  ],
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: islight
                      ? Colors.white
                      : const Color.fromARGB(255, 17, 17, 17),
                ),
                child: Column(
                  children: [
                    const CupertinoSearchTextField(),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 4, top: 4),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(94, 0, 0, 0),
                              offset: Offset(1, 1),
                              blurRadius: 20,
                              spreadRadius: 1)
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Expanded(
                          child: Image.asset(
                              'paper-art-shopping-online-on-smartphone-and-new-buy-sale-promotion-pink-backgroud-for-banner-market-ecommerce-free-vector.jpg'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoSlidingSegmentedControl(
                        children: const {
                          1: Text(' Cloth'),
                          2: Text(' Shoes'),
                          3: Text(' Sports'),
                          4: Text(' Electronics'),
                          5: Text(' Jewellary'),
                        },
                        groupValue: _tabsbtnval1,
                        onValueChanged: (value) {
                          _tabsbtnval1 = value;
                          setState(() {});
                        }),
                    // watch
                    _tabsbtnval1 == 1
                        ? const Vitemscloth()
                        : _tabsbtnval1 == 2
                            ? Vitemsshoes()
                            : _tabsbtnval1 == 3
                                ? Vitemsothers(catgnames: 'sports')
                                : _tabsbtnval1 == 4
                                    ? Vitemsothers(catgnames: 'electric')
                                    : Vitemsothers(catgnames: 'jewlery'),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  child: TimerWidget(),
                  // child: ListTile(
                  //   leading: const Icon(Icons.history),
                  //   title: const Text('10:02:50'),
                  //   subtitle: RichText(
                  //       text: const TextSpan(
                  //           text: 'Coupon: ',
                  //           style: TextStyle(
                  //             fontSize: 10,
                  //           ),
                  //           children: [
                  //         TextSpan(
                  //             text: 'Black Friday',
                  //             style: TextStyle(
                  //               fontSize: 17,
                  //             ))
                  //       ])),
                  //   // ignore: prefer_const_constructors
                  //   trailing: IconButton(
                  //     icon: const Icon(Icons.copy),
                  //     onPressed: (() {}),
                  //   ),
                  // ),
                ),
              ),
            ],
          )),
    );
  }
}

//mcloth
class Vitemscloth extends StatefulWidget {
  const Vitemscloth({
    Key? key,
  }) : super(key: key);

  @override
  State<Vitemscloth> createState() => _VitemsclothState();
}

class _VitemsclothState extends State<Vitemscloth> {
  allitemsapifunc() async {
    Uri url = Uri.parse('http://localhost/appdataselect.php');
    var res = await http.get(url);
    if (res.statusCode == 200) {
      try {
        var getmcloth = postsmodelFromJson(res.body);
        return getmcloth;
      } catch (e) {}
    } else {}
  }

  dynamic _malefemale = 'mcloth';

  final Cartlist callcartlist = Get.put(Cartlist());
  Cartlist findcartlist = Get.find<Cartlist>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CupertinoSlidingSegmentedControl(
                children: const {
                  'mcloth': Icon(Icons.man_outlined),
                  'fcloth': Icon(Icons.woman),
                },
                groupValue: _malefemale,
                onValueChanged: (value) {
                  setState(() {
                    _malefemale = value;
                  });
                }),
          ],
        ),
        // _malefemale != null
        //     ? Text('$_malefemale is Choose')
        //     : const Text('Nothing Choose'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 4.7 / 8,
          child: FutureBuilder(
            future: allitemsapifunc(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Postsmodel> listofp = snapshot.data
                  .where((Postsmodel) => Postsmodel.catg == _malefemale)
                  .toList();

              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: listofp.length,
                  itemBuilder: (BuildContext context, int index) {
                    int id = int.parse(listofp[index].id);
                    String img = listofp[index].img;
                    String title = listofp[index].title;
                    double price = double.parse(listofp[index].price);
                    String desc = listofp[index].desc;

                    return Card(
                        child: GridTile(
                      footer: GridTileBar(
                        backgroundColor: Colors.black45,
                        title: Text(listofp[index].title),
                        subtitle: Text(listofp[index].price),
                        trailing: IconButton(
                            onPressed: () {
                              callcartlist.addtolist(
                                  id, img, title, price, desc);
                              Get.snackbar('Order Submitted', title,
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
                            icon: const Icon(Icons.add_shopping_cart_sharp)),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Orderdesc(id, img, title, price, desc),
                            ));
                          },
                          child: Image.network(
                              siteimgspathlink + listofp[index].img)),
                    ));
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}

//mshoes
class Vitemsshoes extends StatefulWidget {
  const Vitemsshoes({
    Key? key,
  }) : super(key: key);

  @override
  State<Vitemsshoes> createState() => _VitemsshoesState();
}

class _VitemsshoesState extends State<Vitemsshoes> {
  allitemsapifunc() async {
    Uri url = Uri.parse('http://localhost/appdataselect.php');
    var res = await http.get(url);
    if (res.statusCode == 200) {
      try {
        var getmcloth = postsmodelFromJson(res.body);
        return getmcloth;
      } catch (e) {}
    } else {}
  }

  dynamic _malefemale = 'mshoes';

  final Cartlist callcartlist = Get.put(Cartlist());
  Cartlist findcartlist = Get.find<Cartlist>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CupertinoSlidingSegmentedControl(
                children: const {
                  'mshoes': Icon(Icons.man_outlined),
                  'fshoes': Icon(Icons.woman),
                },
                groupValue: _malefemale,
                onValueChanged: (value) {
                  setState(() {
                    _malefemale = value;
                  });
                }),
          ],
        ),
        // _malefemale != null
        //     ? Text('$_malefemale is Choose')
        //     : const Text('Nothing Choose'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 4.7 / 8,
          child: FutureBuilder(
            future: allitemsapifunc(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Postsmodel> listofp = snapshot.data
                  .where((Postsmodel) => Postsmodel.catg == _malefemale)
                  .toList();

              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: listofp.length,
                  itemBuilder: (BuildContext context, int index) {
                    int id = int.parse(listofp[index].id);
                    String img = listofp[index].img;
                    String title = listofp[index].title;
                    double price = double.parse(listofp[index].price);
                    String desc = listofp[index].desc;

                    return Card(
                        child: GridTile(
                      footer: GridTileBar(
                        backgroundColor: Colors.black45,
                        title: Text(listofp[index].title),
                        subtitle: Text(listofp[index].price),
                        trailing: IconButton(
                            onPressed: () {
                              callcartlist.addtolist(
                                  id, img, title, price, desc);
                              Get.snackbar('Order Submitted', title,
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
                            icon: const Icon(Icons.add_shopping_cart_sharp)),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Orderdesc(id, img, title, price, desc),
                            ));
                          },
                          child: Image.network(
                              siteimgspathlink + listofp[index].img)),
                    ));
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}

// Others

class Vitemsothers extends StatefulWidget {
  String catgname;
  Vitemsothers({
    Key? key,
    required catgnames,
  })  : catgname = catgnames,
        super(key: key);
  @override
  State<Vitemsothers> createState() => _VitemsothersState();
}

class _VitemsothersState extends State<Vitemsothers> {
  allitemsapifunc() async {
    Uri url = Uri.parse('http://localhost/appdataselect.php');
    var res = await http.get(url);
    if (res.statusCode == 200) {
      try {
        var getmcloth = postsmodelFromJson(res.body);
        return getmcloth;
      } catch (e) {}
    } else {}
  }

  final Cartlist callcartlist = Get.put(Cartlist());
  Cartlist findcartlist = Get.find<Cartlist>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 4.7 / 8,
      child: FutureBuilder(
        future: allitemsapifunc(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Postsmodel> listofp = widget.catgname == 'sports'
              ? snapshot.data
                  .where((Postsmodel) =>
                      Postsmodel.catg == widget.catgname ||
                      Postsmodel.catg == 'watch')
                  .toList()
              : snapshot.data
                  .where((Postsmodel) => Postsmodel.catg == widget.catgname)
                  .toList();

//  List<Postsmodel> listofp = snapshot.data
//               .where((Postsmodel) => Postsmodel.catg == widget.catgname)
//               .toList();

          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: listofp.length,
              itemBuilder: (BuildContext context, int index) {
                int id = int.parse(listofp[index].id);
                String img = listofp[index].img;
                String title = listofp[index].title;
                double price = double.parse(listofp[index].price);
                String desc = listofp[index].desc;

                return Card(
                    child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: Color.fromARGB(115, 33, 31, 31),
                    title: Text(listofp[index].title),
                    subtitle: Text(listofp[index].price),
                    trailing: IconButton(
                        onPressed: () {
                          callcartlist.addtolist(id, img, title, price, desc);
                          Get.snackbar('Order Submitted', title,
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
                        icon: const Icon(Icons.add_shopping_cart_sharp)),
                  ),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Orderdesc(id, img, title, price, desc),
                        ));
                      },
                   child:  Image.network(siteimgspathlink + listofp[index].img)),
                ));
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late DateTime _currentTime;
  late DateTime _endTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _endTime = _currentTime.add(Duration(days: 5));
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: calculateTimeRemaining(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dynamic timeRemaining = snapshot.data;

          return ListTile(
            leading: const Icon(Icons.history),
            title: Text(
              '${timeRemaining.inDays}d ${timeRemaining.inHours % 24}h ${timeRemaining.inMinutes % 60}m ${timeRemaining.inSeconds % 60}s Left',
            ),
            subtitle: RichText(
                text: const TextSpan(
                    text: 'Coupon: ',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    children: [
                  TextSpan(
                      text: 'Black Friday',
                      style: TextStyle(
                        fontSize: 17,
                      ))
                ])),
            // ignore: prefer_const_constructors
            trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: (() {}),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<Duration> calculateTimeRemaining() async {
    return _endTime.difference(_currentTime);
  }
}
























// class TimerWidget extends StatefulWidget {
//   @override
//   _TimerWidgetState createState() => _TimerWidgetState();
// }

// class _TimerWidgetState extends State<TimerWidget> {
//   // The end time of the timer
//   final endTime =
//       DateTime.now().add(Duration(days: 5, hours: 1, minutes: 5, seconds: 50));
//   // The current time left in the timer
//   late Duration timeLeft;

//   // A periodic timer that updates the time left every second
//   late Timer timer;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the time left by subtracting the current time from the end time
//     timeLeft = endTime.difference(DateTime.now());
//     // Start the timer
//     timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         // Update the time left by subtracting the current time from the end time
//         timeLeft = endTime.difference(DateTime.now());
//       });
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // Cancel the timer when the widget is disposed
//     timer.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//         '${timeLeft.inDays} days ${timeLeft.inHours} hours ${timeLeft.inMinutes} minutes ${timeLeft.inSeconds} seconds left');
//   }
// }
