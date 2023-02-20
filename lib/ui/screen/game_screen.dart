import 'dart:math';

import 'package:batonchess/bloc/chessboard/chessboard_bloc.dart';
import 'package:batonchess/bloc/game_manager/game_manager_bloc.dart';
import 'package:batonchess/data/model/game/game_state.dart';
import 'package:batonchess/ui/widget/container_bc.dart';
import 'package:batonchess/ui/widget/player_card_bc.dart';
import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';

class GameScreen extends StatelessWidget {
  final GameState initialGameState;

  const GameScreen({super.key, required this.initialGameState});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameManagerBloc>(
          create: (BuildContext context) => GameManagerBloc(),
        ),
        BlocProvider<ChessboardBloc>(
          create: (BuildContext context) => ChessboardBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Player to move: ${initialGameState.userIdTurn}"),
        ),
        body: BottomNavLayout(
          savePageState: true,
          pages: [
            (_) => gamePage(),
            (_) => playersPage(),
          ],
          bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.brown,
            currentIndex: currentIndex,
            onTap: (index) => onTap(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'game'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'teams'),
            ],
          ),
        ),
      ),
    );
  }

  Column gamePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlocBuilder<ChessboardBloc, ChessboardState>(
          builder: (context, state) {
            return chessBoard(state, context);
          },
        ),
      ],
    );
  }

  ContainerBc chessBoard(ChessboardState state, BuildContext context) {
    return ContainerBc(
      margin: const EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          if (state is NormalChessboardState) {
            return Chessboard(
              lightSquareColor: Colors.white,
              darkSquareColor: Colors.brown,
              fen: state.fen,
              size: min(constraints.maxWidth, constraints.maxHeight),
              onMove: (move) {
                context.read<ChessboardBloc>().add(MakeMoveEvent(move));
              },
            );
          } else {
            return Text(
              (state as FinalChessboardState).finalGameState.toString(),
            );
          }
        },
      ),
    );
  }

  Widget playersPage() {
    return ListView.builder(
      itemCount: initialGameState.players.length,
      itemBuilder: (context, index) => PlayerCardBc(
        player: initialGameState.players[index],
        onTap: () {},
      ),
    );
  }
}
