

import 'customer_rider_model.dart';
import 'order_item_model.dart';

class CustomerOrder {
  final String id;
  final List<OrderItem> items;
  final double totalPrice;
  final Customer customer;
  final String address;
  final Rider rider;
  OrderStatus status;
    final DateTime orderDate; // New field for storing order date


  CustomerOrder({
    required this.id,
    required this.items,
    required this.customer,
    required this.address,
    required this.rider,
    required this.status,
        required this.orderDate, // Include order date in the constructor

  }) : totalPrice = items.fold(
          0.0,
          (previousValue, item) =>
              previousValue +
              item.totalPrice, // Sum of total price for each item
        );
}