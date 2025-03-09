import 'package:flutter/material.dart';
import 'package:restaurant_app/src/common/constants/app_colors.dart';
import 'package:restaurant_app/src/common/constants/app_images.dart';
import 'package:restaurant_app/src/common/widgets/custom_back_button.dart';
import 'package:restaurant_app/src/model/order/customer_order_model.dart';
import 'package:restaurant_app/src/model/order/customer_rider_model.dart';

class OrderDetailPage extends StatelessWidget {
  final CustomerOrder order;
  final VoidCallback onAction; // Accept order or Mark as done action callback

  const OrderDetailPage({Key? key, required this.order, required this.onAction})
      : assert(
            order != null, 'Order cannot be null!'), // Ensure order is not null
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImages.bgImage,
                  color: Colors.black,
                  height: 123,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              CustomBackButton(),
                              SizedBox(width: width * 0.02),
                              Text(
                                'Order Details',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Customer Section
                        Text(
                          "Customer",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundImage: NetworkImage(
                                  '${order.customer.image ?? "image"}'),
                            ),
                            const SizedBox(width: 18),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' ${order.customer.name ?? "Unknown"}', // Safe access
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Contact: ${order.customer.phoneNumber ?? "N/A"}',
                                ),
                                Text(
                                    'Address: ${order.address ?? "N/A"}'), // Safe access
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Rider Section
                        Text(
                          "Rider",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundImage: NetworkImage(
                                  '${order?.customer.image ?? "image"}'),
                            ),
                            const SizedBox(width: 18),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' ${order.rider.name ?? "Unknown"}', // Safe access
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                    'Contact: ${order.rider.phoneNumber ?? "N/A"}'), // Safe access
                                Text(
                                    'Status: ${_getRiderStatus(order!.rider.status)}'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildItemsTable(context),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                        ),
                        Text(
                          '\$${order?.totalPrice.toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppColors.green,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      height: 60), // Add more space between total and button

                  // Accept Order or Mark as Done button
                  if (order.status == OrderStatus.newOrder)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onAction(); // Update status to "Preparing"
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Accept Order',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.white,
                            ),
                      ),
                    )
                  else if (order.status == OrderStatus.preparing)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onAction(); // Update status to "Completed"
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Mark as Done',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.white,
                            ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build the items table with Quantity, Price per item, and Total
  Widget _buildItemsTable(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Items:',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
        ),
        const SizedBox(height: 10),
        Table(
          border: TableBorder.all(width: 0, color: Colors.transparent),
          columnWidths: const {
            0: FlexColumnWidth(1.5), // Item column slightly larger
            1: FlexColumnWidth(1), // Quantity column
            2: FlexColumnWidth(1), // Price/item column
            3: FlexColumnWidth(1), // Total column
          },
          children: [
            // Table header
            TableRow(
              children: [
                _buildTableHeaderCell(context, 'Item',
                    TextAlign.left), // Left-aligned header for Item
                _buildTableHeaderCell(context, 'Quantity',
                    TextAlign.center), // Center-aligned for other columns
                _buildTableHeaderCell(context, 'Price/item', TextAlign.center),
                _buildTableHeaderCell(context, 'Total', TextAlign.center),
              ],
            ),
            // Table rows for each item
            for (var item in order!.items)
              TableRow(
                children: [
                  _buildTableCell(context, item.name,
                      TextAlign.left), // Left-aligned for Item names
                  _buildTableCell(context, '${item.quantity}',
                      TextAlign.center), // Centered for other data
                  _buildTableCell(context, '\$${item.price.toStringAsFixed(2)}',
                      TextAlign.center),
                  _buildTableCell(
                      context,
                      '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                      TextAlign.center),
                ],
              ),
          ],
        ),
      ],
    );
  }

// Helper to build table header cell (with alignment parameter)
  Widget _buildTableHeaderCell(
      BuildContext context, String label, TextAlign align) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        textAlign: align, // Use the alignment passed in
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
      ),
    );
  }

// Helper to build table cell (with alignment parameter)
  Widget _buildTableCell(BuildContext context, String label, TextAlign align) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        textAlign: align, // Use the alignment passed in
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
      ),
    );
  }

// Helper to convert rider status to a readable string
  String _getRiderStatus(RiderStatus status) {
    switch (status) {
      case RiderStatus.available:
        return 'Available';
      case RiderStatus.busy:
        return 'Busy';
      case RiderStatus.offline:
        return 'Offline';
    }
  }
}
