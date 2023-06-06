import 'package:flutter/material.dart';

void main() {
  runApp(MyCustomApp());
}

class MyCustomApp extends StatefulWidget {
  @override
  State<MyCustomApp> createState() => _MyCustomAppState();
}

class _MyCustomAppState extends State<MyCustomApp> {
  // list of map of key as string and value can be dynamic

  int score = 0;
  List<Map<String, dynamic>> mcqs = [
    {
      'question': 'Who won the IPL 2023',
      'answer': 'csk',
      'options': [
        {'text': 'csk', 'color': Colors.black},
        {'text': 'mi', 'color': Colors.black},
        {'text': 'lsg', 'color': Colors.black}
      ],
      'isButtonEnabled': 'true'
    },
    {
      'question': 'Who won the IPL 2022',
      'answer': 'gt',
      'options': [
        {'text': 'csk', 'color': Colors.black},
        {'text': 'gt', 'color': Colors.black},
        {'text': 'lsg', 'color': Colors.black}
      ],
      'isButtonEnabled': 'true'
    },
    {
      'question': 'What is the capital of France?',
      'answer': 'Paris',
      'options': [
        {'text': 'Paris', 'color': Colors.black},
        {'text': 'London', 'color': Colors.black},
        {'text': 'Berlin', 'color': Colors.black}
      ],
      'isButtonEnabled': 'true'
    },
  ];

  void handleAnswer(question, ans, indexToChangeColor) {
    for (int i = 0; i < mcqs.length; i++) {
      if (mcqs[i]['question'] == question) {
        // mcqs[i]['isButtonEnabled'] = false;

        if (ans == mcqs[i]['answer']) {
          print('right answer');
          setState(() {
            score += 1;
            mcqs[i]['options'][indexToChangeColor]['color'] = Colors.green;
          });
          print(score);
        } else {
          print('wrong answer');
          setState(() {
            mcqs[i]['options'][indexToChangeColor]['color'] = Colors.red;
          });
        }
        mcqs[i]['isButtonEnabled'] = 'false';
      }
    }
  }

  void resetQuiz() {
    setState(() {
      score = 0;
      for (int j = 0; j < mcqs.length; j++) {
        mcqs[j]['isButtonEnabled'] = 'true';
        for (int k = 0; k < 3; k++) {
          mcqs[j]['options'][k]['color'] = Colors.black;
        }
      }
    });
    print('score is reset!');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.refresh),
              color: Colors.black,
              onPressed: resetQuiz,
            ),
            title: Text(
              'Quiz App',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'score : $score',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  for (var quizQues in mcqs)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: Text(
                              quizQues['question'].toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          if (quizQues['options'] != null)
                            for (int j = 0; j < quizQues['options'].length; j++)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 6),
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>((states) {
                                          if (states.contains(
                                              MaterialState.disabled)) {
                                            return quizQues['options'][j][
                                                'color']; // Set the disabled color
                                          }
                                          return quizQues['options'][j][
                                              'color']; // Set the enabled color
                                        }),
                                        foregroundColor: MaterialStateProperty
                                            .all<Color>(Colors
                                                .white), // Set the text color
                                      ),
                                      onPressed:
                                          quizQues['isButtonEnabled'] == 'true'
                                              ? () => handleAnswer(
                                                  quizQues['question'],
                                                  quizQues['options'][j]['text']
                                                      .toString(),
                                                  j)
                                              : null,
                                      child: Text(
                                        quizQues['options'][j]['text']
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    )),
                              ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
