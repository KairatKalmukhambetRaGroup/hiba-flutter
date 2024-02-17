import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiba/components/butchery_card.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/utils/api/butchery.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> _butcheries = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String jsonString = await getButcheries();
    setState(() {
      _butcheries = List<Map<String, dynamic>>.from(json.decode(jsonString));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SearchAnchor(
            builder: (context, controller) {
              return SearchBar(
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
              );
            },
            suggestionsBuilder: (context, controller) {
              return List<ListTile>.generate(5, (index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });
            },
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: _butcheries.isEmpty
            ? const Text('Loading')
            : ListView.separated(
                itemBuilder: (context, index) {
                  final butchery = Butchery.fromJson(_butcheries[index]);
                  return ButcheryCard(butchery: butchery);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: _butcheries.length,
              ),
      ),
    );
  }
}
