import 'package:flutter/material.dart';

/*
A custom made scroll physics to get the snapping effect
this is not fully developed by myself, here is the source of the code from a stackoverflow answer:
https://stackoverflow.com/questions/60458885/how-to-autocorrect-scroll-position-in-a-listview-flutter

This custom made ScrollPhysics helped me a lot with a project, so I decided to use it to make a cool package that could help others too
*/
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
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
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

/*
Controller to control the behaviour of ScrollSnapWidgets
use it's instance with the widget to use all the functionalities of this package
there can be more functions added, if there is any requirement let me know in the GitHub issues
*/
class ScrollSnapWidgetsController {
  //size should be the same as itemSize (width for horizontal) and (height for vertical)
  double size;
  ScrollSnapWidgetsController({
    required this.size,
  });

  //initilizing the ScrollController to use other functionalities
  ScrollController itemScrollController = ScrollController();

  //used to check if the user is at the first item
  bool isFirst() {
    if (itemScrollController.position.pixels < size) {
      return true;
    } else {
      return false;
    }
  }

  //function used to check if the user is on the edge of the scrollview (not end, it cound also be starting edge)
  bool isLast() {
    if (itemScrollController.position.atEdge) {
      return true;
    } else {
      return false;
    }
  }

  //animate to the start item with custom duration and curve
  bool animateStart({
    //returns true if action is done, false otherwise
    Duration duration = const Duration(milliseconds: 500),
    Cubic curve = Curves.easeIn,
  }) {
    //checking if the user is not already at the start
    if (!isFirst()) {
      itemScrollController.animateTo(
          itemScrollController.position.minScrollExtent,
          duration: duration,
          curve: curve);
      return true;
    }
    return false;
  }

  //animate to the end item with custom duration and curve
  bool animateEnd({
    //returns true if action is done, false otherwise
    Duration duration = const Duration(milliseconds: 500),
    Cubic curve = Curves.easeOut,
  }) {
    //checking if the user is on the last edge
    if (!isLast() || isFirst()) {
      itemScrollController.animateTo(
          itemScrollController.position.maxScrollExtent,
          duration: duration,
          curve: curve);
      return true;
    }
    return false;
  }

  //go directly to the start
  bool jumpStart() {
    //returns true if action is done, false otherwise
    //checking if the user is not already at the start
    if (!isFirst()) {
      itemScrollController.jumpTo(
        itemScrollController.position.minScrollExtent,
      );
      return true;
    }
    return false;
  }

  //go directly to the end
  bool jumpEnd() {
    //returns true if action is done, false otherwise
    //checking if the user is on the last edge
    if (!isLast() || isFirst()) {
      itemScrollController.jumpTo(
        itemScrollController.position.maxScrollExtent,
      );
      return true;
    }
    return false;
  }

  //animate to the next item with custom duration and curve
  bool animateNext({
    //returns true if action is done, false otherwise
    Duration duration = const Duration(milliseconds: 500),
    Cubic curve = Curves.easeIn,
  }) {
    //checking if the user is on the last edge
    if (!isLast() || isFirst()) {
      itemScrollController.animateTo(itemScrollController.offset + size,
          duration: duration, curve: curve);
      return true;
    }
    return false;
  }

  //animate to the previous item with custom duration and curve
  bool animatePrevious({
    //returns true if action is done, false otherwise
    Duration duration = const Duration(milliseconds: 500),
    Cubic curve = Curves.easeOut,
  }) {
    //checking if the user is not already at the start
    if (!isFirst()) {
      itemScrollController.animateTo(itemScrollController.offset - size,
          duration: duration, curve: curve);
      return true;
    }
    return false;
  }

  //go directly to the next item
  bool jumpNext() {
    //returns true if action is done, false otherwise
    //checking if the user is on the last edge
    if (!isLast() || isFirst()) {
      itemScrollController.jumpTo(
        itemScrollController.offset + size,
      );
      return true;
    }
    return false;
  }

  //go directly to previous item
  bool jumpPrevious() {
    //returns true if action is done, false otherwise
    //checking if the user is not already at the start
    if (!isFirst()) {
      itemScrollController.jumpTo(
        itemScrollController.offset - size,
      );
      return true;
    }
    return false;
  }

  //disposing the ScrollController
  void dispose() {
    itemScrollController.dispose();
  }
}

//main widget of the package, usable for both horizontal and vertical items
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

  //default constructor with all properties
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
    /*
    The UI consists of a SizedBox with fixed height or width according to the scrollDirection
    There is an optional padding as it's child
    The main view is a ListView builder having the custom scroll physics and other custom properties
    */
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
