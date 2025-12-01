import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/food_truck.dart';

class MapView extends StatefulWidget {
  final List<FoodTruck> trucks;
  final FoodTruck? selectedTruck;
  final Function(FoodTruck) onMarkerClick;

  const MapView({
    super.key,
    required this.trucks,
    this.selectedTruck,
    required this.onMarkerClick,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? _mapController;
  int? _activeMarkerId;

  // Center on Newark, NJ
  static const CameraPosition _defaultPosition = CameraPosition(
    target: LatLng(40.735657, -74.172367),
    zoom: 13,
  );

  @override
  void didUpdateWidget(MapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedTruck != null &&
        widget.selectedTruck != oldWidget.selectedTruck) {
      _moveToTruck(widget.selectedTruck!);
    }
  }

  void _moveToTruck(FoodTruck truck) {
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(truck.location.lat, truck.location.lng),
        15,
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return widget.trucks.map((truck) {
      final isSelected = widget.selectedTruck?.id == truck.id;

      return Marker(
        markerId: MarkerId(truck.id.toString()),
        position: LatLng(truck.location.lat, truck.location.lng),
        icon: isSelected
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange)
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onTap: () {
          setState(() {
            _activeMarkerId = truck.id;
          });
          widget.onMarkerClick(truck);
        },
        infoWindow: _activeMarkerId == truck.id
            ? InfoWindow(
                title: truck.name,
                snippet: '${truck.cuisine} - ${truck.location.address}',
              )
            : InfoWindow.noText,
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    // Check if API key is available
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      return _buildPlaceholder();
    }

    return GoogleMap(
      initialCameraPosition: _defaultPosition,
      markers: _createMarkers(),
      onMapCreated: (controller) {
        _mapController = controller;
      },
      zoomControlsEnabled: true,
      myLocationButtonEnabled: false,
      mapToolbarEnabled: false,
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.grey.shade100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.map,
              size: 64,
              color: Color(0xFF7f8c8d),
            ),
            const SizedBox(height: 16),
            const Text(
              '🗺️ Google Maps Integration',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2c3e50),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Map will display here when API key is configured.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF7f8c8d),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add your Google Maps API key to .env file:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7f8c8d),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'GOOGLE_MAPS_API_KEY=your_api_key',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Food Truck Locations:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2c3e50),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.trucks.length,
                itemBuilder: (context, index) {
                  final truck = widget.trucks[index];
                  final isSelected = widget.selectedTruck?.id == truck.id;

                  return ListTile(
                    dense: true,
                    leading: const Text('📍'),
                    title: Text(truck.name),
                    subtitle: Text(truck.location.address),
                    selected: isSelected,
                    selectedTileColor: const Color(0xFFFFF3E0),
                    onTap: () => widget.onMarkerClick(truck),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
