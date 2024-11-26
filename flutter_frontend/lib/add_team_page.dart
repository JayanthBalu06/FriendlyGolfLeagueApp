import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/player.dart';
import 'services/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'MatchupPage.dart';
class TeamForm extends StatefulWidget {
  @override
  _TeamFormState createState() => _TeamFormState();
}

class _TeamFormState extends State<TeamForm> {

  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _memberAController = TextEditingController();
  final TextEditingController _memberAScore = TextEditingController();
  final TextEditingController _memberBController = TextEditingController();
  final TextEditingController _memberBScore = TextEditingController();

  final TextEditingController _memberCController = TextEditingController();
  final TextEditingController _memberCScore = TextEditingController();

  final TextEditingController _memberDController = TextEditingController();
  final TextEditingController _memberDScore = TextEditingController();
  bool dataUpdated = false;

  String? selectedMember;

  final List<String> teamMembers = ['a', 'b', 'c', 'd'];
 
 void _addTeam() {
    String team_name = _teamNameController.text;
    if(_memberAController.text.isNotEmpty && _memberBController.text.isNotEmpty && _memberCController.text.isNotEmpty && _memberDController.text.isNotEmpty && _teamNameController.text.isNotEmpty){
      Player playerA = Player(name: _memberAController.text, score: _memberAScore.text, team: team_name);
      Player playerB = Player(name: _memberBController.text, score: _memberBScore.text, team: team_name);
      Player playerC = Player(name: _memberBController.text, score: _memberCScore.text, team: team_name);
      Player playerD = Player(name: _memberCController.text, score: _memberDScore.text, team: team_name);
      List<Player> team_players = [playerA,playerB,playerC,playerD];
      ApiService().createMultiplePlayers(team_players).then((_) {
        dataUpdated = true;
        //If I want it to update and display the teams after I make the post request I need the setState thing(Refer to main.dart implementation in)
        _memberAController.clear();
        _memberBController.clear();
        _memberCController.clear();
        _memberDController.clear();
      });
    }
    else{
       Fluttertoast.showToast(
              msg: "Please ensure all team members and a team name is specified",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
    }
  }
   

  
    
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _teamNameController,
              decoration: InputDecoration(labelText: 'Team Name'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedMember,
              hint: Text('Select Team Member'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMember = newValue;
                });
              },
              items: teamMembers.map((String member) {
                return DropdownMenuItem<String>(
                  value: member,
                  child: Text('Member $member'),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Team Members'),
            ),
            SizedBox(height: 16),
            if (selectedMember == 'a') _buildTextField(_memberAController, 'Member A Name'),
            if (selectedMember == 'a') _buildTextField(_memberAScore, 'score'),
            if (selectedMember == 'b') _buildTextField(_memberBController, 'Member B Name'),
            if (selectedMember == 'b') _buildTextField(_memberBScore, 'score'),
            if (selectedMember == 'c') _buildTextField(_memberCController, 'Member C Name'),
            if (selectedMember == 'c') _buildTextField(_memberCScore, 'score'),
            if (selectedMember == 'd') _buildTextField(_memberDController, 'Member D Name'),
            if (selectedMember == 'd') _buildTextField(_memberDScore, 'score'),
            ElevatedButton(onPressed: _addTeam, child: Text('AddTeam')),
           // if (dataUpdated  == true) ElevatedButton(onPressed: CreateRound, child: Text('Start Matchup')), This is correct implementatioon
          // ElevatedButton(onPressed: CreateRound, child: Text('Start Matchup')) // no wifi implementation

          ],
        ),
      ),
    );
  }


  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }
}