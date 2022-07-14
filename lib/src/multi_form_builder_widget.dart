import 'package:flutter/material.dart';

typedef Itembuilder = Widget Function(BuildContext context, int index);
typedef IndicatorWidget = Widget Function(BuildContext context, int itemCount);
typedef OnPageChanged = void Function(int currentpage);
typedef OnLastPage = void Function();

class MultiFormBuilder extends StatefulWidget {
  final OnPageChanged onPageChanged;
  final OnLastPage onLastPage;
  final PageController controller;
  final int itemCount;
  final Itembuilder itemBuilder;
  final IndicatorWidget indicatorWidget;

  const MultiFormBuilder(
      {Key? key,
      required this.onPageChanged,
      required this.onLastPage,
      required this.controller,
      required this.itemCount,
      required this.itemBuilder,
      required this.indicatorWidget})
      : super(key: key);

  @override
  State<MultiFormBuilder> createState() => _MultiFormBuilderState();
}

class _MultiFormBuilderState extends State<MultiFormBuilder> {
  late final PageController pageController;

  int? get currentPage {
    if (pageController.hasClients && pageController.position.haveDimensions) {
      return pageController.page?.toInt();
    }
    return 0;
  }

  bool get isLastPage {
    if (pageController.hasClients && pageController.position.haveDimensions) {
      return pageController.page == widget.itemCount - 1;
    }
    return false;
  }

  void listenPage() {
    if (isLastPage) {
      widget.onLastPage();
    }
  }

  @override
  void initState() {
    pageController = widget.controller;
    pageController.addListener(listenPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.indicatorWidget(context, widget.itemCount),
        Flexible(
          child: Center(
            child: PageView.builder(
              itemCount: widget.itemCount,
              onPageChanged: widget.onPageChanged,
              itemBuilder: widget.itemBuilder,
              controller: pageController,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    pageController.removeListener(listenPage);
    super.dispose();
  }
}
