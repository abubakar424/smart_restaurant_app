// dummy_orders.dart
import 'package:restaurant_app/src/model/history/history_model.dart';

class DummyOrders {
  static List<OrderModel> ongoingOrders = [
    OrderModel(
      id: 80080800,
      address: '8700 Beverly, CA 90048',
      date: 'Tuesday, 03 March 2023',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNadhCRRPTgRueVa9jqum2AyWqttu844pDJQ&s', // Replace with your image path
      price: '\$40',
      items: '2 items',
    ),
    OrderModel(
      id: 80080800,
      address: '8700 Beverly, CA 90048',
      date: 'Tuesday, 03 March 2023',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNadhCRRPTgRueVa9jqum2AyWqttu844pDJQ&s', // Replace with your image path
      price: '\$40',
      items: '2 items',
    ),
    OrderModel(
      id: 80080800,
      address: '8700 Beverly, CA 90048',
      date: 'Tuesday, 03 March 2023',
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSePWnKixXpOLne-w3fnfp969oRPUBXvb1O-Q&s',
      price: '\$40',
      items: '2 items',
    ),
    // Add more ongoing orders here
  ];

  static List<OrderModel> completedOrders = [
    OrderModel(
      id: 80080800,
      address: '8700 Beverly, CA 90048',
      price: '\$40',
      items: '2 items',
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSePWnKixXpOLne-w3fnfp969oRPUBXvb1O-Q&s',
      date: 'Tuesday, 03 March 2023',
    ),
    OrderModel(
      id: 080080800,
      address: '8700 Beverly, CA 90048',
      price: '\$40',
      items: '2 items',
      imageUrl: 
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNadhCRRPTgRueVa9jqum2AyWqttu844pDJQ&s', // Replace with your image path
      date: 'Tuesday, 03 March 2023',
    ),
    OrderModel(
      id: 080080800,
      address: '8700 Beverly, CA 90048',
      price: '\$40',
      items: '2 items',
      imageUrl:
       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSePWnKixXpOLne-w3fnfp969oRPUBXvb1O-Q&s',
      date: 'Tuesday, 03 March 2023',
    ),
    // Add more completed orders here
  ];
}
