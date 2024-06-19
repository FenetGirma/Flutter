import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemnanit/Application/booking_bloc/booking_state.dart';
import 'package:zemnanit/Application/salons/salons_bloc.dart';
import 'package:zemnanit/Infrastructure/Repositories/salons_repo.dart';
import 'package:zemnanit/presentation/screens/admin/my_salon.dart';
import 'package:zemnanit/presentation/screens/booking.dart';
import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => SalonsBloc(SalonsRepo()),
    child: MaterialApp(home: MySalon()),
  ));
}

class MySalon extends StatefulWidget {
  const MySalon({super.key});

  @override
  State<MySalon> createState() => _MySalonState();
}

class _MySalonState extends State<MySalon> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<SalonsBloc>().add(SalonsInitialFetchEvent());
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: BlocConsumer<SalonsBloc, SalonsState>(
            listenWhen: (previous, current) => current is SalonsActionState,
            buildWhen: (previous, current) => current is! SalonsActionState,
            listener: (context, state) {
              if (state is SalonsDeleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('')),
                );
              } else if (state is SalonDeletionErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              if (state is SalonsLoaded) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SalonSuccessful) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 40, 50, 20),
                      child: TextField(
                        onChanged: (text) {
                          // Handle text changes
                        },
                        decoration: InputDecoration(
                          labelText: 'Search for a salon',
                          hintText: 'Zemnanit beauty Salon',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: TextEditingController(),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              2, // Adjust the number of items in each row for larger containers
                          childAspectRatio:
                              0.8, // Adjust the aspect ratio to fit your design
                          mainAxisSpacing: 16.0,
                          crossAxisSpacing: 16.0,
                        ),
                        itemCount: state.salons.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    15), // Adjusted border radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.1), // Shadow color
                                    blurRadius: 4, // Shadow blur radius
                                    offset: Offset(0, 2), // Shadow offset
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(10.0),
                              // color: Colors.deepOrange[200],
                              margin: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        state.salons[index].picturePath,
                                        width: 100,
                                        height: 100,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10),
                                      Text(
                                        state.salons[index].name.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      Text(
                                        state.salons[index].location,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BookingForm(), // Navigate to the second page
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(
                                          255, 176, 55, 11), // Background color
                                      textStyle: TextStyle(
                                          color: Colors.white), // Text color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Border radius
                                      ),
                                    ),
                                    child: Text(
                                      'Book Here',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            }));
  }
}
