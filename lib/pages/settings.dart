import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lermmusic/themes/themes_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('S E T T I N G S'),
        centerTitle:true
      ),
      body:Container(
        decoration:BoxDecoration(
          color:Theme.of(context).colorScheme.secondary,
          borderRadius:BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            //dart mode
            Text('Dark Mode',
            style:TextStyle(
              fontWeight:FontWeight.bold,
              fontSize:17
            )),
            //switch
            CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                onChanged: (value) => {
                  Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                })
          ]
        ),
      )

    );
  }
}
