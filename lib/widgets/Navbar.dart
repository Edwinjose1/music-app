import 'package:flutter/material.dart';
import 'package:music_app/widgets/Nowplaying.dart';

class Navbar extends StatelessWidget {
  const Navbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      color:Colors.grey,
      child: ListTile(onTap: () {
       
      },
        title:Text('First music') ,
                subtitle: Text("subtitle"),
                leading: CircleAvatar(backgroundColor: Colors.black,radius: 30,backgroundImage:AssetImage('assets/images/songimg4.jpg') ),
                trailing: Icon(Icons.play_arrow)
      ),
    );
    
  }
   @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(500);
}