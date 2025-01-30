import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ku_ty/utils/utils.dart';
import 'package:toastification/toastification.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class CreateEventPageMobileLayout extends StatefulWidget {
  const CreateEventPageMobileLayout({super.key});

  @override
  State<CreateEventPageMobileLayout> createState() =>
      _CreateEventPageMobileLayoutState();
}

class _CreateEventPageMobileLayoutState
    extends State<CreateEventPageMobileLayout> {
  List<File> selectedImages = [];
  TextEditingController controller = TextEditingController();
  late GoogleMapController mapController;
  LatLng selectedLocation = const LatLng(13.746389, 100.535004);
  bool isLocationLoaded = false;

  DateTime? selectedDateTime;

  void _onMapCreated(GoogleMapController mapController) {
    mapController = mapController;
  }

  Future<void> pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      List<File> newImages = result.paths.map((path) => File(path!)).toList();

      if (selectedImages.length + newImages.length > 4) {
        if (mounted) {
          toastification.show(
            context: context,
            type: ToastificationType.error,
            style: ToastificationStyle.flat,
            animationDuration: const Duration(milliseconds: 300),
            animationBuilder: (context, animation, alignment, child) {
              return FadeTransition(
                opacity: animation.drive(Tween(begin: 0.0, end: 1.0)),
                child: child,
              );
            },
            showProgressBar: true,
            closeOnClick: true,
            title: const Text("Error"),
            description: const Text("You can only select up to 4 images"),
          );
        }
        return;
      }

      setState(() {
        for (var newImage in newImages) {
          if (!selectedImages.any((image) => image.path == newImage.path)) {
            selectedImages.add(newImage);
          }
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        isLocationLoaded = true;
        selectedLocation =
            const LatLng(13.746389, 100.535004); // Default location
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          isLocationLoaded = true;
          selectedLocation = const LatLng(13.746389, 100.535004);
        });
        return;
      }

      if (permission == LocationPermission.denied) {
        setState(() {
          isLocationLoaded = true;
          selectedLocation = const LatLng(13.746389, 100.535004);
        });
        return;
      }
    }

    try {
      Position pos = await Geolocator.getCurrentPosition();
      setState(() {
        selectedLocation = LatLng(pos.latitude, pos.longitude);
        isLocationLoaded = true;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLocationLoaded = true;
        selectedLocation = const LatLng(13.746389, 100.535004);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text("Create Event",
              style: TextStyle(
                  color: Color(0xFF02BC77),
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
        ),
        body: SafeArea(
            child: Column(children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildSelectImageSection(),
                  const SizedBox(height: 15),
                  _buildEventNameAndDescription(),
                  const SizedBox(height: 15),
                  _buildSelectDateTime(),
                  const SizedBox(height: 15),
                  _buildMaxParticipants(),
                  const SizedBox(height: 15),
                  _buildCostSection(),
                  const SizedBox(height: 15),
                  _buildSelectLocation(),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          )),
          Column(
            children: [
              Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey[200],
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                width: double.infinity,
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF02BC77),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text("Create"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ])));
  }

  Widget _buildSelectImageSection() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: const TextSpan(
            children: [
              TextSpan(
                text: "🖼️ Images",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: " (Max 4)",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          )),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              for (var image in selectedImages)
                Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedImages.remove(image);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200]?.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 20,
                          width: 20,
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (selectedImages.length < 4)
                InkWell(
                  onTap: () {
                    pickImages();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 100,
                      width: 100,
                      child: Icon(
                        Icons.add,
                        size: 60,
                        color: Colors.grey[600],
                      )),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "📍 Location",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            onVerticalDragUpdate: (details) {
              // Disable drag update to prevent conflict with map gestures
            },
            child: isLocationLoaded
                ? GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: selectedLocation,
                      zoom: 11.0,
                    ),
                    onTap: (LatLng location) {
                      setState(() {
                        selectedLocation = location;
                      });
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId('selectedLocation'),
                        position: selectedLocation,
                      ),
                    },
                    gestureRecognizers: {}
                      ..add(Factory<EagerGestureRecognizer>(
                          () => EagerGestureRecognizer())), // Enables gestures
                  )
                : Center(
                    child: Platform.isAndroid
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : const CupertinoActivityIndicator(
                            color: Colors.black,
                          ),
                  ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventNameAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "📝 Event Name",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            hintText: "Enter event name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "📝 Description",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          maxLines: 5,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            hintText: "Enter event description",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMaxParticipants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "👥 Max Participants",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          keyboardType: TextInputType.number,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            hintText: "Enter max participants",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectDateTime() {
    //use the date picker and time picker
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "⏰ Date & Time",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2025),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Color(
                          0xFF02BC77), // Main color for header and buttons
                      onPrimary:
                          Colors.white, // Text color on the primary color
                      onSurface:
                          Colors.black, // Text color on the dialog surface
                    ),
                    dialogBackgroundColor:
                        Colors.white, // Background color of the dialog
                  ),
                  child: child!,
                );
              },
            ).then((date) {
              if (date != null && mounted) {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Color(
                              0xFF02BC77), // Main color for header and buttons
                          onPrimary:
                              Colors.white, // Text color on the primary color
                          onSurface:
                              Colors.black, // Text color on the dialog surface
                        ),
                        dialogBackgroundColor:
                            Colors.white, // Background color of the dialog
                      ),
                      child: child!,
                    );
                  },
                ).then((time) {
                  if (time != null) {
                    setState(() {
                      selectedDateTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  }
                });
              }
            });
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
                selectedDateTime != null
                    ? const Color(0xFF02BC77)
                    : Colors.grey[200]!),
            foregroundColor: WidgetStateProperty.all<Color>(
                selectedDateTime != null ? Colors.white : Colors.grey[600]!),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          child: (selectedDateTime != null)
              ? Text(getFormattedDateTime(selectedDateTime!))
              : const Text("Select Date & Time"),
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCostSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "💰 Cost (Optional)",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          keyboardType: TextInputType.number,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            hintText: "Enter cost (Optional)",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
