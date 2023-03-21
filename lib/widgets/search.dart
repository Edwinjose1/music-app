import 'package:flutter/material.dart';
import 'package:music_app/screens/SearchScreen.dart';

class DiscoverMusic extends StatelessWidget {
  const DiscoverMusic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Welcome',
              
                style: Theme.of(context).textTheme.bodyLarge,
                
              ),
              SizedBox(width: 10,),
              Text("Edusac",style:TextStyle(color: Color.fromARGB(66, 192, 163, 163)),)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ));
              },
              child: Container(
                height: 50,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Icon(Icons.search),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Search Songs',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
