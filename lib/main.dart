import 'package:flutter/material.dart';
// import 'package:get/get.dart';

import 'home.dart';

void main() {
  runApp(const SplashScreen());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Splashwidget()),
    );
  }
}

class Splashwidget extends StatelessWidget {
  const Splashwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1.5 / 6,
          color: Colors.white,
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1.5 / 6,
          decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(90)),
          ),
          child: const Center(
              child: Text("Multi Store",
                  style: TextStyle(color: Colors.white, fontSize: 50, shadows: [
                    Shadow(
                        color: Color.fromARGB(255, 93, 91, 91),
                        offset: Offset(2, 2),
                        blurRadius: 10)
                  ]))),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 4.5 / 6,
            color: Colors.amber,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                        text: const TextSpan(
                            text: 'Our Site ',
                            style:
                                TextStyle(color: Color.fromARGB(161, 0, 0, 0)),
                            children: [
                          TextSpan(
                            text: 'https://multistore.pk',
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2,
                                fontSize: 15,
                                shadows: [
                                  Shadow(
                                      color: Color.fromARGB(218, 0, 0, 0),
                                      offset: Offset(1, 1),
                                      blurRadius: 1),
                                ]),
                          )
                        ])),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.open_in_browser_outlined,
                          color: Colors.amberAccent,
                          size: 35,
                          shadows: [
                            Shadow(
                                color: Color.fromARGB(255, 0, 0, 0),
                                offset: Offset(2, 1),
                                blurRadius: 3),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.2 / 6),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 4.30 / 6,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(90),
                    bottomRight: Radius.circular(60)),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(45, 0, 0, 0),
                      offset: Offset(1, 8),
                      blurRadius: 10)
                ]),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.shopify_outlined,
                  size: 150,
                  color: Colors.amber,
                  shadows: [
                    Shadow(
                        color: Colors.grey, offset: Offset(1, 1), blurRadius: 5)
                  ],
                ),
                Text("Start Shopping With Multi Store App Online"),
                Text(
                  'Or Visit Our Site Linked Down',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                ),
              ],
            )),
          ),
        ),
        const EndSplash(),
      ],
    );
  }
}

class EndSplash extends StatefulWidget {
  const EndSplash({super.key});

  @override
  State<EndSplash> createState() => _EndSplashState();
}

class _EndSplashState extends State<EndSplash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Home()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
    );
  }
}
