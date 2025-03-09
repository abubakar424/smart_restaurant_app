// List for completed orders (You can add more completed orders if necessary)

// dummy_orders.dart

import 'package:restaurant_app/src/model/order/customer_order_model.dart';
import 'package:restaurant_app/src/model/order/customer_rider_model.dart';
import 'package:restaurant_app/src/model/order/order_item_model.dart';

List<CustomerOrder> dummyOrders = [
  CustomerOrder(
    id: "001",
      orderDate: DateTime.now(), // Current date and time

    items: [
      OrderItem(
        name: "Burger",
        price: 5,
        quantity: 3,
      ),
      OrderItem(name: "Fries", price: 2, quantity: 4),
      OrderItem(name: "Soda", price: 7.99, quantity: 3),
      OrderItem(name: "pizza", price: 5, quantity: 3),
      OrderItem(name: "lasangna", price: 8.99, quantity: 3),
    ],
    customer: Customer(
      name: "John Doe",
      phoneNumber: "123-456-7890",
      address: "123 Main Ssfdddddddddddddddst",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZLsz8eZF-ufu2qL3Fh8imuEMTRx1Azd1ZYQ&s", // Base64 Image here
    ),
    address: "123 Main St",
    rider: Rider(
        id: "rider001",
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl9FQ3j7DeoocDkg4LDT-4z3ZYcCiLhxLnQg&s", // Base64 Image here
        name: "Jane Smith",
        phoneNumber: "987-654-3210",
        address: "456 Eldfdfdfdfdfdffffffffffffffffffm St",
        status: RiderStatus.available),
    status: OrderStatus.newOrder,
  ),
  CustomerOrder(
    id: "002",
  orderDate: DateTime.now(), // Current date and time
    items: [
      OrderItem(name: "Salad", price: 7.99, quantity: 1),
      OrderItem(name: "Smoothie", price: 4.99, quantity: 2),
    ],
    customer: Customer(
      name: "Alice Johnson",
      phoneNumber: "555-987-6543",
      address: "987 Oak St",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZLsz8eZF-ufu2qL3Fh8imuEMTRx1Azd1ZYQ&s", // Base64 Image here
    ),
    address: "987 Oak St",
    rider: Rider(
        id: "rider003",
        image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZLsz8eZF-ufu2qL3Fh8imuEMTRx1Azd1ZYQ&s", // Base64 Image here
        name: "David Rider",
        phoneNumber: "555-654-3210",
        address: "111 Pine St",
        status: RiderStatus.offline),
    status: OrderStatus.completed,
  ),
  CustomerOrder(
    id: "003",
      orderDate: DateTime.now(), // Current date and time

    items: [
      OrderItem(name: "Pizza", price: 8.99, quantity: 3),
      OrderItem(name: "Soda", price: 1.99, quantity: 3),
    ],
    customer: Customer(
      name: "Jane Smith",
      phoneNumber: "987-654-3210",
      address: "456 cantt St",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl9FQ3j7DeoocDkg4LDT-4z3ZYcCiLhxLnQg&s",
    ),
    address: "456 Elm St",
    rider: Rider(
        id: "rider002",
        image: "",
        name: "Michael Scott",
        phoneNumber: "555-123-4567",
        address: "789 Maple St",
        status: RiderStatus.busy),
    status: OrderStatus.newOrder,
  ),
  CustomerOrder(
    id: "004",
      orderDate: DateTime.now(), // Current date and time

    items: [
      OrderItem(name: "Salad", price: 7.99, quantity: 1),
      OrderItem(name: "Smoothie", price: 4.99, quantity: 2),
    ],
    customer: Customer(
      name: "Alice Johnson",
      phoneNumber: "555-987-6543",
      address: "987 Oak St",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl9FQ3j7DeoocDkg4LDT-4z3ZYcCiLhxLnQg&s",
    ),
    address: "987 Oak St",
    rider: Rider(
        id: "rider003",
        image: "",
        name: "David Rider",
        phoneNumber: "555-654-3210",
        address: "111 Pine St",
        status: RiderStatus.offline),
    status: OrderStatus.newOrder,
  ),
  CustomerOrder(
    id: "005",
      orderDate: DateTime.now(), // Current date and time

    items: [
      OrderItem(name: "Pizza", price: 8.99, quantity: 3),
      OrderItem(name: "Soda", price: 1.99, quantity: 3),
    ],
    customer: Customer(
      name: "Jane Smith",
      phoneNumber: "987-654-3210",
      address: "456 Elm St",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl9FQ3j7DeoocDkg4LDT-4z3ZYcCiLhxLnQg&s",
    ),
    address: "456 Elm St",
    rider: Rider(
        id: "rider002",
        image: "",
        name: "Michael Scott",
        phoneNumber: "555-123-4567",
        address: "789 Maple St",
        status: RiderStatus.busy),
    status: OrderStatus.preparing,
  ),
  CustomerOrder(
    id: "006",
      orderDate: DateTime.now(), // Current date and time

    items: [
      OrderItem(name: "Burger", price: 5, quantity: 3),
      OrderItem(name: "Fries", price: 2, quantity: 4),
    ],
    customer: Customer(
      name: "John Doe",
      phoneNumber: "123-456-7890",
      address: "123 Main St",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl9FQ3j7DeoocDkg4LDT-4z3ZYcCiLhxLnQg&s",
    ),
    address: "123 Main St",
    rider: Rider(
        id: "rider001",
        image: "",
        name: "Jane Smith",
        phoneNumber: "987-654-3210",
        address: "456 Elm St",
        status: RiderStatus.available),
    status: OrderStatus.newOrder,
  ),
];
