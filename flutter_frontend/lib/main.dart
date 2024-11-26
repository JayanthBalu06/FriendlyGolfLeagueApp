import 'package:flutter/material.dart';
import 'package:flutter_application_1/MatchupPage.dart';
import 'models/player.dart';
import 'services/api_service.dart';
import 'new_page.dart';
import 'add_team_page.dart';
import 'MatchupPage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Django API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Player>> futureItems;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureItems = ApiService().getPlayers();
  }

  void _navigateToNewPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewPage()),
    );
  }

  void _navigateTeamForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeamForm()), // Ensure TeamForm is defined
    );
  }

  // Function to navigate to MatchupPage
  void _navigateToMatchupPage(BuildContext context) async {
    // Await the player data from futureItems
    List<Player> players = await futureItems;

    // Navigate to the MatchupPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchupPage(players: players),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Django API'),
      ),
    
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 100,
              child: ElevatedButton(
                onPressed: _navigateTeamForm,
                child: Text(
  'Start Game',
  style: TextStyle(
    fontSize: 24.0,  // Increase this value to make the text bigger
    fontWeight: FontWeight.bold,
    color: Colors.blue, // Optional: change text color
  ),
)
              ),
            ),
            SizedBox(
              width: 300,
              height: 100,
              child: ElevatedButton(
                onPressed: () => _navigateToMatchupPage(context),
                child: Text(
  'View Matchups',
  style: TextStyle(
    fontSize: 24.0,  // Increase this value to make the text bigger
    fontWeight: FontWeight.bold,
    color: Colors.blue, // Optional: change text color
  ),
),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Player>>(
                future: futureItems,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No items found');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Player player = snapshot.data![index];
                        return ListTile(
                          title: Text(player.name + '-' + player.team),
                          subtitle: Text(player.score.toString()),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
