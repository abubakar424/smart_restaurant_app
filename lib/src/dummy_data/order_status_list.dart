import 'dart:math';
import 'package:restaurant_app/src/common/constants/app_images.dart';
import 'package:restaurant_app/src/features/product/model/product_model.dart';
import 'package:restaurant_app/src/model/food_list/food_list_model.dart';
import 'package:restaurant_app/src/model/home/home_page_model.dart';
import 'package:restaurant_app/src/model/order_status_model.dart';

List<OrderStatusModel> orders = [
  OrderStatusModel(
    orderNumber: "#123459",
    orderDetail: "20 Order",
    estimatedTime: "Est. 20 mins",
    status: statuslist[Random().nextInt(3)],
  ),
  OrderStatusModel(
    orderNumber: "#123456",
    orderDetail: "15 Order",
    estimatedTime: "Est. 15 mins",
    status: statuslist[Random().nextInt(3)],
  ),
  OrderStatusModel(
    orderNumber: "#123456",
    orderDetail: "15 Order",
    estimatedTime: "Est. 15 mins",
    status: statuslist[Random().nextInt(3)],
  ),
  OrderStatusModel(
    orderNumber: "#123457",
    orderDetail: "10 Order",
    estimatedTime: "Est. 10 mins",
    status: statuslist[Random().nextInt(3)],
  ),
  OrderStatusModel(
    orderNumber: "#123457",
    orderDetail: "10 Order",
    estimatedTime: "Est. 10 mins",
    status: statuslist[Random().nextInt(3)],
  ),
  OrderStatusModel(
    orderNumber: "#123458",
    orderDetail: "5 Order",
    estimatedTime: "Est. 5 mins",
    status: statuslist[Random().nextInt(3)],
  ),
  OrderStatusModel(
    orderNumber: "#123458",
    orderDetail: "5 Order",
    estimatedTime: "Est. 5 mins",
    status: statuslist[Random().nextInt(3)],
  ),
  OrderStatusModel(
    orderNumber: "#123459",
    orderDetail: "20 Order",
    estimatedTime: "Est. 20 mins",
    status: statuslist[Random().nextInt(3)],
  ),
];

List statuslist =[
"Received",
"Preparing",
"Completed",
"Delivered"
];

List<HomePageModel> items = [
  HomePageModel(
      image: AppImages.burgerImage,
      name: 'Latest Order',
      subName: 'McDonald’s',
      btn: 'View Order',
      price: 40,
      qty: 2,
      id: 2,
  ),
];



List<FoodListModel> products = [
  FoodListModel(
      image:
      'https://www.wholesomeyum.com/wp-content/uploads/2023/06/wholesomeyum-Best-Burger-Recipe-12.jpg',
      name: 'Burger',
      price: r"60",
      review: "7 review",
      foodList: "Breakfast",
      rating: '4.9',
      id: 1,
      descr: '''Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.

Chicken
Tomatoa
Lettuse

Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt.

Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.

Chicken
Tomatoa
Lettuse

Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt.




'''
  ),
  FoodListModel(
      image:
      'https://www.masala.tv/wp-content/uploads/2015/08/Thai-Chicken-Biryani-Recipe.jpg',
      name: 'Chicken Thai Biriyani',
      price: r"50",
      review: "8 review",
      foodList: "Lunch",
      rating: '4.8',
      id: 2,
      descr: '''Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.

Chicken
Tomatoa
Lettuse

Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt.

Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.

Chicken
Tomatoa
Lettuse

Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt.




'''
  ),
  FoodListModel(
      image:
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjwKD-rdEpzfkgj31kAS24riu4HEZEFccQya0yCu4j6PKXB2_lsjvRZgDdQ9jOj-aRxWR6R6soRJCdHhUxuQ8B5E5NBMG50-zlb-oRgFausgGBeS3IcTc0ufcWYYbwrFqMwUsJyG6exYccz/s16000/chicken-kosha-with-bengali-five-spices3.jpg',
      name: 'Chicken Bhuna',
      price: r"30",
      review: "7 review",
      foodList: "Dinner",
      rating: '4.7',
      id: 3,
      descr: '''Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.

Chicken
Tomatoa
Lettuse
Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt.

Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.

Chicken
Tomatoa
Lettuse

Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt.




'''
  ),
];

List<ProductModel> productData = [
  ProductModel(
      productName: 'Burger',
      productImage:
      'https://www.wholesomeyum.com/wp-content/uploads/2023/06/wholesomeyum-Best-Burger-Recipe-12.jpg',
      productPrice: r"60",
      productCategory: "Foods",
      productId: 1,
      productDescr: '''Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.'''
  ),
  ProductModel(
      productName: 'Thai-Chicken-Biryani',
      productImage:
      'https://www.masala.tv/wp-content/uploads/2015/08/Thai-Chicken-Biryani-Recipe.jpg',
      productPrice: r"60",
      productCategory: "Foods",
      productId: 2,
      productDescr: '''Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.'''
  ),
  ProductModel(
      productName: 'Chicken Bhuna',
      productImage:
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjwKD-rdEpzfkgj31kAS24riu4HEZEFccQya0yCu4j6PKXB2_lsjvRZgDdQ9jOj-aRxWR6R6soRJCdHhUxuQ8B5E5NBMG50-zlb-oRgFausgGBeS3IcTc0ufcWYYbwrFqMwUsJyG6exYccz/s16000/chicken-kosha-with-bengali-five-spices3.jpg',
      productPrice: r"60",
      productCategory: "Foods",
      productId: 3,
      productDescr: '''Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.'''
  ),
  ProductModel(
      productName: 'Burger',
      productImage:
      'https://hips.hearstapps.com/hmg-prod/images/drinks-to-avoid-1621959532.jpg?crop=1.00xw:1.00xh;0,0&resize=1200:*',
      productPrice: r"$0",
      productCategory: "Drinks",
      productId: 4,
      productDescr: '''Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.'''
  ),
  ProductModel(
      productName: 'Fruit juice',
      productImage:
      'https://hips.hearstapps.com/hmg-prod/images/orange-juice-pouring-into-glass-royalty-free-image-1621871938.jpg?resize=980:*',
      productPrice: r"60",
      productCategory: "Drinks",
      productId: 5,
      productDescr: '''Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.'''
  ),
];