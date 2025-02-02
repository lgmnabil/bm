import 'package:flutter/material.dart';
import 'package:rm_bloc/constants/my_colors.dart';
import 'package:rm_bloc/constants/strings.dart';
import 'package:rm_bloc/data/models/characters.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({super.key , required this.character});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8)
      ),
      
      child:  InkWell(
        onTap: () => Navigator.pushNamed(context,characterDetailsScreen,arguments: character),
        child: GridTile(child:
        Hero(
          tag: character.id,
          child: Container(
            color: MyColors.myGray,
            child: character.image.isNotEmpty ?
            FadeInImage.assetNetwork(width: double.infinity, 
            placeholder: 'assets/images/loading_GIF.gif',
             image: character.image , fit: BoxFit.cover,)
             : Image.asset('assets/images/placeholder.gif') ,
          ),
        ),
        footer: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          color: Colors.black54,
          alignment: Alignment.bottomCenter,
          child: Text('${character.name}',style: TextStyle(height: 1.3,
          fontSize: 16,
          color: MyColors.myWhite,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto'
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
          ),
        ),
         ),
      ),
    );
  }
}