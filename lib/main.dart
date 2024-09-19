import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:volume_controller/volume_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  int _timerMinutes = 10; // Counter for minutes

  // static const platform = MethodChannel('com.example.timer_app/volume');

  @override
  void initState() {
    super.initState();

    VolumeController().setVolume(1.0);
    // Automatically start the timer when the app launches
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel previous timer if any
    _timer = Timer(Duration(seconds: _timerMinutes), _playMusic); // Set timer based on counter
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> _playMusic() async {
    await _audioPlayer.setVolume(1.0);
    // Play local music and set it to loop
    await _audioPlayer.setSourceAsset('ringtone.m4a');
    _audioPlayer.setReleaseMode(ReleaseMode.loop); // Set the music to loop
    await _audioPlayer.resume();
  }

  Future<void> _stopMusic() async {
    await _audioPlayer.stop();
    _timer?.cancel();
    setState(() {
      isPlaying = false;
    });
  }

  Future<void> _restartMusic() async {
    await _audioPlayer.seek(Duration.zero); // Reset audio to the beginning
    await _audioPlayer.resume(); // Start playing again from the start
    setState(() {
      isPlaying = true;
    });
  }

  void _incrementTimer() {
    setState(() {
      _timerMinutes++;
    });
  }

  void _decrementTimer() {
    if (_timerMinutes > 1) {
      setState(() {
        _timerMinutes--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Эслаткич'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Таймер вақти: $_timerMinutes дақиқа',
              style: TextStyle(fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _decrementTimer,
                  icon: Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: _incrementTimer,
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _startTimer,
              child: Text('Старт', style: TextStyle(fontSize: 30),),
            ),
            if (isPlaying) ...[
              ElevatedButton(
                onPressed: _stopMusic,
                child: Text('Стоп', style: TextStyle(fontSize: 30, color: Color.fromRGBO(255, 0, 0, 1)),),
              ),
              ElevatedButton(
                onPressed: _restartMusic,
                child: Text('Қайта ишга тушириш', style: TextStyle(fontSize: 30),),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}




// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'dart:async';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TimerScreen(),
//     );
//   }
// }
//
// class TimerScreen extends StatefulWidget {
//   @override
//   _TimerScreenState createState() => _TimerScreenState();
// }
//
// class _TimerScreenState extends State<TimerScreen> {
//   Timer? _timer;
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//
//   void _startTimer() {
//     _timer?.cancel(); // Cancel previous timer if any
//     _timer = Timer(Duration(seconds: 10), _playMusic);
//     setState(() {
//       isPlaying = true;
//     });
//   }
//
//   Future<void> _playMusic() async {
//     await _audioPlayer.setSourceAsset('ringtone.m4a');
//     _audioPlayer.setReleaseMode(ReleaseMode.loop);
//     // await _audioPlayer.setSourceUrl(
//     //     'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
//     await _audioPlayer.resume();
//   }
//
//   Future<void> _stopMusic() async {
//     await _audioPlayer.stop();
//     _timer?.cancel();
//     setState(() {
//       isPlaying = false;
//     });
//   }
//
//   Future<void> _restartMusic() async {
//     await _audioPlayer.seek(Duration.zero); // Reset audio to the beginning
//     await _audioPlayer.resume(); // Start playing again from the start
//     setState(() {
//       isPlaying = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Eslatkich'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _startTimer,
//               child: Text('Eslatkichni ishga tushirish'),
//             ),
//             if (isPlaying) ...[
//               ElevatedButton(
//                 onPressed: _stopMusic,
//                 child: Text('Musiqani to`xtatish'),
//               ),
//               ElevatedButton(
//                 onPressed: _restartMusic,
//                 child: Text('Qaytadan qo`yish'),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     _audioPlayer.dispose();
//     super.dispose();
//   }
// }
