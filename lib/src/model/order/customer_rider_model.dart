// class CustomerOrder {
//   final String id;
//   final List<OrderItem> items;
//   final double totalPrice;
//   final Customer customer;
//   final String address;
//   final Rider rider;
//   OrderStatus status;
//     final DateTime orderDate; // New field for storing order date


//   CustomerOrder({
//     required this.id,
//     required this.items,
//     required this.customer,
//     required this.address,
//     required this.rider,
//     required this.status,
//         required this.orderDate, // Include order date in the constructor

//   }) : totalPrice = items.fold(
//           0.0,
//           (previousValue, item) =>
//               previousValue +
//               item.totalPrice, // Sum of total price for each item
//         );
// }

// class OrderItem {
//   final String name;
//   final double price;
//   final int quantity; // Added quantity field

//   OrderItem({
//     required this.name,
//     required this.price,
//     required this.quantity,
//   });

//   // Calculate the total price for this item based on quantity
//   double get totalPrice => price * quantity;
// }

class Customer {
  final String name;
  final String phoneNumber;
  final String address;
  final String image;

  Customer({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.image,
  });

  get id => null;
}

enum OrderStatus { newOrder, preparing, completed, cancelled }

class Rider {
  final String id;
  final String image;
  final String name;
  final String phoneNumber;
  final String address;
  final RiderStatus status;

  Rider({
    required this.id,
    required this.image,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.status,
  });
}

enum RiderStatus { available, busy, offline }
