import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      initialIndex: 0,
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              AppImages.backgroundImage,
              color: colorScheme(context).outline,
            ),
            SafeArea(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 10, top: 16),
                  child: Row(
                    children: [
                      BackButton(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Notifications",
                          style: textTheme(context)
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: colorScheme(context).onPrimary,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 30),
                  indicatorPadding: const EdgeInsets.symmetric(vertical: 5),
                  indicator: BoxDecoration(
                    color: colorScheme(context).primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelColor: colorScheme(context).onPrimary,
                  unselectedLabelColor: colorScheme(context).outline,
                  unselectedLabelStyle: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  labelStyle: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 12.11),
                  ),
                  tabs: [
                    Tab(text: 'All',),
                    Tab(text: 'General'),
                    Tab(text: 'New Order'),
                    Tab(text: 'Prepared',),
                    Tab(text: 'Cancellations'),
                    Tab(text: 'Received'),
                  ],
                ),
                Expanded(child: TabBarView(children: [
                  NotificationsPageTabView(),
                  NotificationsPageTabView(),
                  NotificationsPageTabView(),
                  NotificationsPageTabView(),
                  NotificationsPageTabView(),
                  NotificationsPageTabView(),
                ]))
              ],
            ))
          ],
        ),
      ),
    );
  }
}


class NotificationsPageTabView extends StatelessWidget {
  const NotificationsPageTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.orangeBg.withOpacity(0.4),
              radius: 20,
              child: SvgPicture.asset(AppIcons.newOrderIcon),
            ),
            title: Text("New Order Availale",style: textTheme(context).bodyMedium?.copyWith(fontWeight: FontWeight.w700,letterSpacing: 0),),
            subtitle: Text("Order #12345 from [Store Name]",style: textTheme(context).labelMedium?.copyWith(letterSpacing: 0,fontWeight: FontWeight.w500,color: colorScheme(context).outline),),
            trailing: Text("3:00 PM",style: textTheme(context).labelMedium?.copyWith(letterSpacing: 0,fontWeight: FontWeight.w500,color: colorScheme(context).outline),),
          ),
        ],
      ),
    );
  }
}