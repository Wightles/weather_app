import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _suggestions = [];

  final List<Map<String, String>> _popularCities = [
    {'name': 'London', 'country': 'UK'},
    {'name': 'Paris', 'country': 'France'},
    {'name': 'New York', 'country': 'USA'},
    {'name': 'Tokyo', 'country': 'Japan'},
    {'name': 'Moscow', 'country': 'Russia'},
    {'name': 'Berlin', 'country': 'Germany'},
    {'name': 'Sydney', 'country': 'Australia'},
    {'name': 'Dubai', 'country': 'UAE'},
  ];

  void _updateSuggestions(String query) {
    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }

    setState(() {
      _suggestions = _popularCities
          .where((city) =>
              city['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4DB6AC),
        elevation: 0,
        title: Text(
          'Search City',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF4DB6AC).withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: CupertinoTextField(
                  controller: _controller,
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      CupertinoIcons.search,
                      color: Color(0xFF4DB6AC),
                    ),
                  ),
                  padding: EdgeInsets.all(16),
                  placeholder: 'Enter City Name',
                  placeholderStyle: TextStyle(
                    color: Color(0xFF4DB6AC).withOpacity(0.5),
                  ),
                  style: TextStyle(
                    color: Color(0xFF00796B),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onChanged: (value) {
                    cityName = value;
                    _updateSuggestions(value);
                  },
                ),
              ),
              SizedBox(height: 20),
              if (_suggestions.isNotEmpty)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF4DB6AC).withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        final city = _suggestions[index];
                        return ListTile(
                          leading: Icon(
                            CupertinoIcons.location_solid,
                            color: Color(0xFF4DB6AC),
                          ),
                          title: Text(
                            city['name']!,
                            style: TextStyle(
                              color: Color(0xFF00796B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            city['country']!,
                            style: TextStyle(
                              color: Color(0xFF4DB6AC),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context, city['name']);
                          },
                        );
                      },
                    ),
                  ),
                ),
              if (_suggestions.isEmpty && _controller.text.isEmpty)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.location_solid,
                        size: 64,
                        color: Color(0xFF4DB6AC).withOpacity(0.3),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Enter city name to search',
                        style: TextStyle(
                          color: Color(0xFF4DB6AC),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: CupertinoButton(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFF4DB6AC),
                  child: Text(
                    'Get Weather',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    if (cityName.isNotEmpty) {
                      Navigator.pop(context, cityName);
                    } else {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text('Error'),
                          content: Text('Please enter a city name'),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('OK'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}