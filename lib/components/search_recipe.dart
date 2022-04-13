import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRecipe extends SearchDelegate<String> {
  List<String> searchRecipe = [];

  void addSearchRecipe(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchRecipe = prefs.getStringList('searchRecipe') ?? [];
    searchRecipe.insert(0, value);
    await prefs.setStringList('searchRecipe', searchRecipe);
  }

  void getSearchRecipe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchRecipe = prefs.getStringList('searchRecipe') ?? [];
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != '') addSearchRecipe(query);
    return Center(
      child: Text(
        'Recipe Not Found',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    getSearchRecipe();
    final count = searchRecipe.length > 10 ? 10 : searchRecipe.length;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.history),
          title: Text(searchRecipe.elementAt(index)),
          trailing: Icon(Icons.north_west),
        );
      },
    );
  }
}