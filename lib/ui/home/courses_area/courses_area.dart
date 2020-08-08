import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/workout/workout_bloc.dart';
import 'package:bfit_tracker/models/workout.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/coval_solutions/empty_app_bar.dart';
import 'package:bfit_tracker/ui/home/courses_area/course_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesArea extends StatefulWidget {
  CoursesArea({Key key}) : super(key: key);

  @override
  _CoursesAreaState createState() => _CoursesAreaState();
}

class _CoursesAreaState extends State<CoursesArea> {
  final List<Color> colors = [mainTheme.primaryColor, mainTheme.accentColor];
  final TextEditingController textEditingController = TextEditingController();
  List<Workout> fastWorkouts = [];
  List<Workout> bodyWorkouts = [];
  bool showDetails = false;
  Workout courseSelected;

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(filterResults);
  }

  void filterResults() {
    String text = textEditingController.text.toLowerCase();
    setState(() {
      fastWorkouts = fastWorkouts
          .where((element) =>
              element.title.toString().toLowerCase().contains(text))
          .toList();

      bodyWorkouts = bodyWorkouts
          .where((element) =>
              element.title.toString().toLowerCase().contains(text))
          .toList();
    });
  }

  void hideDetails() {
    setState(() {
      this.showDetails = false;
    });
  }

  @override
  void dispose() {
    this.textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkoutBloc, WorkoutsState>(
      listener: (BuildContext context, WorkoutsState state) {},
      builder: (BuildContext context, WorkoutsState state) {
        if (!(state is CoursesDataLoaded) && state.props.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return FutureBuilder(
          future: state.props.first,
          builder:
              (BuildContext context, AsyncSnapshot<List<Workout>> snapshot) {
            if ((snapshot.connectionState == ConnectionState.none ||
                    snapshot.connectionState == ConnectionState.waiting) ||
                snapshot.data == null) {
              if (snapshot.hasError) {
                // TODO: Add Crashlytics
                print(snapshot.error);
              }

              return Center(child: CircularProgressIndicator());
            }

            // if (showDetails && courseSelected != null) {
            //   return CourseDetails(
            //       course: courseSelected, callback: this.hideDetails);
            // }

            // User hasn't searched anything, show all results (categorised)s

            if (this.textEditingController.text.isEmpty) {
              fastWorkouts = snapshot.data
                  .where((element) => element.isFast == true)
                  .toList();

              bodyWorkouts = snapshot.data
                  .where((element) => element.types.contains('body'))
                  .toList();
            }

            return Scaffold(
              appBar: EmptyAppBar(),
              backgroundColor: mainTheme.backgroundColor,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: AutoSizeText(
                        'Courses Available',
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColor.DIM_GRAY,
                        ),
                        minFontSize: 26,
                        maxFontSize: 26,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: CupertinoTextField(
                        placeholder: 'Search',
                        maxLines: 1,
                        controller: this.textEditingController,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: AutoSizeText('FAST WORKOUTS'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: AutoSizeText('Discover more >'),
                        ),
                      ],
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      itemCount: fastWorkouts.length,
                      itemBuilder: (BuildContext context, int index) {
                        // if (snapshot.data[index].courseDetail != null) {
                        //   return GestureDetector(
                        //       onTap: () {
                        //         setState(() {
                        //           courseSelected = snapshot.data[index];
                        //           showDetails = true;
                        //         });
                        //       },
                        //       child: CourseCard(
                        //         workout: snapshot.data[index],
                        //         color: colors[index % colors.length],
                        //         duration:
                        //             Duration(milliseconds: 400 * (index + 1)),
                        //       ));
                        // }

                        return WorkoutsCard(
                          smallTitle: fastWorkouts[index].getTypesString(),
                          mainTitle: fastWorkouts[index].title,
                          description: fastWorkouts[index].description,
                          imageUrl: fastWorkouts[index].imageLocation,
                          color: colors[index % colors.length],
                          duration: Duration(milliseconds: 400 * (index + 1)),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: AutoSizeText('BODY WORKOUTS'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: AutoSizeText('Discover more >'),
                        ),
                      ],
                    ),
                    Container(
                      height: 164,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8.0),
                        itemCount: bodyWorkouts.length,
                        itemBuilder: (BuildContext context, int index) {
                          // if (snapshot.data[index].courseDetail != null) {
                          //   return GestureDetector(
                          //       onTap: () {
                          //         setState(() {
                          //           courseSelected = snapshot.data[index];
                          //           showDetails = true;
                          //         });
                          //       },
                          //       child: CourseCard(
                          //         workout: snapshot.data[index],
                          //         color: colors[index % colors.length],
                          //         duration:
                          //             Duration(milliseconds: 400 * (index + 1)),
                          //       ));
                          // }

                          return Container(
                            width: 230,
                            child: WorkoutsCard(
                              smallTitle:
                                  "${bodyWorkouts[index].workouts.length} workouts",
                              mainTitle: bodyWorkouts[index].title,
                              description: bodyWorkouts[index].description,
                              imageUrl: bodyWorkouts[index].imageLocation,
                              color: colors[index % colors.length],
                              duration:
                                  Duration(milliseconds: 400 * (index + 1)),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
