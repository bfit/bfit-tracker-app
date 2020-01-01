class Goal {
  final double bmi;
  final double weight;
  final int courses;
  final double gym;

  Goal({this.bmi, this.weight, this.courses, this.gym});

  factory Goal.fromJson(Map<String, dynamic> data) {
    return Goal(
      bmi: data['bmi'] + .0,
      weight: data['weight'] + .0,
      courses: data['courses'],
      gym: data['gym'] + .0,
    );
  }

  double getBmi() {
    return this.bmi;
  }

  double getWeight() {
    return this.weight;
  }

  int getCourses() {
    return this.courses;
  }

  double getGym() {
    return this.gym;
  }
}