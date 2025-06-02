import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'result_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  DateTime? _selectedDate;

  final String _historyKey = 'input_history';
  final int _maxHistorySize = 10; // Maximum number of history entries

  List<String> _inputHistory = [];
  List<String> _filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    _loadInputHistory();
    _nameController.addListener(_filterHistorySuggestions);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _nameController.removeListener(_filterHistorySuggestions);
    super.dispose();
  }

  Future<void> _loadInputHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_historyKey);

    if (history != null) {
      setState(() {
        _inputHistory = history;
        _filteredSuggestions = history;
      });
    }
  }

  Future<void> _saveInputToHistory() async {
    final prefs = await SharedPreferences.getInstance();
    if (_nameController.text.isNotEmpty && _selectedDate != null) {
      final newEntry = '${_nameController.text}|' +
          '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';

      // Add new entry to the beginning and ensure no duplicates
      _inputHistory.remove(newEntry); // Remove if exists
      _inputHistory.insert(0, newEntry); // Add to front

      // Trim history size
      if (_inputHistory.length > _maxHistorySize) {
        _inputHistory = _inputHistory.sublist(0, _maxHistorySize);
      }

      await prefs.setStringList(_historyKey, _inputHistory);
      // Update state to reflect changes (useful for immediate suggestion update, which we will add later)
      setState(() {});
    }
  }

  void _filterHistorySuggestions() {
    final query = _nameController.text.toLowerCase();
    setState(() {
      _filteredSuggestions = _inputHistory.where((entry) {
        final parts = entry.split('|');
        if (parts.length == 2) {
          final name = parts[0].toLowerCase();
          // Filter if name contains the query
          return name.contains(query);
        }
        return false; // Invalid history format
      }).toList();
      // If the query is empty, show all history
      if (query.isEmpty) {
        _filteredSuggestions = List.from(_inputHistory); // Show all if empty
      } else {
        // Add exact match to top if exists in history but not at the top
        final exactMatchIndex = _filteredSuggestions
            .indexWhere((entry) => entry.toLowerCase().startsWith(query));
        if (exactMatchIndex > 0) {
          final exactMatch = _filteredSuggestions.removeAt(exactMatchIndex);
          _filteredSuggestions.insert(0, exactMatch);
        }
      }
    });
  }

  void _selectHistoryEntry(String entry) {
    final parts = entry.split('|');
    if (parts.length == 2) {
      final name = parts[0];
      final dateString = parts[1];

      // Parse date string
      try {
        final dateParts = dateString.split('/');
        if (dateParts.length == 3) {
          final day = int.parse(dateParts[0]);
          final month = int.parse(dateParts[1]);
          final year = int.parse(dateParts[2]);
          _selectedDate = DateTime(year, month, day);

          // Fill text fields and navigate
          _nameController.text = name;
          _birthDateController.text = dateString;

          // Clear suggestions after selection
          setState(() {
            _filteredSuggestions = [];
          });

          // Navigate to result screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                name: name,
                birthDate: _selectedDate!,
              ),
            ),
          );
        }
      } catch (e) {
        print('Error parsing history date: $e');
        // Handle parsing errors
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthDateController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
    setState(() {
      _inputHistory = [];
      _filteredSuggestions = [];
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lịch sử đã được xóa.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade300,
              Colors.purple.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 24),
                        Expanded(
                          child: Text(
                            'Nhập Thông Tin',
                            style: GoogleFonts.quicksand(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          onPressed: _clearHistory,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Họ và tên',
                        labelStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.white30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    // History suggestions list
                    if (_filteredSuggestions
                        .isNotEmpty) // Only show if there are suggestions
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                        child: Text(
                          'Lịch sử gần đây:',
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (_filteredSuggestions
                        .isNotEmpty) // Only show if there are suggestions
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap:
                              true, // Use shrinkWrap for ListView inside Column
                          padding: EdgeInsets.zero, // Remove default padding
                          itemCount: _filteredSuggestions.length,
                          itemBuilder: (context, index) {
                            final entry = _filteredSuggestions[index];
                            final parts = entry.split('|');
                            final name = parts.length == 2
                                ? parts[0]
                                : entry; // Handle potential malformed entries
                            final date =
                                parts.length == 2 ? ' (${parts[1]})' : '';
                            return ListTile(
                              title: Text(
                                '$name$date',
                                style: const TextStyle(
                                    color: Colors
                                        .white70), // Style for suggestion text
                              ),
                              onTap: () => _selectHistoryEntry(entry),
                              dense: true, // Make list tile smaller
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _birthDateController,
                      style: const TextStyle(color: Colors.white),
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        labelText: 'Ngày sinh',
                        labelStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.white30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        suffixIcon: const Icon(Icons.calendar_today,
                            color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        if (_nameController.text.isNotEmpty &&
                            _birthDateController.text.isNotEmpty) {
                          _saveInputToHistory();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                name: _nameController.text,
                                birthDate: _selectedDate!,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Vui lòng nhập đầy đủ thông tin'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple.shade900,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'Xem Kết Quả',
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
