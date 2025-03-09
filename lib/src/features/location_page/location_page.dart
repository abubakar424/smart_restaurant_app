import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_app/src/common/constants/global_variables.dart';
import 'package:restaurant_app/src/common/widgets/custom_button.dart';
import 'package:restaurant_app/src/common/widgets/custom_text_field.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex =
  CameraPosition(target: LatLng(29.3544, 71.6911), zoom: 14.4746);

  final Set<Marker> _marker = {
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(37.42796133580664, -122.085749655962),
    ),
  };


  @override


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100,),
            Stack(
              children: [
                SizedBox(
                  height: 600,
                  width: double.infinity,
                  child: GoogleMap(
                    initialCameraPosition: _kGooglePlex,
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    compassEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: Set<Marker>.of(_marker),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                    // margin: EdgeInsets.only(top: height * .4),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Text('Address',style: textTheme(context).labelLarge!.copyWith(letterSpacing: 0)),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          hint: '3235 Royal Ln. mesa, new jersy 34567',
                          hintColor: colorScheme(context).outline,
                          filled: true,
                          fillColor: colorScheme(context).outline.withOpacity(0.2),
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('street',style: textTheme(context).labelLarge!.copyWith(letterSpacing: 0)),
                                const SizedBox(height: 5,),
                                SizedBox(
                                  width: size.width * 0.4,
                                  child: CustomTextFormField(
                                    hint: 'hason nagar',
                                    hintColor: colorScheme(context).outline,
                                    filled: true,
                                    fillColor: colorScheme(context).outline.withOpacity(0.2),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Post code',style: textTheme(context).labelLarge!.copyWith(letterSpacing: 0)),
                                const SizedBox(height: 5,),
                                SizedBox(
                                  width: size.width * 0.4,
                                  child: CustomTextFormField(
                                    hint: '34567',
                                    hintColor: colorScheme(context).outline,
                                    filled: true,
                                    fillColor: colorScheme(context).outline.withOpacity(0.2),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 60),
                        Center(
                          child: CustomButton(
                            height: 49,
                            text: 'Changes Location',
                            onTap: () {

                              Navigator.pop(context);

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
