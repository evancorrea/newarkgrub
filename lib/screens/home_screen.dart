import 'package:flutter/material.dart';
import '../models/food_truck.dart';
import '../data/food_trucks.dart';
import '../widgets/header.dart';
import '../widgets/food_truck_list.dart';
import '../widgets/food_truck_form.dart';
import '../widgets/map_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FoodTruck> _trucks = [];
  FoodTruck? _selectedTruck;
  FoodTruck? _editingTruck;
  bool _showForm = false;

  @override
  void initState() {
    super.initState();
    _trucks = List.from(initialFoodTrucks);
  }

  void _handleAddTruck(FoodTruck truckData) {
    setState(() {
      final newId = _trucks.isEmpty
          ? 1
          : _trucks.map((t) => t.id).reduce((a, b) => a > b ? a : b) + 1;

      final newTruck = truckData.copyWith(id: newId);
      _trucks.add(newTruck);
      _showForm = false;
    });
  }

  void _handleUpdateTruck(FoodTruck truckData) {
    setState(() {
      final index = _trucks.indexWhere((t) => t.id == truckData.id);
      if (index != -1) {
        _trucks[index] = truckData;
      }
      _editingTruck = null;
      _selectedTruck = truckData;
    });
  }

  void _handleDeleteTruck(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Food Truck'),
        content: const Text('Are you sure you want to delete this food truck?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _trucks.removeWhere((t) => t.id == id);
                if (_selectedTruck?.id == id) {
                  _selectedTruck = null;
                }
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFe74c3c),
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _handleSelectTruck(FoodTruck truck) {
    setState(() {
      _selectedTruck = truck;
    });
  }

  void _handleEditTruck(FoodTruck truck) {
    setState(() {
      _editingTruck = truck;
      _showForm = false;
    });
  }

  void _handleCancel() {
    setState(() {
      _editingTruck = null;
      _showForm = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive layout: use row for wide screens, column for narrow
                final isWideScreen = constraints.maxWidth > 900;

                if (isWideScreen) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildLeftPanel(),
                      ),
                      Expanded(
                        flex: 3,
                        child: _buildRightPanel(),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: _buildLeftPanel(),
                      ),
                      Expanded(
                        flex: 2,
                        child: _buildRightPanel(),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(
          right: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Food Trucks (${_trucks.length})',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2c3e50),
                  ),
                ),
                if (!_showForm && _editingTruck == null)
                  ElevatedButton.icon(
                    onPressed: () => setState(() => _showForm = true),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add New'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF27ae60),
                      foregroundColor: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
          if (_showForm)
            Expanded(
              child: SingleChildScrollView(
                child: FoodTruckForm(
                  onSubmit: _handleAddTruck,
                  onCancel: _handleCancel,
                ),
              ),
            ),
          if (_editingTruck != null)
            Expanded(
              child: SingleChildScrollView(
                child: FoodTruckForm(
                  initialData: _editingTruck,
                  onSubmit: _handleUpdateTruck,
                  onCancel: _handleCancel,
                ),
              ),
            ),
          if (!_showForm && _editingTruck == null)
            Expanded(
              child: FoodTruckList(
                trucks: _trucks,
                selectedTruck: _selectedTruck,
                onSelect: _handleSelectTruck,
                onEdit: _handleEditTruck,
                onDelete: _handleDeleteTruck,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRightPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: const Row(
              children: [
                Text(
                  'Map View',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2c3e50),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: MapView(
              trucks: _trucks,
              selectedTruck: _selectedTruck,
              onMarkerClick: _handleSelectTruck,
            ),
          ),
        ],
      ),
    );
  }
}
