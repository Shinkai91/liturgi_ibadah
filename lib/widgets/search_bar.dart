import 'package:flutter/material.dart';

class SearchBarDelegate extends SearchDelegate<String> {
  final List<String> suggestions;

  SearchBarDelegate(this.suggestions);

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
        close(context, ''); // Menutup kotak pencarian
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredSuggestions = query.isEmpty
        ? suggestions
        : suggestions
            .where(
              (suggestion) => suggestion.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();
    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        final suggestion = filteredSuggestions[index];
        return ListTile(
          title: Text(
            suggestion,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 16,
            ),
          ),
          onTap: () {
            close(context, suggestion);
          },
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor:  Colors.blueGrey, // Warna latar belakang AppBar
        titleTextStyle:  TextStyle(
          color: Color.fromARGB(255, 0, 0, 0), // Warna teks untuk judul di app bar
          fontSize: 20,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Color.fromARGB(255, 61, 61, 61)), // Warna teks petunjuk
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black), // Ganti warna garis bawah
        ),
      ),
    );
  }
}