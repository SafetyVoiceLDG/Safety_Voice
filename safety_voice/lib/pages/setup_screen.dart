import 'package:flutter/material.dart';
import 'package:safety_voice/pages/word_setting.dart';

// 타임테이블 버튼 추가된 SetupScreen 코드
class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  bool isSafetyEnabled = true; // 초기값 ON
  bool isAlarmEnabled = true; // 초기값 ON

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
appBar: PreferredSize(
  preferredSize: const Size.fromHeight(80), // AppBar 높이를 80으로 설정
  child: AppBar(
    automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
    title:  Text(
      '쀼의 세계님의 설정 현황',
         style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.07,
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
                  fontSize: 15,
                ),
              ),
            ),
    ],
  ),
),


     body: Column(
 children: [
   Expanded(
     child: SingleChildScrollView(
       child: Column(
         children: [
          
          
          
          Container(
             height: 99, // 높이를 99로 설정
  padding: const EdgeInsets.all(26),
  decoration: const BoxDecoration(
    border: Border(
      bottom: BorderSide(color: Colors.black12),
    ),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start, // 이미지와 스위치 사이를 왼쪽으로 정렬
    children: [
      
      // 이미지: 왼쪽에 배치
      Image.asset(
        'assets/safety.png', // 안전지대 위치 이미지 경로
        width: 87, // 이미지 크기
        height: 25, // 이미지 크기
      ),
      
      // 빈 공간: 이미지와 Switch 사이의 공간을 유지하기 위해
      const SizedBox(width: 106),

      // 스위치를 오른쪽 끝에 배치
      Expanded(
        child: Align(
          alignment: Alignment.centerRight, // 스위치를 오른쪽으로 정렬
          child: Switch(
 value: isSafetyEnabled,
 onChanged: (value) {
   setState(() => isSafetyEnabled = value);
 },
 activeColor: Colors.white, // 동그란 부분 색상
 activeTrackColor: const Color(0xFF577BE5), // 활성화됐을 때 바탕 색상
 inactiveThumbColor: Colors.white, // 비활성화됐을 때 동그란 부분 색상
 inactiveTrackColor: const Color(0xFFE6E6E6), // 비활성화됐을 때 바탕 색상
)
        ),
      ),
    ],
  ),
),
    Container(
              // margin: const EdgeInsets.symmetric(vertical: 8.0), // 여백 추가
              width: double.infinity,
              height: 1.0, // 실선 두께
              color: Color(0xFFCACACA), // 실선 색상
            ),
    // 현재 상태
    Container(
       height: 99, // 높이를 99로 설정
  padding: const EdgeInsets.all(26),
  decoration: const BoxDecoration(
    border: Border(
      bottom: BorderSide(color: Colors.black12),
    ),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start, // 이미지와 스위치 사이를 왼쪽으로 정렬
    children: [
      
      // 이미지: 왼쪽에 배치
      Image.asset(
        'assets/word.png', // 안전지대 위치 이미지 경로

        height: 25, // 이미지 크기
      ),
      
      // 빈 공간: 이미지와 Switch 사이의 공간을 유지하기 위해
      const SizedBox(width: 106),

      // 스위치를 오른쪽 끝에 배치
      Expanded(
        child: Align(
          alignment: Alignment.centerRight, // 스위치를 오른쪽으로 정렬
          child: Switch(
 value: isAlarmEnabled,
 onChanged: (value) {
   setState(() => isAlarmEnabled = value);
 },
 activeColor: Colors.white, // 동그란 부분 색상
 activeTrackColor: const Color(0xFF577BE5), // 활성화됐을 때 바탕 색상
 inactiveThumbColor: Colors.white, // 비활성화됐을 때 동그란 부분 색상
 inactiveTrackColor: const Color(0xFFE6E6E6), // 비활성화됐을 때 바탕 색상
)
        ),
      ),
    ],
  ),
),
    Container(
              // margin: const EdgeInsets.symmetric(vertical: 8.0), // 여백 추가
              width: double.infinity,
              height: 1.0, // 실선 두께
              color: Color(0xFFCACACA), // 실선 색상
            ),
      
Container(
   height: 99, // 높이를 99로 설정
  padding: const EdgeInsets.all(26),
  decoration: const BoxDecoration(
    border: Border(
      bottom: BorderSide(color: Colors.black12),
    ),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start, // 모든 요소를 왼쪽으로 정렬
    children: [
      // 이미지: 왼쪽에 배치
      Image.asset(
        'assets/state.png', // 안전지대 위치 이미지 경로

        height: 25, // 이미지 크기
      ),
      
      // 빈 공간: 이미지와 텍스트 사이의 공간을 유지하기 위해
      const SizedBox(width: 70),

      // 텍스트: 왼쪽 정렬
      Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
        children: [
          Row(
            children: [
                           Text(
 '안전지대 1번', 
 style: TextStyle(
   color: Colors.black,
   fontSize: 25, // 글자 크기 축소
 )
),
   
   
            ],
          ),
          const SizedBox(height: 4),
        
        ],
      ),
    ],
  ),
),
    Container(
              // margin: const EdgeInsets.symmetric(vertical: 8.0), // 여백 추가
              width: double.infinity,
              height: 1.0, // 실선 두께
              color: Color(0xFFCACACA), // 실선 색상
            ),

Container(
  padding: const EdgeInsets.all(26),
  decoration: const BoxDecoration(
    border: Border(
      bottom: BorderSide(color: Colors.black12),
    ),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start, // 모든 요소를 왼쪽으로 정렬
    children: [
      // 이미지: 왼쪽에 배치
      Image.asset(
        'assets/safelocation.png', // 안전지대 위치 이미지 경로
   
        height: 25, // 이미지 크기
      ),
      
      // 빈 공간: 이미지와 텍스트 사이의 공간을 유지하기 위해
      const SizedBox(width: 40),

      // 텍스트: 왼쪽 정렬
      Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
        children: [
          Row(
            children: [
                     
   
              Text('1번', style: TextStyle(color: Colors.black, fontSize: 20,)),
              const SizedBox(width: 8),
              Text('학교', style: TextStyle(color: Colors.black,fontSize: 20)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('2번', style: TextStyle(color: Colors.black,fontSize: 20)),
              const SizedBox(width: 8),
              Text('집', style: TextStyle(color: Colors.black,fontSize: 20)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('3번', style: TextStyle(color: Colors.black,fontSize: 20)),
              const SizedBox(width: 8),
              Text('부모님댁', style: TextStyle(color: Colors.black,fontSize: 20)),
            ],
          ),
        ],
      ),
    ],
  ),
),
    Container(
              // margin: const EdgeInsets.symmetric(vertical: 8.0), // 여백 추가
              width: double.infinity,
              height: 1.0, // 실선 두께
              color: Color(0xFFCACACA), // 실선 색상
            ),

       
           
         
    // 타임테이블 열기 버튼
    buildTimeTableButton(),
         Container(
              // margin: const EdgeInsets.symmetric(vertical: 8.0), // 여백 추가
              width: double.infinity,
              height: 1.0, // 실선 두께
              color: Color(0xFFCACACA), // 실선 색상
            ),

Container(
   height: 99, // 높이를 99로 설정
  padding: const EdgeInsets.all(26),
  decoration: const BoxDecoration(
    border: Border(
      bottom: BorderSide(color: Colors.black12),
    ),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start, // 모든 요소를 왼쪽으로 정렬
    children: [
      // 이미지: 왼쪽에 배치
      Image.asset(
        'assets/alrim.png', // 안전지대 위치 이미지 경로
        height: 25, // 이미지 크기
      ),
      
      // 빈 공간: 이미지와 텍스트 사이의 공간을 유지하기 위해
      const SizedBox(width: 90),

      // 텍스트: 왼쪽 정렬
      Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
        children: [
          Row(
children: [
  Padding(
    padding: const EdgeInsets.only(top: 10), // 위쪽에 10만큼의 여백 추가
    child: Text(
      '배터리 효율을 놓치지 않았습니까?', 
      style: TextStyle(
        color: Colors.black,
        fontSize: 11, // 글자 크기 축소
      ),
    ),
  ),
],

          ),
          const SizedBox(height: 4),
        
        ],
      ),
    ],
  ),
),
    Container(
              // margin: const EdgeInsets.symmetric(vertical: 8.0), // 여백 추가
              width: double.infinity,
              height: 1.0, // 실선 두께
              color: Color(0xFFCACACA), // 실선 색상
            ),


  ],
             ),
           ),
         ),
         




Container(
  height: 76, // 세로 크기 76
  padding: const EdgeInsets.all(16),
  color: const Color(0xFFFFE1E1), // 배경색 FFE1E1
  child: const Center(
    child: Text(
      '광고',
      style: TextStyle(
        color: Color(0xFF787878), // 글자 색상 787878
        fontSize: 25, // 글자 크기 25
      ),
    ),
  ),
)

     

  ],
  
),


    bottomNavigationBar: SizedBox(
        height: 70, // 하단바 세로 길이를 고정
        child: Material( // 그림자 효과를 위한 Material 추가
          elevation: 10, // 하단바 그림자 효과 추가
          color: const Color.fromARGB(255, 58, 58, 58),
          child: BottomAppBar(
            color: const Color.fromARGB(255, 194, 181, 181), // 하단바 배경색 설정
            shape: const CircularNotchedRectangle(), // 둥근 디자인 추가
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/listhome'),
              
                  child: Container(
                    child: Image.asset(
                      'assets/recordingList.png',
                      fit: BoxFit.contain, // 이미지 크기 조정
                    ),
                  ),
                ),
                GestureDetector(
                 onTap: () => Navigator.pushNamed(context, '/safezone'),

                  child: Container(
                    child: Image.asset(
                      'assets/wordRecognition.png',
                      fit: BoxFit.contain, // 이미지 크기 조정
                    ),
                  ),
                ),
                GestureDetector(
                 onTap: () => Navigator.pushNamed(context, '/setup'),
                  child: Container(
                    child: Image.asset(
                      'assets/safeZone.png',
                      fit: BoxFit.contain, // 이미지 크기 조정
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      

    );
  }

  // 타임테이블 열기 버튼 공통 위젯
  Widget buildTimeTableButton() {
    return Container(
 padding: const EdgeInsets.all(26),
 decoration: const BoxDecoration(
   border: Border(bottom: BorderSide(color: Colors.black12)),
 ),
 child: Row(
   mainAxisAlignment: MainAxisAlignment.start,
   children: [
     Image.asset(
       'assets/safetime.png',

       height: 25,
     ),
     const SizedBox(width: 40),
     Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Row(
           children: [
             Text('1번', style: TextStyle(color: Colors.black,fontSize: 20)),
             const SizedBox(width: 8),
             GestureDetector(
               onTap: () => showModalBottomSheet(
                 context: context,
                 isScrollControlled: true,
                   builder: (_) => TimeTableModal(safeZone: '안전지대 1번'),
               ),
               child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                 decoration: BoxDecoration(
                   color: Colors.grey[200],
                   borderRadius: BorderRadius.circular(4),
                 ),
                child: const Text(
  '타임 테이블 열람',
  style: TextStyle(fontSize: 15),
),

               ),
               
             ),
           ],
         ),
         const SizedBox(height: 8),
         Row(
           children: [
             Text('2번', style: TextStyle(color: Colors.black,fontSize: 20)),
             const SizedBox(width: 8),
             GestureDetector(
               onTap: () => showModalBottomSheet(
                 context: context,
                 isScrollControlled: true,
                  builder: (_) => TimeTableModal(safeZone: '안전지대 2번'),
               ),
               child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                 decoration: BoxDecoration(
                   color: Colors.grey[200],
                   borderRadius: BorderRadius.circular(4),
                 ),
                child: const Text(
  '타임 테이블 열람',
  style: TextStyle(fontSize: 15),
),

               ),
             ),
           ],
         ),
         const SizedBox(height: 8),
         Row(
           children: [
             Text('3번', style: TextStyle(color: Colors.black,fontSize: 20)),
             const SizedBox(width: 8),
             GestureDetector(
               onTap: () => showModalBottomSheet(
                 context: context,
                 isScrollControlled: true,
                  builder: (_) => TimeTableModal(safeZone: '안전지대 3번'),
               ),
               child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                 decoration: BoxDecoration(
                   color: Colors.grey[200],
                   borderRadius: BorderRadius.circular(4),
                 ),
                 child: const Text(
  '타임 테이블 열람',
  style: TextStyle(fontSize: 15),
),

               ),
             ),
           ],
         ),
       ],
     ),
   ],
 ),
);

  }


  // SwitchListTile 공통 위젯
  Widget buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: SwitchListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  // 일반 정보 표시 공통 위젯
  Widget buildInfoRow(String title, String content) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            content,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  // 하단 메뉴 공통 위젯
  Widget buildBottomMenuItem(String top, String bottom) {
    return Column(
      children: [
        Text(top),
        Text(bottom),
      ],
    );
  }
}



