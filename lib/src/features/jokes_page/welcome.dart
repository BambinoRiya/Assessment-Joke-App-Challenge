import 'package:assestment_project/services/services.dart';
import 'package:flutter/material.dart';

class JokeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JokeListScreen(),
    );
  }
}

class JokeListScreen extends StatefulWidget {
  @override
  _JokeListScreenState createState() => _JokeListScreenState();
}

class _JokeListScreenState extends State<JokeListScreen> {
  final JokeService jokeService = JokeService();
  List<dynamic> jokes = [];
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchJokes();
  }

  Future<void> fetchJokes() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      final jokes = await jokeService.fetchJokes();
      setState(() {
        this.jokes = jokes;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Implement filter functionality
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(child: Text(error))
              : ListView.builder(
                  itemCount: jokes.length,
                  itemBuilder: (context, index) {
                    final joke = jokes[index];
                    return ListTile(
                      title: Text(joke['setup'] ?? joke['joke'] ?? ''),
                      subtitle: joke['delivery'] != null
                          ? Text(joke['delivery'])
                          : null,
                    );
                  },
                ),
    );
  }
}
