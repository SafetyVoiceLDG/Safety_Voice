import 'package:flutter/material.dart';

class TimeTableDemo extends StatefulWidget {
  const TimeTableDemo({super.key});

  @override
  State<TimeTableDemo> createState() => _TimeTableDemoState();
}

class _TimeTableDemoState extends State<TimeTableDemo> {
  final Set<String> selected = {};
  final List<String> days = ['일', '월', '화', '수', '목', '금', '토'];
  final List<int> times = List.generate(17, (index) => index + 1);

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

  void showTimeTableModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 높이를 조절 가능하게 설정
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7, // 화면에서 차지하는 초기 크기 (70%)
          minChildSize: 0.5, // 최소 크기 (50%)
          maxChildSize: 0.9, // 최대 크기 (90%)
          builder: (context, scrollController) {
            return Column(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    '타임 테이블',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.grey[300]),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
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
                TextButton(
                  onPressed: () {
                    print('Selected times: $selected');
                    Navigator.pop(context); // 모달 닫기
                  },
                  child: const Text(
                    '저장',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          '메인 화면',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => showTimeTableModal(context),
          child: const Text('타임 테이블 열기'),
        ),
      ),
    );
  }
}
