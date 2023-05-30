///a simple data model with title and asset image path as item
class ItemDataModel {
  String title;
  String image;
  ItemDataModel({required this.title, required this.image});
}

///class to store static data
class Data {
  ///list of items containing Anime names and Images from the assets folder
  ///the images are from my wallpaper connection, fellow weebs might like them
  static List<ItemDataModel> allItems = [
    ItemDataModel(title: 'Naruto', image: 'assets/1.jpg'),
    ItemDataModel(title: 'Bleach', image: 'assets/2.jpg'),
    ItemDataModel(title: 'Code Geass', image: 'assets/3.jpg'),
    ItemDataModel(title: 'One Piece', image: 'assets/4.jpg'),
    ItemDataModel(title: 'Bungo Stray Dogs', image: 'assets/5.png'),
    ItemDataModel(title: 'Mob Physico 100', image: 'assets/6.jpg'),
    ItemDataModel(title: 'Chainsaw Man', image: 'assets/7.jpg'),
    ItemDataModel(title: 'Gurren Lagann', image: 'assets/8.jpg'),
    ItemDataModel(title: 'Tokyo Revengers', image: 'assets/9.jpg'),
    ItemDataModel(title: 'Hunter x Hunter', image: 'assets/10.jpg'),
    ItemDataModel(title: 'Arcane', image: 'assets/11.jpg'),
    ItemDataModel(title: 'Violet Evergarden', image: 'assets/13.png'),
  ];
}
