import 'package:flutter/material.dart';

class PagingScrollPhysics extends ScrollPhysics {
  final double itemDimension;

  const PagingScrollPhysics(
      {required this.itemDimension, ScrollPhysics? parent})
      : super(parent: parent);

  @override
  PagingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return PagingScrollPhysics(
        itemDimension: itemDimension, parent: buildParent(ancestor));
  }

  double _getPage(ScrollMetrics position) {
    return position.pixels / itemDimension;
  }

  double _getPixels(double page) {
    return page * itemDimension;
  }

  double _getTargetPixels(
      ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return _getPixels(page.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}

class ScrollSnapWidgetsController {
  double size;
  ScrollSnapWidgetsController({
    required this.size,
  });
  ScrollController itemScrollController = ScrollController();

  bool isFirst() {
    if (itemScrollController.position.pixels < size) {
      return true;
    } else {
      return false;
    }
  }

  bool isLast() {
    if (itemScrollController.position.atEdge) {
      return true;
    } else {
      return false;
    }
  }

  bool animateStart({
    Duration duration = const Duration(milliseconds: 500),
    Cubic curve = Curves.easeIn,
  }) {
    if (!isFirst()) {
      itemScrollController.animateTo(
          itemScrollController.position.minScrollExtent,
          duration: duration,
          curve: curve);
      return true;
    }
    return false;
  }

  bool animateEnd({
    Duration duration = const Duration(milliseconds: 500),
    Cubic curve = Curves.easeOut,
  }) {
    if (!isLast() || isFirst()) {
      itemScrollController.animateTo(
          itemScrollController.position.maxScrollExtent,
          duration: duration,
          curve: curve);
      return true;
    }
    return false;
  }

  bool jumpStart() {
    if (!isFirst()) {
      itemScrollController.jumpTo(
        itemScrollController.position.minScrollExtent,
      );
      return true;
    }
    return false;
  }

  bool jumpEnd() {
    if (!isLast() || isFirst()) {
      itemScrollController.jumpTo(
        itemScrollController.position.maxScrollExtent,
      );
      return true;
    }
    return false;
  }

  bool animateNext({
    Duration duration = const Duration(milliseconds: 500),
    Cubic curve = Curves.easeIn,
  }) {
    if (!isLast() || isFirst()) {
      itemScrollController.animateTo(itemScrollController.offset + size,
          duration: duration, curve: curve);
      return true;
    }
    return false;
  }

  bool animatePrevious({
    Duration duration = const Duration(milliseconds: 500),
    Cubic curve = Curves.easeOut,
  }) {
    if (!isFirst()) {
      itemScrollController.animateTo(itemScrollController.offset - size,
          duration: duration, curve: curve);
      return true;
    }
    return false;
  }

  bool jumpNext() {
    if (!isLast() || isFirst()) {
      itemScrollController.jumpTo(
        itemScrollController.offset + size,
      );
      return true;
    }
    return false;
  }

  bool jumpPrevious() {
    if (!isFirst()) {
      itemScrollController.jumpTo(
        itemScrollController.offset - size,
      );
      return true;
    }
    return false;
  }

  void dispose() {
    itemScrollController.dispose();
  }
}

class ScrollSnapWidgets extends StatelessWidget {
  //the direction in which these items will be scrollable
  final Axis scrollDirection;

  //the fixed size of each item (width for Vertical) and (height for Horizontal)
  final double itemSize;

  //full widget size in the screen (height for Vertical) and (width for Horizontal)
  final double widgetSize;

  //total number of items in the list
  final int itemCount;

  //the item widget builder
  final Widget Function(int itemIndex) itemBuilder;

  //main padding of the scrollable items
  final EdgeInsets padding;

  //controller to implement next-previous functionality
  final ScrollSnapWidgetsController? controller;

  //scroll physics of the parent scrollview (if any)
  final ScrollPhysics? parent;

  const ScrollSnapWidgets({
    super.key,
    required this.widgetSize,
    required this.scrollDirection,
    required this.itemSize,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.parent,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: scrollDirection == Axis.horizontal ? widgetSize : null,
      width: scrollDirection == Axis.vertical ? widgetSize : null,
      child: Padding(
        padding: padding,
        child: ListView.builder(
          scrollDirection: scrollDirection,
          physics: PagingScrollPhysics(itemDimension: itemSize, parent: parent),
          controller: controller?.itemScrollController,
          itemCount: itemCount,
          itemBuilder: (context, index) => itemBuilder(index),
        ),
      ),
    );
  }
}
