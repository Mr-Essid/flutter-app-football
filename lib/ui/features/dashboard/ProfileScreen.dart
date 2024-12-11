import 'package:flutter/material.dart';
import 'package:go_provider/go_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:project_flutter_football/main.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}




class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    final List<ItemOfProfile> listOfMenu = [
      ItemOfProfile(
        text: "Profile",
        icon: Icons.person_outline,
        onClick: () {
          // Replace with your navigation or callback logic
          print("Navigate to Profile");
        },
      ),
      ItemOfProfile(
        text: "Guide",
        icon: Icons.map,
        onClick: () {
          // Replace with your navigation or callback logic
          print("Navigate to Guide");
        },
      ),
      ItemOfProfile(
        text: "Licence",
        icon: Icons.assignment_turned_in,
        onClick: () {
          // Replace with your navigation or callback logic
          print("Navigate to Licence");
        },
      ),
      ItemOfProfile(
        text: "Policy and Privacy",
        icon: Icons.policy,
        onClick: () {
          // Replace with your navigation or callback logic
          print("Navigate to Policy and Privacy");
        },
      ),
      ItemOfProfile(
        text: "Disconnect",
        icon: Icons.exit_to_app,
        onClick: () {
          GoRouter.of(context).clearStackAndNavigate("/");
          // Replace with your sign-out logic
          print("Disconnect and sign out");
        },
      ),
    ];



    return Scaffold(
      appBar: AppBar(title: const Text("Profile"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
           children: List.of(listOfMenu).map((e) {
              return MenuItem(itemOfProfile: e);
            }
            ).toList(growable: false)
        ),
      )
      ,
    );
  }
}



class ItemOfProfile {
 IconData icon;
 String text;
 Function() onClick;
  ItemOfProfile({required this.text, required this.icon, required this.onClick});

}





class MenuItem extends StatelessWidget {
  final ItemOfProfile itemOfProfile;
  const MenuItem({
    Key? key,
    required this.itemOfProfile
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      color: Colors.transparent,
      child: InkWell(
        onTap: itemOfProfile.onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 64,
              width: 64,
              alignment: Alignment.center,
              child: Icon(
                itemOfProfile.icon,
                size: 28,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemOfProfile.text,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
