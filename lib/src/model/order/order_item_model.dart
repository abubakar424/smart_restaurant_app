class OrderItem {
  final String name;
  final double price;
  final int quantity; // Added quantity field

  OrderItem({
    required this.name,
    required this.price,
    required this.quantity,
  });

  // Calculate the total price for this item based on quantity
  double get totalPrice => price * quantity;
}