//단어 인식
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safety_voice/pages/setup_screen.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class WaveformPainter extends CustomPainter {
  final List<double> amplitudes;
  
  
  WaveformPainter({required this.amplitudes});

  @override
  void paint(Canvas canvas, Size size) {
    final purplePaint = Paint()
      ..color = Color(0xFF8B80F8)  // 보라색
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    final greyPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)  // 회색
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    final width = size.width;
    final height = size.height;
    final barWidth = (width / amplitudes.length) * 0.6; // 막대 사이 간격을 위해 0.6 곱함
    final spacing = (width / amplitudes.length) * 0.4;  // 막대 사이 간격
    
    for (var i = 0; i < amplitudes.length; i++) {
      final x = i * (barWidth + spacing);
      final centerY = height / 2;
      final barHeight = amplitudes[i] * height * 0.7;  // 전체 높이의 70%만 사용
      
      // 처음 1/3은 보라색, 나머지는 회색으로 그리기
      final paint = i < amplitudes.length / 3 ? purplePaint : greyPaint;
      
      canvas.drawLine(
        Offset(x + barWidth/2, centerY - barHeight / 2),
        Offset(x + barWidth/2, centerY + barHeight / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});  // SetupScreen을 SettingScreen으로 수정

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isEditing = false;
  bool isLearning = false;
  bool isRecording = false;
  bool isLearningCompleted = false;  // 추가
  List<double> amplitudes = List.filled(30, 0.0);
  Timer? _timer;
  List<double> waveformData = List.filled(50, 0.0);

 // 클래스 상단에 추가
  final TextEditingController wordController = TextEditingController();
  final TextEditingController recordWeeksController = TextEditingController();
  final TextEditingController recordCountController = TextEditingController();
  final TextEditingController emergencyWeeksController = TextEditingController();
  final TextEditingController emergencyCountController = TextEditingController();
  final List<TextEditingController> phoneControllers = List.generate(
    3,
    (index) => TextEditingController(
      text: index == 0 ? '112' : index == 1 ? '010-1234-5678' : '010-9876-5432',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
          title:  Text(
            '이대광님의 설정 현황',
              style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsEditScreen()),
                );
              },
              child: const Text(
                '수정',
                style: TextStyle(
                  color: Color(0xFF787878),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (!isEditing) ...[
                      Container(
                        height: 99,
                        padding: const EdgeInsets.all(26),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.centerLeft, // 🔹 왼쪽 정렬
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0), // 🔹 왼쪽 마진
                                  child: Image.asset(
                                    'assets/currentword.png',
                                    height: 20,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                '잠만',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                       Container(
                        height: 99,
                        padding: const EdgeInsets.all(26),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.centerLeft, // 🔹 왼쪽 정렬
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0), // 🔹 왼쪽 마진
                                  child: Image.asset(
                                    'assets/recordnum.png',
                                    height: 20,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                '2초 안에 3회',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),

                      ),
                      Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Color(0xFFCACACA),
                      ),
                     Container(
                        height: 99,
                        padding: const EdgeInsets.all(26),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.centerLeft, // 🔹 왼쪽 정렬
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0), // 🔹 왼쪽 마진
                                  child: Image.asset(
                                    'assets/numnum.png',
                                    height: 20,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                '4초 안에 5회',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Color(0xFFCACACA),
                      ),
                      Container(
                        padding: const EdgeInsets.all(26),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // 🔹 이미지 영역 (flex: 2)
                            Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.centerLeft, // 🔹 왼쪽 정렬
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0), // 🔹 왼쪽 마진
                                  child: Image.asset(
                                    'assets/number.png',
                                    height: 20,
                                  ),
                                ),
                              ),
                            ),

                            // 🔸 텍스트 영역 (flex: 3)
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('1번', style: TextStyle(color: Colors.black, fontSize: 14)),
                                      const SizedBox(width: 8),
                                      Text('112', style: TextStyle(color: Colors.black, fontSize: 14)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text('2번', style: TextStyle(color: Colors.black, fontSize: 14)),
                                      const SizedBox(width: 8),
                                      Text('010-1234-5678', style: TextStyle(color: Colors.black, fontSize: 14)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text('3번', style: TextStyle(color: Colors.black, fontSize: 14)),
                                      const SizedBox(width: 8),
                                      Text('010-9876-5432', style: TextStyle(color: Colors.black, fontSize: 14)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      ),
                  
                    ] else ...[
                      _buildEditView(),
                    ],
                  ],
                ),
              ),
            ),
            Container(
              height: 76,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFFFE1E1),
              child: const Center(
                child: Text(
                  '광고',
                  style: TextStyle(
                    color: Color(0xFF787878),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Material(
          elevation: 10,
          color: const Color.fromARGB(255, 58, 58, 58),
          child: BottomAppBar(
            color: const Color.fromARGB(255, 255, 255, 255),
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/listhome'),

                  child: Image.asset(
                    'assets/recordingList.png',
                    fit: BoxFit.contain,
                  ),
                ),
                GestureDetector(
                 onTap: () => Navigator.pushNamed(context, '/safezone'),

                  child: Image.asset(
                    'assets/wordRecognition2.png',
                    fit: BoxFit.contain,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/setup'),

                  child: Image.asset(
                    'assets/safeZone_word.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

Widget _buildEditView() {
  return Column(
    children: [
      Container(
        height: 139,
        padding: const EdgeInsets.all(26),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/state.png',
                  height: 20,
                ),
                const SizedBox(width: 50),
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 35),
                    child: TextField(
                      controller: wordController,
                      decoration: const InputDecoration(
                        hintText: '잠만',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
TextButton(
   onPressed: () {
     setState(() {
       isLearning = true;
       isRecording = true;
       bool isLearningCompleted = false;
       isLearningCompleted = false; // 학습 시작할 때 완료 상태 초기화
     });

     _timer?.cancel();
     
     _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
       if (mounted && isRecording) {
         setState(() {
           amplitudes = List.generate(
             30,
             (index) => 0.3 + Random().nextDouble() * 0.7,
           );
         });
       }
     });

     showDialog(
       context: context,
       barrierDismissible: false,
       builder: (BuildContext context) {
         return StatefulBuilder(
           builder: (context, setDialogState) {
             return Dialog(
               backgroundColor: Colors.white,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(20.0),
               ),
               child: Container(
                 height: 400,
                 padding: EdgeInsets.all(20),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                       children: [],
                     ),
                     Container(
                       child: Column(
                         children: [
                           Image.asset(
                             'assets/learnimage.png',
                             height: 206,
                           ),
                           Image.asset(
                             'assets/recordword.png',
                             height: 20,
                           ),
                         ],
                       ),
                     ),
                     Container(
                       height: 80,
                       child: CustomPaint(
                         painter: WaveformPainter(amplitudes: amplitudes),
                         size: Size(double.infinity, 60),
                       ),
                     ),
                     ElevatedButton(
                       onPressed: () {
                         setState(() {
                           isLearningCompleted = true;
                         });
                         Navigator.of(context).pop(); // 다이얼로그 닫기
                       },
                       style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.blue,
                         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(8),
                         ),
                       ),
                       child: Text(
                         '완료',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 16,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             );
           },
         );
       },
     ).then((_) {
       setState(() {
         isLearning = false;
         isRecording = false;
         // isLearningCompleted는 유지 (완료 버튼으로 설정된 상태 유지)
       });
       _timer?.cancel();
     });
   },
   child: Text(
     isLearningCompleted ? '학습완료!' : (isLearning ? '학습중..' : '학습하기'),
     style: TextStyle(
       color: isLearningCompleted 
         ? Colors.blue 
         : (isLearning ? Colors.green : Colors.red),
       fontSize: 16,
     ),
   ),
 ),
              ],
            ),
          ],
        ),
      ),

      Container(
        width: double.infinity,
        height: 1.0,
        color: Color(0xFFCACACA),
      ),

      Container(
        height: 99,
        padding: const EdgeInsets.all(26),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/state.png',
                  height: 20,
                ),
                const SizedBox(width: 50),
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 35),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: recordWeeksController,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: '',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '초 안에',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: recordCountController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: '',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '회',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      Container(
        width: double.infinity,
        height: 1.0,
        color: Color(0xFFCACACA),
      ),

      Container(
        height: 99,
        padding: const EdgeInsets.all(26),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/state.png',
                  height: 20,
                ),
                const SizedBox(width: 50),
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 35),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: emergencyWeeksController,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: '',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '주 안에',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: emergencyCountController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: '',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '회',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      Container(
        width: double.infinity,
        height: 1.0,
        color: Color(0xFFCACACA),
      ),

      Container(
        padding: const EdgeInsets.all(26),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/safelocation.png',
              height: 20,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('1번', style: TextStyle(color: Colors.black, fontSize: 14,)),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 165,
                      child: TextField(
                        controller: phoneControllers[0],
                        decoration: InputDecoration(
                          hintText: '112',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('2번', style: TextStyle(color: Colors.black, fontSize: 14)),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 165,
                      child: TextField(
                        controller: phoneControllers[1],
                        decoration: InputDecoration(
                          hintText: '010-1234-5678',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('3번', style: TextStyle(color: Colors.black, fontSize: 14)),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 165,
                      child: TextField(
                        controller: phoneControllers[2],
                        decoration: InputDecoration(
                          hintText: '010-9876-5432',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),

      SizedBox(height: 20),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          onPressed: () {
            setState(() => isEditing = false);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF577BE5),
            minimumSize: Size(double.infinity, 58),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            '설정값 수정하기',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      SizedBox(height: 20),
    ],
  );
}


  Widget _buildInputItem(String title, TextEditingController weeksController,
      TextEditingController countController) {
    return Container(
      padding: EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: 40,
                child: TextField(
                  controller: weeksController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '초 안에',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                width: 40,
                child: TextField(
                  controller: countController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '회',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
Widget _buildInfoItem(String title, String value) {
  return Container(
    height: 99,
    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 26),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.black12),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 120,  // 제목 영역의 너비를 고정
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    ),
  );
}
Widget _buildEmergencyContacts() {
  return Container(
    padding: EdgeInsets.all(26),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.black12),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 비상 연락망 텍스트
        Text(
          '비상 연락망',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),  // 자동으로 남는 공간을 채움
        // 번호와 전화번호
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('1번', style: TextStyle(fontSize: 20)),
                Text('  112', style: TextStyle(fontSize: 20)),  // 약간의 공백만 추가
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('2번', style: TextStyle(fontSize: 20)),
                Text('  010-1234-5678', style: TextStyle(fontSize: 20)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('3번', style: TextStyle(fontSize: 20)),
                Text('  010-9876-5432', style: TextStyle(fontSize: 20)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
  Widget _buildEmergencyContactInputs() {
    return Container(
      padding: EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '비상 연락망',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 16),
          ...List.generate(3, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text(
                    '${index + 1}번',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: phoneControllers[index],
                      keyboardType: TextInputType.phone,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    wordController.dispose();
    recordWeeksController.dispose();
    recordCountController.dispose();
    emergencyWeeksController.dispose();
    emergencyCountController.dispose();
    _timer?.cancel();
  super.dispose();
    for (var controller in phoneControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}