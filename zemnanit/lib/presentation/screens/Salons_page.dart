// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemnanit/Application/booking_bloc/booking_bloc.dart';
import 'package:zemnanit/Application/booking_bloc/booking_state.dart';
import 'package:zemnanit/Application/salons/salons_bloc.dart';
import 'package:zemnanit/Infrastructure/Models/booking_model.dart';
import 'package:zemnanit/Infrastructure/Repositories/books_repo.dart';
import 'package:zemnanit/Infrastructure/Repositories/salons_repo.dart';
import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';

void main() {
  MultiBlocProvider(
    providers: [
      BlocProvider<SalonsBloc>(create: (context) => SalonsBloc(SalonsRepo())),
      BlocProvider<BookingBloc>(
          create: (context) => BookingBloc(BookingRepo())),
    ],
    child: SalonPage(),
  );
}

class SalonPage extends StatefulWidget {
  const SalonPage({super.key});

  @override
  State<SalonPage> createState() => _SalonPageState();
}

class _SalonPageState extends State<SalonPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SalonsBloc>().add(SalonsInitialFetchEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: BlocConsumer<SalonsBloc, SalonsState>(
        listenWhen: (previous, current) => current is SalonsActionState,
        buildWhen: (previous, current) => current is! SalonsActionState,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SalonsLoaded) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SalonSuccessful) {
            return SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 50, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Text("View all"), Icon(Icons.arrow_right)],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.salons.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                color: Colors.deepOrange[200],
                                margin: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.cut),
                                        SizedBox(width: 10),
                                        Text(
                                          state.salons[index].name,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.lock_clock),
                                        SizedBox(width: 10),
                                        Text(
                                          state.salons[index].location,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_month),
                                        SizedBox(width: 10),
                                        Image.network(
                                          state.salons[index].picturePath,
                                        ),
                                        Text(
                                          state.salons[index].picturePath,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
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
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
