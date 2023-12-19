import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class LocationSearch extends StatefulWidget {
  const LocationSearch({super.key});

  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  // List of locations (name, lat, lon)
  List<Map<String, dynamic>> locations = [
    {
      'name': 'Нисэх',
      'lat': 47.86603585661243,
      'lon': 106.76460021333239,
    },
    {
      'name': 'Орон сууц',
      'lat': 47.85807344539858,
      'lon': 106.76212034570186,
    },
    {
      'name': 'Буянт Ухаа-1',
      'lat': 47.85676606697679,
      'lon': 106.76418690206063,
    },
    {
      'name': 'Нисэхийн дэнж',
      'lat': 47.8566472127583,
      'lon': 106.77044561560433,
    },
    {
      'name': 'ИНЕГ',
      'lat': 47.85657662238618,
      'lon': 106.77676417665295,
    },
    {
      'name': 'Буянт-Ухаа спорт цогцолбор',
      'lat': 47.857007275351044,
      'lon': 106.78253969277425,
    },
    {
      'name': '118-р сургууль',
      'lat': 47.85979728509257,
      'lon': 106.79353917840032,
    },
    {
      'name': 'Яармагийн 4-р буудал',
      'lat': 47.86188733334135,
      'lon': 106.8007401522202,
    },
    {
      'name': 'Эмнэлгийн буудал',
      'lat': 47.865356605756624,
      'lon': 106.81184620566334,
    },
    {
      'name': 'Яармагийн 3-р буудал',
      'lat': 47.86742910356292,
      'lon': 106.81893629039577,
    },
    {
      'name': 'Яармагийн 2-р буудал',
      'lat': 47.86972029158492,
      'lon': 106.82643574065561,
    },
    {
      'name': 'Яармагийн 1-р буудал',
      'lat': 47.87189922279175,
      'lon': 106.83381078462075,
    },
    {
      'name': 'Англи сургууль',
      'lat': 47.874964216432126,
      'lon': 106.8451042909394,
    },
    {
      'name': 'Хүннү Их Дэлгүүр',
      'lat': 47.87786951062765,
      'lon': 106.85226788646465,
    },
    {
      'name': 'Вива Сити',
      'lat': 47.88131404714753,
      'lon': 106.85886366650564,
    },
    {
      'name': 'MSM',
      'lat': 47.89192651494636,
      'lon': 106.87240896547864,
    },
    {
      'name': 'ЖЕМ',
      'lat': 47.894659051395884,
      'lon': 106.88062435097852,
    },
    {
      'name': 'Таван богд компани',
      'lat': 47.898169672465905,
      'lon': 106.89087244717747,
    },
    {
      'name': 'Ажилчдын соёлын ордон',
      'lat': 47.89896300201947,
      'lon': 106.89805463637765,
    },
    {
      'name': 'Төв цэнгэлдэх хүрээлэн',
      'lat': 47.90176159034773,
      'lon': 106.91031525863117,
    },
    {
      'name': 'Төв номын сан',
      'lat': 47.91440148701406,
      'lon': 106.91566585013462,
    },
    {
      'name': 'Сүхбаатарын талбай',
      'lat': 47.91673403347723,
      'lon': 106.91741553321934,
    },
    {
      'name': 'МУБИС',
      'lat': 47.91844906770752,
      'lon': 106.9238942500992,
    },
    {
      'name': 'Ард Кино Театр',
      'lat': 47.91787785824227,
      'lon': 106.91162282279583,
    },
  ];

  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> _getSuggestions(String query) {
    query = query.toLowerCase();
    return locations.where((location) {
      return location['name'].toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Enter a location',
          ),
        ),
        TypeAheadField(
          suggestionsCallback: (pattern) async {
            return _getSuggestions(pattern);
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion['name']),
            );
          },
          onSelected: (suggestion) {
            log('Selected location: ${suggestion['name']}');
          },
        ),
      ],
    );
  }
}
