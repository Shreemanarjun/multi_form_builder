import 'package:flutter/material.dart';
import 'package:multi_form_builder/multi_form_builder.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MultiFormBuilder(
          onPageChanged: (int currentpage) {
            debugPrint('current page: $currentpage');
          },
          onLastPage: () {
            debugPrint('last page got');
          },
          controller: pageController,
          itemBuilder: (BuildContext context, int index) {
            return MyWidget(text: 'Page $index');
          },
          itemCount: 3,
          indicatorWidget: (context, totalItems) {
            return SmoothPageIndicator(
              controller: pageController, // PageController
              count: totalItems, // total number of pages
              effect: const SlideEffect(), // your preferred effect
              onDotClicked: (int dotindex) {
                pageController.jumpToPage(dotindex);
              },
            );
          },
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final String text;
  const MyWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('build: $text');
    return Center(
      child: Text(text),
    );
  }
}
