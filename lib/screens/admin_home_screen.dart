import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:placement/models/company.dart';
import 'package:placement/provider/student_provider.dart';

import '../models/student.dart';
import '../provider/company_details_provider.dart';
import '../widgets/admin_drawer.dart';

class AdminHomeScreen extends ConsumerStatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  ConsumerState<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends ConsumerState<AdminHomeScreen>
    with SingleTickerProviderStateMixin {
  // Colors for each segment of the pie chart
  final List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539),
  ];

  // List of gradients for the background of the pie chart
  final List<List<Color>> gradientList = <List<Color>>[
    [
      const Color.fromRGBO(223, 250, 92, 1),
      const Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      const Color.fromRGBO(129, 182, 205, 1),
      const Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      const Color.fromRGBO(175, 63, 62, 1.0),
      const Color.fromRGBO(254, 154, 92, 1),
    ],
  ];

  // Animation controller for scaling the chart
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Animation duration
    );
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminAppDrawer(),
      body: StreamBuilder(
        stream: ref.watch(studentInfoProvider).getAllStudentsStream(),
        builder: (context, studentSnapshot) {
          if (studentSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!studentSnapshot.hasData) {
            return const Center(
              child: Text('No Data Found from student'),
            );
          }

          if (studentSnapshot.hasError) {
            return const Center(
              child: Text('Something went wrong..'),
            );
          }

          List<StudentInfo>? allStudents = studentSnapshot.data;

          return StreamBuilder(
            stream: ref.watch(companyDetailsProvider).getAllCompaniesStream(),
            builder: (context, companySnapshot) {
              if (companySnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!companySnapshot.hasData) {
                return const Center(
                  child: Text('No Data Found from student'),
                );
              }

              if (companySnapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong..'),
                );
              }

              List<CompanyDetails>? allCompanies = companySnapshot.data;

              int numberOfStudentPlaced = allCompanies!.fold<int>(
                0,
                (previousValue, company) =>
                    previousValue + company.studentsPlaced.length,
              );

              int numberOfUnPlacedStudents =
                  allStudents!.length - numberOfStudentPlaced;

              final Map<String, double> dataMap = {
                "Student Placed":
                    double.parse(numberOfStudentPlaced.toString()),
                "Student Unplaced":
                    double.parse(numberOfUnPlacedStudents.toString()),
              };

              return CustomScrollView(
                slivers: <Widget>[
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return GridItemWidget(
                          index: index,
                          number: [
                            allStudents.length,
                            allCompanies.length,
                            numberOfStudentPlaced,
                            numberOfUnPlacedStudents,
                          ][index],
                        );
                      },
                      childCount: 4,
                    ),
                  ),
                  // Add a SliverToBoxAdapter for spacing
                  const SliverToBoxAdapter(
                    child:
                        SizedBox(height: 20.0), // Adjust the height as needed
                  ),
                  // Add the PieChart widget here
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        // Animate the center text
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            isRepeatingAnimation: true,
                            animatedTexts: [
                              TyperAnimatedText(
                                'Students Placement Data',
                                speed: const Duration(milliseconds: 150),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontSize: 28,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        // Animate the pie chart using Transform.scale
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _controller.value,
                              child: child,
                            );
                          },
                          child: PieChart(
                            // Pass in the data for the pie chart
                            dataMap: dataMap,
                            // Set the colors for the pie chart segments
                            colorList: colorList,
                            // Set the radius of the pie chart
                            chartRadius: MediaQuery.of(context).size.width / 2,
                            // Set the center text of the pie chart
                            centerText: "Students",
                            // Set the width of the ring around the pie chart
                            ringStrokeWidth: 24,
                            // Set the options for the chart values (e.g. show percentages, etc.)
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValues: true,
                              showChartValuesOutside: true,
                              showChartValuesInPercentage: true,
                              showChartValueBackground: false,
                            ),
                            // Set the options for the legend of the pie chart
                            legendOptions: const LegendOptions(
                              showLegends: true,
                              legendShape: BoxShape.circle,
                              legendTextStyle: TextStyle(fontSize: 20),
                              legendPosition: LegendPosition.bottom,
                              showLegendsInRow: true,
                            ),
                            // Set the list of gradients for the background of the pie chart
                            gradientList: gradientList,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class GridItemWidget extends StatelessWidget {
  final int index;
  final int number;

  const GridItemWidget({
    super.key,
    required this.index,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    List<String> iconPaths = [
      'assets/images/graduated.png',
      'assets/images/buildings.png',
      'assets/images/lecture.png',
      'assets/images/check-list.png',
    ];
    List<String> texts = [
      'Students',
      'Companies',
      'Students Placed',
      'Students Unplaced',
    ];

    return InkWell(
      onTap: () {
        // Add navigation or some action when tapping on a grid item
        // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen()));
      },
      child: Container(
        margin: const EdgeInsets.all(14.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              iconPaths[index],
              width: 64.0,
              height: 64.0,
            ),
            const SizedBox(height: 10.0),
            Text(
              texts[index],
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.black),
            ),
            const SizedBox(height: 5.0),
            Expanded(
              child: TweenAnimationBuilder<int>(
                tween: IntTween(
                  begin: 0,
                  end: number,
                ),
                duration: const Duration(seconds: 1),
                builder: (context, value, child) {
                  // Add '+' after the number when it reaches 500
                  final displayValue =
                      value >= 500 ? '$value+' : value.toString();
                  return Text(
                    displayValue,
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.deepPurple.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
