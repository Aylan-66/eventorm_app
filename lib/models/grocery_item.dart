class GroceryItem {
  final int id;
  final String name;
  final String artist;
  final String description;
  final double price;
  final String imagePath;

  GroceryItem(
      {this.id, this.name, this.artist, this.description, this.price, this.imagePath});
}

var demoItems = [
  GroceryItem(
      id: 1,
      name: "QALF TOUR",
      artist: "Damso",
      description: "Rap",
      price: 40,
      imagePath: "assets/images/event_images/n_damso.png"),
  GroceryItem(
      id: 2,
      name: "THE WEEKND TOUR",
      artist: "The Weeknd",
      description: "Pop",
      price: 40,
      imagePath: "assets/images/event_images/n_damso.png"),
  GroceryItem(
      id: 3,
      name: "BOOBA SDF",
      artist: "Booba",
      description: "Rap",
      price: 40,
      imagePath: "assets/images/event_images/n_damso.png"),
  GroceryItem(
      id: 4,
      name: "QALF TOUR",
      artist: "Damso",
      description: "Rap",
      price: 40,
      imagePath: "assets/images/event_images/n_damso.png"),
  GroceryItem(
      id: 5,
      name: "QALF TOUR",
      artist: "Damso",
      description: "Rap",
      price: 40,
      imagePath: "assets/images/event_images/n_damso.png"),
  GroceryItem(
      id: 6,
      name: "QALF TOUR",
      artist: "Damso",
      description: "Rap",
      price: 40,
      imagePath: "assets/images/event_images/n_damso.png"),
];

var exclusiveOffers = [demoItems[0], demoItems[1], demoItems[2]];

var bestSelling = [demoItems[3]];

var groceries = [demoItems[4], demoItems[5]];

var beverages = [
  GroceryItem(
      id: 7,
      name: "Dite Coke",
      description: "355ml, Price",
      price: 1.99,
      imagePath: "assets/images/beverages_images/diet_coke.png"),
  GroceryItem(
      id: 8,
      name: "Sprite Can",
      description: "325ml, Price",
      price: 1.50,
      imagePath: "assets/images/beverages_images/sprite.png"),
  GroceryItem(
      id: 8,
      name: "Apple Juice",
      description: "2L, Price",
      price: 15.99,
      imagePath: "assets/images/beverages_images/apple_and_grape_juice.png"),
  GroceryItem(
      id: 9,
      name: "Orange Juice",
      description: "2L, Price",
      price: 1.50,
      imagePath: "assets/images/beverages_images/orange_juice.png"),
  GroceryItem(
      id: 10,
      name: "Coca Cola Can",
      description: "325ml, Price",
      price: 4.99,
      imagePath: "assets/images/beverages_images/coca_cola.png"),
  GroceryItem(
      id: 11,
      name: "Pepsi Can",
      description: "330ml, Price",
      price: 4.99,
      imagePath: "assets/images/beverages_images/pepsi.png"),
];
