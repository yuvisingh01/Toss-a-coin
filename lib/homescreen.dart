import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  int flipAcoin=1;
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  animate(){
    _controller=AnimationController(duration:Duration(seconds:1),vsync:this);
    _controller.forward();
    _controller.addListener(() {
      print(_controller.value);
      setState(() {

      });
    });
    _controller.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        setState((){
          flipAcoin=Random().nextInt(2)+1;
        });
        print('Completed');
        _controller.reverse();
      }
    });
  }
  void flip()
  {
    _controller.forward();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flipper'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onDoubleTap:flip,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image(
                        height: 200-(_controller.value)*200,
                          image: AssetImage('assets/images/$flipAcoin.png')
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                    }
                    return null; // Use the component's default.
                  },
                ),
              ),
              child: const Text('Flip'),
              onPressed: () {
                flip();
              },
            ),
          ],
        ),
      ),
    );
  }
}
