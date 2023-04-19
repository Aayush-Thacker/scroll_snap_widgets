<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A Flutter plugin for showing custom items in horizontal or vertical scrollable ListView with item snapping functionality.

As soon as the user scrolls through these items, it automatically stops perfectly on an item to get a good user experience. It uses only ScrollView and ScrollController to get this behavior, PageView is not being used here.

<table>
<tr>
<td><img src="https://github.com/Aayush-Thacker/scroll_snap_widgets/blob/main/files/horizontal_recording.gif?raw=true" alt="Horizontal Items Recording"></td>
<td><img src="https://github.com/Aayush-Thacker/scroll_snap_widgets/blob/main/files/vertical_recording.gif?raw=true" alt="Vertical Items Recording"></td>
</tr>
</table>

## Features

This plugin consists of one widget called ScrollSnapWidgets that gives the snapping functionality automatically. It takes a few required properties and is fully customizable with custom items.

There is also a controller class called ScrollSnapWidgetsController having multiple functions with customizations:
    - isFirst() and isLast() to check if the user is at the first or last item in the scrollable area.
    - animateNext(), animatePrevious(), jumpNext(), jumpPrevious() functions help to programitically go through items.
    - animateStart(), animateEnd(), jumpStart(), jumpEnd() functions help to go directly to the starting or ending point programmatically.
    - The dispose() method is also there for resource cleanup.

## Getting started

This widget requires items with the same size of items to work, where size can be height or width depending on the scroll direction. 

When Scroll Direction is *Horizontal*,
itemSize = Width
        &
widgetSize = Height

When Scroll Direction is *Vertical*,
itemSize = Height
        &
widgetSize = Width

If the above two values are provided properly, the package will work perfectly. Also do remember to use the same height or width as the itemSize in your itemBuilder widget.


## Usage
The example on GitHub will result in this kind of output:

<table>
<tr>
<td><img src="https://raw.githubusercontent.com/Aayush-Thacker/scroll_snap_widgets/main/files/home_page_ss.png" alt="Home Page Screenshot"></td>
<td><img src="https://raw.githubusercontent.com/Aayush-Thacker/scroll_snap_widgets/main/files/horizontal_ss.png" alt="Horizontal Items Screenshot"></td>
<td><img src="https://raw.githubusercontent.com/Aayush-Thacker/scroll_snap_widgets/main/files/vertical_ss.png" alt="Vertical Items Screenshot"></td>
</tr>
</table>

Here is a simple example of ScrollSnapWidget with items scrollable Horizontally:

```dart
ScrollSnapWidgets(
    //instance of ScrollSnapWidgetsController
    controller: _controller,
    //total height of the widget because its horizontal
    widgetSize: 300,
    //horizontally scrollable snapping items
    scrollDirection: Axis.horizontal,
    //width of each item
    itemSize: 150,
    //total number of items
    itemCount: Data.allItems.length
    //item widget builder
    itemBuilder: (itemIndex) => SimpleItemCard(
        widgth: 150,
        item: Data.allItems[itemIndex],
    ),
),
```
Then functions can be used on different events to programmatically go through items:

```dart
//for size pass the same double value as itemSize while initialising the controller
final ScrollSnapWidgetsController _controller =
      ScrollSnapWidgetsController(size: 150);

_controller.animateNext(duration = const Duration(milliseconds: 500), curve = Curves.easeOut);
_controller.animatePrevious();

_controller.jumpStart();
_controller.jumpEnd();
```


## Additional information

This is my first ever published package, hope it helps. If there are any issues please post them on GitHub issues section. Also feel free to contribute new features, and bug fixes from you are always appreciated. Thank you.
