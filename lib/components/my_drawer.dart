import 'package:flutter/material.dart';

import '../pages/settings.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //logo
          DrawerHeader(
              child: Center(
                child: Icon(
                    Icons.music_note,
                    size:40,
                    color:Theme.of(context).colorScheme.inverseSurface
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
            },
              icon:Row(
                children:[
                  Icon(Icons.home,
                  color:Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 50),
                  Text('H O M E')
                ]
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
              },
              icon:Row(
                children:[
                  Icon(Icons.settings,
                  color:Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 50,),
                  Text('S E T T I N G S')
                ]
              )
            )
          )
        ],
      ),
    );
  }
}
