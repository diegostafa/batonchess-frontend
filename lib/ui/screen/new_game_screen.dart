import 'package:batonchess/ui/screen/game_screen.dart';
import 'package:flutter/material.dart';


class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => NewGameScreenState();
}

class NewGameScreenState extends State<NewGameScreen> {
  final myController = TextEditingController();
  int selectedCard = -1;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Game properties'),
        ),
        body: Column(children: [
          const Text("Start as:"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(value: false, onChanged: (b) {}),
              Checkbox(value: true, onChanged: (b) {}),
            ],
          ),
          const Text("Max players per side:"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(value: false, onChanged: (b) {}),
              Checkbox(value: true, onChanged: (b) {}),
              Checkbox(value: false, onChanged: (b) {}),
              Checkbox(value: true, onChanged: (b) {}),
            ],
          ),
          Expanded(
              child: Container(
            child: null,
          )),
          const Text("Time format:"),
          Expanded(
            flex: 4,
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GridView.builder(
                    shrinkWrap: false,
                    scrollDirection: Axis.vertical,
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 3),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // ontap of each card, set the defined int to the grid view index
                            selectedCard = index;
                          });
                        },
                        child: Card(
                          // check if the index is equal to the selected Card integer
                          color: selectedCard == index
                              ? Colors.blue
                              : Colors.amber,
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: Center(
                              child: Text(
                                '$index',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
          ),
                    Expanded(
              child: Container(
            child: null,
          )),
        ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GameScreen()),
              );
            },
            child: const Icon(Icons.gamepad)));
  }
}
