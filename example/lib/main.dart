import 'package:example/data.dart';
import 'package:scroll_snap_widgets/scroll_snap_widgets.dart';
import 'package:example/widgets.dart';
import 'package:flutter/material.dart';

/*
This is an example file for the Flutter package called scroll_snap_widget
this widget allows us to implement accurate auto-stopping on items in a horizontal or vertical scroll view
it gives a unique scrolling experience, it should not be used if you want to implement fast scrolling,
as it prevents more scrolling than the itemSize and brings the user back to the start of the item (the item can be any Widget)

Please find the assets and data.dart and widgets.dart files from the GitHub repository example to run this code perfectly
or clone the project and run the example, if you want to get the exact or similar output
Of course, you are welcome to try it yourself, this example is just a demonstration of its capabilities, you can use it in many ways

Hope it helps, let me know if there are any bugs or any new features ideas in the GitHub issue section.

Created by,
Aayush-Thacker
*/

void main() {
  runApp(const MyApp());
}

///the first app widget to build the MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scroll Snap Widgets Example',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}

///HomePage of the example with 2 buttons and an appbar
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///appbar with constant title
      appBar: AppBar(
        title: const Text('Scroll Snap Widgets Example'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ///first button takes to the HorizontalItems screen
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Card(
                margin: EdgeInsets.zero,
                color: Colors.redAccent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HorizontalItems()));
                  },
                  child: const Center(
                    child: Text(
                      'Horizontal Items',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),

          ///second button takes to the VerticalItems screen
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
              child: Card(
                margin: EdgeInsets.zero,
                color: Colors.redAccent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const VerticalItems()));
                  },
                  child: const Center(
                    child: Text(
                      'Vertical Items',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///page to saw the use cases of package with horizontal scrollable items
class HorizontalItems extends StatefulWidget {
  const HorizontalItems({super.key});

  @override
  State<HorizontalItems> createState() => _HorizontalItemsState();
}

class _HorizontalItemsState extends State<HorizontalItems> {
  static const double bigItemWidth = 300;

  ///controller for animated example
  final ScrollSnapWidgetsController _controllerAnimate =
      ScrollSnapWidgetsController(size: bigItemWidth);

  ///controller for jumping example
  final ScrollSnapWidgetsController _controllerJump =
      ScrollSnapWidgetsController(size: bigItemWidth);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizontal Items'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Normall Snapping Scrollable Items',
                style: TextStyle(fontSize: 20),
              ),
            ),

            ///simple use case without controller
            ScrollSnapWidgets(
                padding: EdgeInsets.zero,

                ///widget size is height in this example
                widgetSize: 200,
                scrollDirection: Axis.horizontal,

                ///item size is item's width
                itemSize: 200,
                itemBuilder: (itemIndex) => SimpleItemCard(
                      ///keep same as item size
                      widgth: 200,
                      item: Data.allItems[itemIndex],
                    ),
                itemCount: Data.allItems.length),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Animate Next Previous',
                      style: TextStyle(
                          fontSize: 20, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ///animate previous with the default curve and duration
                      _controllerAnimate.animatePrevious();
                    },
                    icon: const Icon(Icons.navigate_before),
                  ),
                  IconButton(
                    onPressed: () {
                      ///animaet next with custom curve and duration
                      _controllerAnimate.animateNext(
                          duration: const Duration(seconds: 1),
                          curve: Curves.linearToEaseOut);
                    },
                    icon: const Icon(Icons.navigate_next),
                  ),
                ],
              ),
            ),

            ///example with controller to control the widget's scroll event programetically
            ScrollSnapWidgets(
                controller: _controllerAnimate,
                padding: EdgeInsets.zero,

                ///widget's width
                widgetSize: 300,
                scrollDirection: Axis.horizontal,
                itemSize: bigItemWidth,
                itemBuilder: (itemIndex) => SimpleItemCard(
                      widgth: bigItemWidth,
                      item: Data.allItems[itemIndex],
                    ),
                itemCount: Data.allItems.length),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Jump Next Previous',
                      style: TextStyle(
                          fontSize: 20, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ///controller function call for previous jumping
                      _controllerJump.jumpPrevious();
                    },
                    icon: const Icon(Icons.navigate_before),
                  ),
                  IconButton(
                    onPressed: () {
                      ///controller function call for next jumping
                      _controllerJump.jumpNext();
                    },
                    icon: const Icon(Icons.navigate_next),
                  ),
                ],
              ),
            ),
            ScrollSnapWidgets(
                controller: _controllerJump,
                padding: EdgeInsets.zero,

                ///width of the widget
                widgetSize: 300,
                scrollDirection: Axis.horizontal,
                itemSize: bigItemWidth,
                itemBuilder: (itemIndex) => SimpleItemCard(
                      widgth: bigItemWidth,
                      item: Data.allItems[itemIndex],
                    ),
                itemCount: Data.allItems.length),
          ],
        ),
      ),
    );
  }

  ///the dispose method of the controller disposes of the scroll controller
  @override
  void dispose() {
    _controllerAnimate.dispose();
    _controllerJump.dispose();
    super.dispose();
  }
}

///example to demonstrate Vertically snapping items that stop autometically when user scrolls like instagram posts
class VerticalItems extends StatefulWidget {
  const VerticalItems({super.key});

  @override
  State<VerticalItems> createState() => _VerticalItemsState();
}

class _VerticalItemsState extends State<VerticalItems> {
  static const double itemHeight = 500;

  ///controller for handling custom scroll event callbacks
  final ScrollSnapWidgetsController _controller =
      ScrollSnapWidgetsController(size: itemHeight);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vertical Items'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          ///defines the width of the widget
          fit: StackFit.expand,
          children: [
            ///vertical scrollable items with controller example
            ScrollSnapWidgets(
                controller: _controller,

                ///widget height
                widgetSize: double.maxFinite,
                scrollDirection: Axis.vertical,

                ///item height
                itemSize: itemHeight,
                itemBuilder: (itemIndex) => SimpleItemCard(
                      ///same height as above
                      height: itemHeight,
                      item: Data.allItems[itemIndex],
                    ),
                itemCount: Data.allItems.length),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 100,
                height: 200,
                child: Card(
                  color: Colors.white.withOpacity(0.6),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ///function call to animate to the starting point
                            _controller.animateStart();
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.arrow_upward,
                                size: 35,
                              ),
                              Text('Animate Start'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ///function call to animate to the ending point with custom duration
                            _controller.animateEnd(
                                duration: const Duration(seconds: 2));
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Animate End'),
                              Icon(
                                Icons.arrow_downward,
                                size: 35,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: 100,
                height: 200,
                child: Card(
                  color: Colors.white.withOpacity(0.6),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ///function call for jumping to the starting point
                            _controller.jumpStart();
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.arrow_upward,
                                size: 35,
                              ),
                              Text('Jump Start'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ///function call for jumping to the ending point
                            _controller.jumpEnd();
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Jump End'),
                              Icon(
                                Icons.arrow_downward,
                                size: 35,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///the dispose method of the controller disposes of the scroll controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
