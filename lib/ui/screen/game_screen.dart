import 'package:batonchess/bloc/chess/chess_bloc.dart';
import 'package:batonchess/data/model/game_state.dart';
import 'package:batonchess/ui/widget/container_bc.dart';
import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';

class GameScreen extends StatefulWidget {
  final GameState? initialGameState;

  const GameScreen({super.key, this.initialGameState});

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChessBloc>(
          create: (BuildContext context) => ChessBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chess Demo'),
        ),
        body: BottomNavLayout(
          savePageState: true,
          pages: [
            (_) => gamePage(),
            (_) => playersPage(),
          ],
          bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
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
        // timers(),
        chessBoard(),
      ],
    );
  }

  Column playersPage() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) =>
                // todo :
                ContainerBc(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(4),
              child: Text("User $index"),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) => ContainerBc(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(4),
              child: Text("User $index"),
            ),
          ),
        )
      ],
    );
  }

  BlocBuilder<ChessBloc, ChessState> chessBoard() {
    return BlocBuilder<ChessBloc, ChessState>(
      builder: (context, state) {
        return Expanded(
          flex: 5,
          child: ContainerBc(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Center(
              child: LayoutBuilder(
                builder: (ctx, constraints) {
                  if (state is NormalChessState) {
                    return Chessboard(
                      lightSquareColor: Colors.white,
                      darkSquareColor: Colors.brown,
                      fen: state.fen,
                      size: constraints.maxWidth,
                      onMove: (move) {
                        context.read<ChessBloc>().add(MakeMoveEvent(move));
                      },
                    );
                  } else {
                    return Text(
                      (state as FinalChessState).finalGameState.toString(),
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
