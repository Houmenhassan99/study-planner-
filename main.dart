
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// STATIC: Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Study Planner',
      home: const StudyPlannerScreen(),
    );
  }
}

// STATIC: Study Planner screen
class StudyPlannerScreen extends StatefulWidget {
  const StudyPlannerScreen({super.key});

  @override
  State<StudyPlannerScreen> createState() =>
      _StudyPlannerScreenState();
}

class _StudyPlannerScreenState extends State<StudyPlannerScreen> {

  // LOGIC: Store study goals
  List<Map<String, dynamic>> goals = [
    {
      'subject': 'Mathematics',
      'hours': 3,
      'done': false,
    },
    {
      'subject': 'Programming',
      'hours': 2,
      'done': false,
    },
    {
      'subject': 'Database',
      'hours': 4,
      'done': false,
    },
  ];

  // LOGIC: Calculate total study hours
  int get totalHours {
    return goals.fold(
      0,
      (sum, goal) => sum + (goal['hours'] as int),
    );
  }

  // LOGIC: Count completed goals
  int get completedGoals {
    return goals.where((goal) => goal['done'] == true).length;
  }

  // LOGIC: Count remaining goals
  int get remainingGoals {
    return goals.where((goal) => goal['done'] == false).length;
  }

  // LOGIC: Open Add Goal screen and receive new goal
  Future<void> addGoal() async {
    final newGoal = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddGoalScreen(),
      ),
    );

    if (newGoal == null) {
      return;
    }

    setState(() {
      goals.add(newGoal);
    });
  }

  // LOGIC: Toggle goal completion
  void toggleGoal(int index) {
    setState(() {
      goals[index]['done'] = !goals[index]['done'];
    });
  }

  // LOGIC: Delete a goal
  void deleteGoal(int index) {
    setState(() {
      goals.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // STATIC: App bar
      appBar: AppBar(
        title: const Text('My Study Planner'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // STATIC: Main screen content
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // STATIC: Heading
            const Text(
              'My Study Goals',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // STATIC: Statistics summary row
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Total Hours',
                    value: '$totalHours',
                  ),
                ),
                Expanded(
                  child: StatCard(
                    title: 'Completed',
                    value: '$completedGoals',
                  ),
                ),
                Expanded(
                  child: StatCard(
                    title: 'Remaining',
                    value: '$remainingGoals',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // STATIC: Display goals or empty message
            Expanded(
              child: goals.isEmpty
                  ? const Center(
                      child: Text(
                        'No study goals yet. Add your first goal!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: goals.length,
                      itemBuilder: (context, index) {
                        final goal = goals[index];

                        return Card(
                          child: ListTile(
                            // STATIC: Subject icon
                            leading: Icon(
                              goal['subject'] == 'Mathematics'
                                  ? Icons.menu_book
                                  : goal['subject'] == 'Programming'
                                      ? Icons.computer
                                      : Icons.science,
                              color: Colors.blue,
                            ),

                            // STATIC: Subject name
                            title: Text(
                              goal['subject'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: goal['done']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: goal['done']
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),

                            // STATIC: Study hours
                            subtitle: Text(
                              'Study time: ${goal['hours']} hours',
                            ),

                            // CONNECTION: Tap to toggle completion
                            onTap: () {
                              toggleGoal(index);
                            },

                            // CONNECTION: Checkbox and delete button
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: goal['done'],
                                  onChanged: (value) {
                                    toggleGoal(index);
                                  },
                                ),

                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    deleteGoal(index);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // CONNECTION: Open Add Goal screen
      floatingActionButton: FloatingActionButton(
        onPressed: addGoal,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// STATIC: Reusable statistics card
class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// STATIC: Add Goal screen
class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {

  // LOGIC: Text controllers
  final TextEditingController subjectController =
      TextEditingController();

  final TextEditingController hoursController =
      TextEditingController();

  // LOGIC: Form key
  final _formKey = GlobalKey<FormState>();

  // LOGIC: Save and return new goal
  void saveGoal() {
    if (_formKey.currentState!.validate()) {
      final newGoal = {
        'subject': subjectController.text.trim(),
        'hours': int.parse(hoursController.text.trim()),
        'done': false,
      };

      Navigator.pop(context, newGoal);
    }
  }

  // LOGIC: Dispose controllers
  @override
  void dispose() {
    subjectController.dispose();
    hoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // STATIC: Add Goal app bar
      appBar: AppBar(
        title: const Text('Add New Goal'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // STATIC: Add Goal form
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // STATIC: Subject field
              TextFormField(
                controller: subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject Name',
                  hintText: 'Enter subject name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a subject name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // STATIC: Hours field
              TextFormField(
                controller: hoursController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Study Hours',
                  hintText: 'Enter number of hours',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter study hours';
                  }

                  final hours = int.tryParse(value.trim());

                  if (hours == null || hours <= 0) {
                    return 'Hours must be a number greater than 0';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              // CONNECTION: Save new goal
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveGoal,
                  child: const Text('Save Goal'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
