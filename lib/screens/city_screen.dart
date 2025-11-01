import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _suggestions = [];

  final List<Map<String, String>> _popularCities = [
    {'name': 'London', 'country': 'United Kingdom'},
    {'name': 'Paris', 'country': 'France'},
    {'name': 'New York', 'country': 'United States'},
    {'name': 'Tokyo', 'country': 'Japan'},
    {'name': 'Moscow', 'country': 'Russia'},
    {'name': 'Berlin', 'country': 'Germany'},
    {'name': 'Sydney', 'country': 'Australia'},
    {'name': 'Dubai', 'country': 'UAE'},
    {'name': 'Madrid', 'country': 'Spain'},
    {'name': 'Rome', 'country': 'Italy'},
    {'name': 'Beijing', 'country': 'China'},
    {'name': 'Mumbai', 'country': 'India'},
    {'name': 'Los Angeles', 'country': 'USA'},
    {'name': 'Toronto', 'country': 'Canada'},
    {'name': 'Singapore', 'country': 'Singapore'},
    {'name': 'Novosibirsk', 'country': 'Russia'},
    {'name': 'Saint Petersburg', 'country': 'Russia'},
    {'name': 'Yekaterinburg', 'country': 'Russia'},
    {'name': 'Kazan', 'country': 'Russia'},
    {'name': 'Chicago', 'country': 'USA'},
    {'name': 'Miami', 'country': 'USA'},
    {'name': 'Seattle', 'country': 'USA'},
    {'name': 'Berlin', 'country': 'Germany'},
    {'name': 'Munich', 'country': 'Germany'},
    {'name': 'Hamburg', 'country': 'Germany'},
    {'name': 'Kyiv', 'country': 'Ukraine'},
    {'name': 'Warsaw', 'country': 'Poland'},
    {'name': 'Prague', 'country': 'Czech Republic'},
    {'name': 'Vienna', 'country': 'Austria'},
    {'name': 'Budapest', 'country': 'Hungary'},
  ];

  void _updateSuggestions(String query) {
    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }

    final queryLower = query.toLowerCase();
    
    // Поиск точных совпадений и частичных совпадений
    setState(() {
      _suggestions = _popularCities
          .where((city) {
            final cityNameLower = city['name']!.toLowerCase();
            // Проверяем, начинается ли название города с введенного текста
            return cityNameLower.startsWith(queryLower) || 
                   cityNameLower.contains(queryLower);
          })
          .toList()
        ..sort((a, b) {
          final aName = a['name']!.toLowerCase();
          final bName = b['name']!.toLowerCase();
          
          // Сначала показываем города, которые начинаются с запроса
          final aStartsWith = aName.startsWith(queryLower);
          final bStartsWith = bName.startsWith(queryLower);
          
          if (aStartsWith && !bStartsWith) return -1;
          if (!aStartsWith && bStartsWith) return 1;
          
          // Затем сортируем по алфавиту
          return aName.compareTo(bName);
        });
    });
  }

  void _selectCity(String city) {
    Navigator.pop(context, city);
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        cityName = _controller.text;
        _updateSuggestions(_controller.text);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF47B2FF),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF47B2FF),
              Color.alphaBlend(Colors.black.withOpacity(0.1), Color(0xFF47B2FF)),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      minSize: 0,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(CupertinoIcons.back, color: Colors.white, size: 22),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 16),
                            Icon(CupertinoIcons.search, color: Colors.white.withOpacity(0.7), size: 20),
                            SizedBox(width: 12),
                            Expanded(
                              child: CupertinoTextField(
                                controller: _controller,
                                placeholder: 'Search for a city...',
                                placeholderStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 16,
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.transparent),
                                ),
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    _selectCity(value);
                                  }
                                },
                              ),
                            ),
                            if (_controller.text.isNotEmpty)
                              CupertinoButton(
                                padding: EdgeInsets.only(right: 16),
                                minSize: 0,
                                child: Icon(CupertinoIcons.xmark_circle_fill, color: Colors.white.withOpacity(0.5), size: 18),
                                onPressed: () {
                                  _controller.clear();
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_controller.text.isEmpty) {
      return _buildPopularCities();
    } else if (_suggestions.isEmpty) {
      return _buildEmptySearch();
    } else {
      return _buildSearchResults();
    }
  }

  Widget _buildPopularCities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30, left: 24, bottom: 20),
          child: Text(
            'POPULAR CITIES',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: _popularCities.length,
            itemBuilder: (context, index) {
              final city = _popularCities[index];
              return _buildCityItem(city);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptySearch() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.search,
            size: 80,
            color: Colors.white.withOpacity(0.3),
          ),
          SizedBox(height: 24),
          Text(
            'No matching cities',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Try searching for a different city name',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30, left: 24, bottom: 20),
          child: Text(
            'SEARCH RESULTS',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: _suggestions.length,
            itemBuilder: (context, index) {
              final city = _suggestions[index];
              return _buildCityItem(city);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCityItem(Map<String, String> city) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            CupertinoIcons.location_solid,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          city['name']!,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          city['country']!,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        trailing: Icon(
          CupertinoIcons.chevron_forward,
          color: Colors.white.withOpacity(0.5),
          size: 16,
        ),
        onTap: () => _selectCity(city['name']!),
      ),
    );
  }
}