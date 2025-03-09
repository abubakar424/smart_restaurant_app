import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../model/order/customer_order_model.dart';

class OrderCard extends StatelessWidget {
  final CustomerOrder order; // Updated to use CustomerOrder model
  final VoidCallback onTap; // New onTap parameter for handling taps

  const OrderCard({Key? key, required this.order, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Trigger the onTap callback when the card is tappeds

      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Card(
          elevation: 2, // Adds a shadow effect to the card
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12), // Rounded corners for the card
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row containing the image and the order details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image on the left
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          8), // Rounded corners for the image
                      child: Image.network(
                        order.customer.image,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 50);
                        },
                      ),
                    ),
                    const SizedBox(width: 16), // Space between image and text

                    // Column containing text (Order ID, Address, Date, Price, Items)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Order ID
                          Text(
                            'Order ID: ${order.id}', // Adjusted to display Order ID
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  letterSpacing: 0,
                                ),
                          ),
                          // const SizedBox(height: 4),

                          // Address
                          Text(order.customer.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lightText,
                                    fontSize: 14,
                                  )),

                          // Date
                          Text(
                            'Address: ${order.customer.address}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.lightText,
                                  letterSpacing: 0,
                                ),
                            overflow: TextOverflow
                                .ellipsis, // This will add the ellipsis (...) if the text is too long
                            maxLines: 1, // Ensures it stays on one line
                          ),
                          // const SizedBox(height: 4),

                          Text(
                            ' ${(order.orderDate)}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: AppColors.lightText,
                                  letterSpacing: 0,
                                ),
                          ),
                          // const SizedBox(height: 4),

                          // Price and number of items

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total:',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: AppColors.lightText,
                                      letterSpacing: 0,
                                    ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                '\$${order.totalPrice.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: AppColors.green,
                                      letterSpacing: 0,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
