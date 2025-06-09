import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/meal.dart';
import '../providers/meal_provider.dart';

class MealEntryScreen extends ConsumerStatefulWidget {
  const MealEntryScreen({super.key});

  @override
  ConsumerState<MealEntryScreen> createState() => _MealEntryScreenState();
}

class _MealEntryScreenState extends ConsumerState<MealEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _type = 'Breakfast';
  DateTime _selectedDate = DateTime.now();
  File? _image;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  void _saveMeal() async {
    if (_formKey.currentState!.validate() && _image != null) {
      final addMeal = ref.read(addMealProvider);
      final meal = Meal(
        name: _nameController.text,
        type: _type,
        date: _selectedDate,
        imagePath: _image!.path,
      );
      await addMeal(meal);
      _formKey.currentState!.reset();
      setState(() => _image = null);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Meal saved successfully!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Add Meal', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Meal Name'),
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Please enter a meal name' : null,
                ),
                DropdownButtonFormField<String>(
                  value: _type,
                  items:
                      ['Breakfast', 'Lunch', 'Dinner', 'Snack']
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (value) => setState(() => _type = value!),
                  decoration: const InputDecoration(labelText: 'Meal Type'),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Text('Date: '),
                      Text(_selectedDate.toLocal().toString().split(' ')[0]),
                    ],
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Pick Image'),
                ),
                if (_image != null) Image.file(_image!, height: 150),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveMeal,
                  child: const Text('Save Meal'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
