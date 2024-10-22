import 'package:flutter/material.dart';
import 'package:rm_bloc/constants/my_colors.dart';
import 'package:rm_bloc/data/models/characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({super.key, required this.character});

  Widget buildSliverAppBar(){

    return SliverAppBar(
      expandedHeight: 600 ,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGray,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(character.name,
        style: TextStyle(color: MyColors.myWhite,fontFamily: 'Roboto'),
        // textAlign: TextAlign.start,
      ),
      background: Hero(
        tag: character.id,
         child: Image.network(character.image,fit: BoxFit.cover,)
         ),
      )
    );
  }
Widget characterInfo(String title,String value){
  return RichText(
    maxLines:1 ,
    overflow: TextOverflow.ellipsis,
     text: TextSpan(children: [
      TextSpan(
        text: title,
        style: TextStyle( color: MyColors.myWhite ,fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'Roboto')
        
      ),
         TextSpan(
        text: value,
        style: TextStyle( color: MyColors.myWhite ,fontSize: 16,fontFamily: 'Roboto')
        
      )
     ]),
  );
}
Widget buildDivider(double endIndent){

  return Divider( color:MyColors.myYellow ,height: 30,endIndent: endIndent, thickness: 2,);
}
  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
        backgroundColor: MyColors.myGray,
        body: CustomScrollView(
          slivers: [
            buildSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 13, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo("status: ",character.status),
                      buildDivider(1),
                      characterInfo("species: ",character.species),
                      character.type.isEmpty ? Container() : buildDivider(1),
                      character.type.isEmpty ? Container() : characterInfo("type: ",character.type),
                      buildDivider(1),
                        characterInfo("origin: ",character.origin.name),
                      buildDivider(1), 
                      characterInfo("location: ",character.location.name),
                      buildDivider(1),
                      SizedBox(height: 20,)
                    ],

                  ),
                  
                ),
                      SizedBox(height: 700,)

                ]
              )
              ,)
          ],
        ),
    );
  }
}