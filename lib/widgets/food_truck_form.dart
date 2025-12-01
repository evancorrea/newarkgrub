import 'package:flutter/material.dart';
import '../models/food_truck.dart';

class FoodTruckForm extends StatefulWidget {
  final FoodTruck? initialData;
  final Function(FoodTruck) onSubmit;
  final VoidCallback onCancel;

  const FoodTruckForm({
    super.key,
    this.initialData,
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  State<FoodTruckForm> createState() => _FoodTruckFormState();
}

class _FoodTruckFormState extends State<FoodTruckForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _cuisineController;
  late TextEditingController _descriptionController;
  late TextEditingController _ratingController;
  late TextEditingController _hoursController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _latController;
  late TextEditingController _lngController;

  String _priceRange = '\$\$';

  @override
  void initState() {
    super.initState();
    final data = widget.initialData;

    _nameController = TextEditingController(text: data?.name ?? '');
    _cuisineController = TextEditingController(text: data?.cuisine ?? '');
    _descriptionController = TextEditingController(text: data?.description ?? '');
    _ratingController = TextEditingController(text: data?.rating.toString() ?? '4.0');
    _hoursController = TextEditingController(text: data?.hours ?? '');
    _phoneController = TextEditingController(text: data?.phone ?? '');
    _addressController = TextEditingController(text: data?.location.address ?? '');
    _latController = TextEditingController(text: data?.location.lat.toString() ?? '40.735657');
    _lngController = TextEditingController(text: data?.location.lng.toString() ?? '-74.172367');

    if (data != null) {
      _priceRange = data.priceRange;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cuisineController.dispose();
    _descriptionController.dispose();
    _ratingController.dispose();
    _hoursController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final truck = FoodTruck(
        id: widget.initialData?.id ?? 0, // Will be set by parent if new
        name: _nameController.text,
        cuisine: _cuisineController.text,
        description: _descriptionController.text,
        rating: double.parse(_ratingController.text),
        priceRange: _priceRange,
        hours: _hoursController.text,
        phone: _phoneController.text,
        location: Location(
          lat: double.parse(_latController.text),
          lng: double.parse(_lngController.text),
          address: _addressController.text,
        ),
      );
      widget.onSubmit(truck);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.initialData == null ? 'Add New Food Truck' : 'Edit Food Truck',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2c3e50),
                  ),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name *',
                    hintText: 'Food truck name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _cuisineController,
                  decoration: const InputDecoration(
                    labelText: 'Cuisine Type *',
                    hintText: 'e.g., Mexican, BBQ, Italian',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a cuisine type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description *',
                    hintText: 'Describe the food truck...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _ratingController,
                        decoration: const InputDecoration(
                          labelText: 'Rating (1-5)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          final rating = double.tryParse(value);
                          if (rating == null || rating < 1 || rating > 5) {
                            return 'Enter 1-5';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _priceRange,
                        decoration: const InputDecoration(
                          labelText: 'Price Range',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: '\$', child: Text('\$ (Budget)')),
                          DropdownMenuItem(value: '\$\$', child: Text('\$\$ (Moderate)')),
                          DropdownMenuItem(value: '\$\$\$', child: Text('\$\$\$ (Premium)')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _priceRange = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _hoursController,
                  decoration: const InputDecoration(
                    labelText: 'Operating Hours *',
                    hintText: 'e.g., 11:00 AM - 9:00 PM',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter operating hours';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number *',
                    hintText: '(973) 555-0100',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Location Address *',
                    hintText: 'Street address in Newark, NJ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _latController,
                        decoration: const InputDecoration(
                          labelText: 'Latitude',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Invalid';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _lngController,
                        decoration: const InputDecoration(
                          labelText: 'Longitude',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Invalid';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: widget.onCancel,
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF27ae60),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        widget.initialData == null ? 'Add Food Truck' : 'Update Food Truck',
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
