import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pahlawan_indonesia/components/item_card.dart';
import 'package:pahlawan_indonesia/models/pahlawan.dart';
import 'package:pahlawan_indonesia/screens/detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pahlawan> pahlawans = [];
  List<Pahlawan> filteredPahlawans = [];
  String kategori = "Semua";
  Future<String> loadJsonData() async {
    return await rootBundle.loadString('pahlawan.json');
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    String jsonData = await loadJsonData();
    List<dynamic> data = json.decode(jsonData);

    List<Pahlawan> list = data.map((json) => Pahlawan.fromJson(json)).toList();
    setState(() {
      pahlawans = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double count = size.width / 300;

    filteredPahlawans = kategori == "Semua"
        ? pahlawans
        : pahlawans
            .where((person) =>
                person.kategori!.toLowerCase().contains(kategori.toLowerCase()))
            .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pahlawan Indonesia',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: PahlawanSearch(pahlawans));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildKategoriSection(),
          Expanded(
            flex: 1,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: count.toInt() + 1),
                itemCount: filteredPahlawans.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = filteredPahlawans[index];
                  return ItemCard(item: item, size: size);
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildKategoriSection() {
    List<String> kategoris = [
      "Semua",
      "Pahlawan Proklamator",
      "Pahlawan Nasional",
      "Pahlawan Kemerdekaan Nasional",
      "Pahlawan Revolusi",
    ];
    return SizedBox(
      height: 50.0,
      child: Center(
        child: ListView.builder(
          primary: false,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: kategoris.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            String kat = kategoris[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: kat == kategori
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          kategori = kategori;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      child: Text(kat),
                    )
                  : OutlinedButton(
                      onPressed: () {
                        setState(() {
                          kategori = kat;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      child: Text(kat),
                    ),
            );
          },
        ),
      ),
    );
  }
}

class PahlawanSearch extends SearchDelegate<String> {
  final List<Pahlawan> pahlawan;

  PahlawanSearch(this.pahlawan);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSearchResults();
  }

  Widget buildSearchResults() {
    final List<Pahlawan> searchResults = query.isEmpty
        ? pahlawan
        : pahlawan
            .where((person) =>
                person.nama!.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        Pahlawan item = searchResults[index];
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Detail(
                    item: item,
                  );
                },
              ),
            );
          },
          title: Text(item.nama!),
          subtitle: Text(item.kategori!),
        );
      },
    );
  }
}