class TimeTableModal extends StatefulWidget {
  final String safeZone; // 안전지대 번호를 저장할 변수

  const TimeTableModal({super.key, required this.safeZone});

  @override
  State<TimeTableModal> createState() => _TimeTableModalState();
}

class _TimeTableModalState extends State<TimeTableModal> {
  final Set<String> selected = {};
  final List<String> days = ['일', '월', '화', '수', '목', '금', '토'];
  final List<int> times = List.generate(24, (index) => index + 1);

  void toggleCell(int timeIdx, int dayIdx) {
    if (!mounted) return;
    setState(() {
      final cellId = '$timeIdx-$dayIdx';
      if (selected.contains(cellId)) {
        selected.remove(cellId);
      } else {
        selected.add(cellId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '타임 테이블', // 전달받은 안전지대 번호 표시
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF577BE5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '저장',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '${widget.safeZone} ', // 전달받은 안전지대 번호 표시
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.grey[50],
            child: Row(
              children: [
                const SizedBox(width: 40),
                ...days.map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: times.length,
              itemBuilder: (context, timeIdx) {
                return Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Center(
                        child: Text(
                          '${times[timeIdx]}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    ...List.generate(days.length, (dayIdx) {
                      final cellId = '$timeIdx-$dayIdx';
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => toggleCell(timeIdx, dayIdx),
                          child: Container(
                            margin: const EdgeInsets.all(1),
                            width: 52,
                            height: 36,
                            decoration: BoxDecoration(
                              color: selected.contains(cellId)
                                  ? const Color(0xFF577BE5)
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsEditScreen extends StatefulWidget {
  @override
  _SettingsEditScreenState createState() => _SettingsEditScreenState();
}

class _SettingsEditScreenState extends State<SettingsEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
     appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // AppBar 높이를 80으로 설정
        child: AppBar(
        backgroundColor: Colors.white,
        
    
      title: Text(
 '설정값 수정',
 style: TextStyle(
   fontWeight: FontWeight.bold,
   fontSize: MediaQuery.of(context).size.width * 0.07,
 ),
),
   
      ),
     ),
     body: Padding(
 padding: const EdgeInsets.symmetric(horizontal: 0.0),
 child: SingleChildScrollView(
   child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
Container(
  padding: const EdgeInsets.symmetric(horizontal: 15.0),
  width: double.infinity,
  height: 180,
  color: Colors.transparent,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSafeZoneTitle('안전지대 1번'),
      buildLocationRow('위치', '주소를 입력해 주세요'),
      buildTimeRow('시간', '안전지대 1번'),
    ],
  ),
),

       Container(
         width: double.infinity,
         height: 1,
         color: const Color(0xFFCACACA),
       ),
       
Container(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
  width: double.infinity,
  height: 180,
  color: Colors.transparent,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSafeZoneTitle('안전지대 2번'),
      buildLocationRow('위치', '주소를 입력해 주세요'),
      buildTimeRow('시간', '안전지대 2번'),
    ],
  ),
),

       Container(
         width: double.infinity,
         height: 1,
         color: const Color(0xFFCACACA),
       ),
       
    Container(
       padding: const EdgeInsets.symmetric(horizontal: 15.0),
  width: double.infinity,
  height: 180,
  color: Colors.transparent,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSafeZoneTitle('안전지대 2번'),
      buildLocationRow('위치', '주소를 입력해 주세요'),
      buildTimeRow('시간', '안전지대 3번'),
    ],
  ),
),

       Container(
         width: double.infinity,
         height: 1,
         color: const Color(0xFFCACACA),
       ),


Container(
  width: double.infinity,
  height: 99,
  color: Colors.transparent,
  padding: const EdgeInsets.symmetric(horizontal: 15.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      // 왼쪽에 이미지
      Padding(
        padding: const EdgeInsets.only(right: 0.0), // 이미지와 텍스트 사이 간격 없애기
        child: Image.asset(
          'assets/battery_icon.png', // 이미지 경로
          height: 25,
        ),
      ),
      // 오른쪽에 텍스트
      Padding(
        padding: const EdgeInsets.only(left: 26.0), // 텍스트와 이미지 사이 간격 없애기
        child: buildBatteryEfficiencyRow('배터리 효율을 높이시겠습니까?'),
      ),
    ],
  ),
),
     Container(
              // margin: const EdgeInsets.symmetric(vertical: 8.0), // 여백 추가
              width: double.infinity,
              height: 1.0, // 실선 두께
              color: Color(0xFFCACACA), // 실선 색상
            ),
       const SizedBox(height: 50),
       
      Center(
  child: ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF577BE5), // 버튼 배경 색상
      minimumSize: const Size(350, 58), // 버튼 크기 (가로 350, 세로 58)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 모서리 둥글게
      ),
    ),
    child: const Text(
      '설정값 수정하기',
      style: TextStyle(
        fontSize: 28, // 글자 크기 28
        color: Colors.white, // 글자 색상 흰색
      ),
    ),
  ),
)
,
       
       const SizedBox(height: 16),
    Container(

  height: 76, // 세로 크기 76
  padding: const EdgeInsets.all(16),
  color: const Color(0xFFFFE1E1), // 배경색 FFE1E1
  child: const Center(
    child: Text(
      '광고',
      style: TextStyle(
        color: Color(0xFF787878), // 글자 색상 787878
        fontSize: 25, // 글자 크기 25
      ),
    ),
  ),
)

     ],
   ),
 ),
),
 
    );
  }

