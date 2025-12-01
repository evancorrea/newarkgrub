import 'package:flutter/material.dart';
import '../models/food_truck.dart';
import 'food_truck_card.dart';

class FoodTruckList extends StatelessWidget {
  final List<FoodTruck> trucks;
  final FoodTruck? selectedTruck;
  final Function(FoodTruck) onSelect;
  final Function(FoodTruck) onEdit;
  final Function(int) onDelete;

  const FoodTruckList({
    super.key,
    required this.trucks,
    this.selectedTruck,
    required this.onSelect,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (trucks.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'No food trucks found. Add one to get started!',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF7f8c8d),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trucks.length,
      itemBuilder: (context, index) {
        final truck = trucks[index];
        return FoodTruckCard(
          truck: truck,
          isSelected: selectedTruck?.id == truck.id,
          onSelect: () => onSelect(truck),
          onEdit: () => onEdit(truck),
          onDelete: () => onDelete(truck.id),
        );
      },
    );
  }
}
