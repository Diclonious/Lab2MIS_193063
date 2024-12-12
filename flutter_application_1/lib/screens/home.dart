import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/joke_type.dart';
import '../widgets/joke_card.dart';
import 'joke_list_screen.dart';
import 'random_joke.dart';
import '../models/joke.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<JokeType>> jokeTypes;

  @override
  void initState() {
    super.initState();
    jokeTypes = ApiService.fetchJokeTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke Types'),
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: () async {
              final randomJoke = await ApiService.fetchRandomJoke();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RandomJokeScreen(joke: randomJoke),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<JokeType>>(
        future: jokeTypes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final types = snapshot.data!;
            return ListView.builder(
              itemCount: types.length,
              itemBuilder: (context, index) {
                return JokeCard(
                  type: types[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            JokeListScreen(jokeType: types[index].type),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