Widget buildSafeZoneTitle(String title) {
 String imagePath;
 switch(title) {
   case '안전지대 1번':
     imagePath = 'assets/safezone1.png';
     break;
   case '안전지대 2번':
     imagePath = 'assets/safezone2.png';
     break;
   case '안전지대 3번':
     imagePath = 'assets/safezone3.png';
     break;
   default:
     imagePath = 'assets/safezone.png';
 }
 
 return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
  //  padding: const EdgeInsets.only(top: 32.0), 
   child: Image.asset(
     imagePath,
     height: 25,
   ),
 );
}
Widget buildLocationRow(String label, String hint) {
  return Row(
    children: [
      SizedBox(
        width: 50,
        child: Text(label, style: const TextStyle(fontSize: 25)),
      ),
      const SizedBox(width: 16),
      Padding(
        padding: const EdgeInsets.only(right: 8.0), // 마진 값 조정
        child: Container(
          width: 228,
          height: 27,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF787878),
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 8),
      TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFD9D9D9),
          minimumSize: const Size(67, 27),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.zero,
        ),
        child: const Text(
          '주소 검색',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    ],
  );
}
Widget buildBatteryEfficiencyRow(String hint) {
  return Row(
    children: [
      const SizedBox(width: 0), // 레이블 없이 빈 공간을 없앰
      const SizedBox(width: 16),
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          width: 228,
          height: 27,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF787878),
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildTimeRow(String label, String safeZone) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(label, style: const TextStyle(fontSize: 25)),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => TimeTableModal(safeZone: safeZone), // 안전지대 번호 전달
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFD9D9D9),
            minimumSize: const Size(110, 27),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.zero,
          ),
          child: const Text(
            '타임 테이블 작성',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
      ],
    ),
  );
}


Widget buildTextRow(String label, String hint) {
  return Container(
    height: 50, // 높이 조정
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // 패딩 값 조정
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey[300]!),
      borderRadius: BorderRadius.circular(4),
    ),
    child: TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
      ),
    ),
  );
}

}