import 'package:flutter/material.dart';
import 'package:placement/screens/additional_details_get.dart';
import 'package:placement/screens/education_info_get_screen.dart';

import 'bottom_navigation_bar_screen.dart';
import 'personal_info_get.dart';

class StepperScreen extends StatefulWidget {
  const StepperScreen({super.key});

  @override
  State<StepperScreen> createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  int currentStep = 0;
  continueStep() {
    if (currentStep == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigationBarScreen(),
        ),
      );
    }
    if (currentStep < 2) {
      setState(() {
        currentStep = currentStep + 1; //currentStep+=1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1; //currentStep-=1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: details.onStepContinue,
            child: const Text(
              'Next',
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          OutlinedButton(
            onPressed: details.onStepCancel,
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }

  Widget customButton(VoidCallback onClick) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: 175,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            const Center(
              child: Text(
                "Complete",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black38,
                ),
                width: 35,
                height: 35,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text("Stepper"),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text(
              "Register for the College Placement Drive by Filling in Your Details!",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 24),
            ),
          ),
          Stepper(
            elevation: 3, //Horizontal Impact

            controlsBuilder: controlBuilders,
            type: StepperType.vertical,
            physics: const BouncingScrollPhysics(),

            onStepTapped: onStepTapped,
            onStepContinue: continueStep,
            onStepCancel: cancelStep,
            currentStep: currentStep, //0, 1, 2
            steps: [
              Step(
                title: const Text(
                  'Step 1',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                content: Column(
                  children: [
                    const Text(
                      'First step you have to fill your Personal Details.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    customButton(
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PersonalInfoGetter(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                isActive: currentStep >= 0,
                state: currentStep == 0
                    ? StepState.editing
                    : currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
              ),
              Step(
                title: const Text(
                  'Step 2',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                content: Column(
                  children: [
                    const Text(
                      'Second step you have to fill your Education Details.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    customButton(
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EducationGetterScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                isActive: currentStep >= 1,
                state: currentStep == 1
                    ? StepState.editing
                    : currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
              ),
              Step(
                title: const Text(
                  'Step 3',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                content: Column(
                  children: [
                    const Text(
                      'Third step you have to fill your Personal Details.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    customButton(
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AdditionalDetailsGetter(),
                          ),
                        ).then((result) {
                          if (result == 'completed') {
                            // User completed all steps, navigate to BottomNavigationBarScreen
                          }
                        });
                      },
                    ),
                  ],
                ),
                isActive: currentStep >= 2,
                state: currentStep == 2
                    ? StepState.editing
                    : currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
