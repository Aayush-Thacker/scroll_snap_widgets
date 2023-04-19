import 'package:example/data.dart';
import 'package:scroll_snap_widgets/scroll_snap_widgets.dart';
import 'package:example/widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll Snap Widgets Example'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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

class HorizontalItems extends StatefulWidget {
  const HorizontalItems({super.key});

  @override
  State<HorizontalItems> createState() => _HorizontalItemsState();
}

class _HorizontalItemsState extends State<HorizontalItems> {
  static const double bigItemWidth = 300;
  final ScrollSnapWidgetsController _controllerAnimate =
      ScrollSnapWidgetsController(size: bigItemWidth);
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
            ScrollSnapWidgets(
                padding: EdgeInsets.zero,
                widgetSize: 200,
                scrollDirection: Axis.horizontal,
                itemSize: 200,
                itemBuilder: (itemIndex) => SimpleItemCard(
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
                      _controllerAnimate.animatePrevious();
                    },
                    icon: const Icon(Icons.navigate_before),
                  ),
                  IconButton(
                    onPressed: () {
                      _controllerAnimate.animateNext();
                    },
                    icon: const Icon(Icons.navigate_next),
                  ),
                ],
              ),
            ),
            ScrollSnapWidgets(
                controller: _controllerAnimate,
                padding: EdgeInsets.zero,
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
                      _controllerJump.jumpPrevious();
                    },
                    icon: const Icon(Icons.navigate_before),
                  ),
                  IconButton(
                    onPressed: () {
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

  @override
  void dispose() {
    _controllerAnimate.dispose();
    _controllerJump.dispose();
    super.dispose();
  }
}

class VerticalItems extends StatefulWidget {
  const VerticalItems({super.key});

  @override
  State<VerticalItems> createState() => _VerticalItemsState();
}

class _VerticalItemsState extends State<VerticalItems> {
  static const double itemHeight = 500;
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
          fit: StackFit.expand,
          children: [
            ScrollSnapWidgets(
                controller: _controller,
                widgetSize: double.maxFinite,
                scrollDirection: Axis.vertical,
                itemSize: itemHeight,
                itemBuilder: (itemIndex) => SimpleItemCard(
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
                            _controller.animateEnd();
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
