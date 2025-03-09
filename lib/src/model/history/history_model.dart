

class OrderModel {
  final double id;
  final String address;
  final String price;
  final String items;
  final String imageUrl;
  final String date; // e.g., 'Tuesday, 03 March 2023'

  OrderModel({
    required this.id,
    required this.address,
    required this.price,
    required this.items,
    required this.imageUrl,
    required this.date,
  });
}
