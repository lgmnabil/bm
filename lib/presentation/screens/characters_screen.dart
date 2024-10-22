import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:rm_bloc/busness_logic/cubit/characters_cubit.dart';
import 'package:rm_bloc/constants/my_colors.dart';
import 'package:rm_bloc/data/models/characters.dart';
import 'package:rm_bloc/presentation/widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late Future<List<dynamic>> allCharacters;
  late List<dynamic> searchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchFeild() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGray,
      decoration: InputDecoration(
          hintText: 'find a character',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.myGray, fontSize: 18,fontFamily: 'Roboto')),
      style: TextStyle(color: MyColors.myGray, fontSize: 18,fontFamily: 'Roboto'),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) async {
    final allCharactersList = await allCharacters;

    // If the search text is empty, reset the searched characters.
    if (searchedCharacter.isEmpty) {
      searchedForCharacters = allCharactersList;
    } else {
      searchedForCharacters = allCharactersList
          .where((character) => character.name
              .toLowerCase()
              .startsWith(searchedCharacter.toLowerCase()))
          .toList();
    }

    // Call setState to update the UI
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: MyColors.myGray,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: Icon(
              Icons.search,
              color: MyColors.myGray,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    allCharacters =
        BlocProvider.of<CharactersCubit>(context).getAllTheCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          // allCharacters = (state).characters as Future<List>;
          return buildLoadedListWidgets();
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: MyColors.myYellow,
          ));
        }
      },
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGray,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return FutureBuilder<List<dynamic>>(
        future: allCharacters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No characters found.'));
          }

          final allCharacters = snapshot.data!;
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _searchTextController.text.isEmpty
                  ? allCharacters.length
                  : searchedForCharacters.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (ctx, index) {
                return CharacterItem(
                    character: _searchTextController.text.isEmpty
                        ? allCharacters[index]
                        : searchedForCharacters[index]);
              });
        });
  }

  Widget _buildAppBarTitle() {
    return Text(
      "R&M characters ",
      style: TextStyle(
        color: MyColors.myGray,fontFamily: 'Roboto'
      ),
    );
  }
Widget buildNoInternetWidget(){
  return Center(
    child: Container(
      color: MyColors.myWhite,
      child: Column(
        children: [
          SizedBox( height: 20,),
          Text('Can\'t connect ..check internet',style: TextStyle(fontSize: 22,color: MyColors.myGray,fontFamily: 'Roboto'),),
          Image.asset('assets/images/no_internet.png')
        ],
      ),
    ));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: _isSearching ? _buildSearchFeild() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
        BuildContext context,
        List<ConnectivityResult> connectivity,
        Widget child,
      ) {
        final bool connected = !connectivity.contains(ConnectivityResult.none);
        if (connected) {
          return buildBlocWidget();
        }else{
          return buildNoInternetWidget();
        }
      },
      child:Center(
              child: CircularProgressIndicator(
            color: MyColors.myYellow,
          )),
      ),
      backgroundColor: MyColors.myGray,
    );
  }
}
