import 'package:dashboard/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:dashboard/presentation/cubit/property_cubit/property_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => AdminHomePageState();
}

class AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    BlocProvider.of<PropertyCubit>(context).fetchProperties();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Manager'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0), // Adding padding
            child: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: BlocBuilder<PropertyCubit, PropertyState>(
        builder: (context, state) {
          if (state is PropertyLoading) {
            // Show a loading spinner while properties are being fetched
            return const Center(child: CircularProgressIndicator());
          } else if (state is PropertyFailure) {
            // Show an error message if there was a failure
            return Center(child: Text(state.errorMessage));
          } else if (state is PropertySuccess) {
            // Show the ListView when properties are successfully loaded
            return ListView.builder(
              itemCount: state.properties.length,
              itemBuilder: (context, index) {
                final property = state.properties[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      property.propertyName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location: ${property.location}'),
                        Text('Size: ${property.sizeSqFt} SqFt'),
                        Text('Type: ${property.propertyType}'),
                        Text('Bedrooms: ${property.noOfBedrooms}'),
                        Text('Bathrooms: ${property.noOfBathrooms}'),
                      ],
                    ),
                    trailing: Text(
                      '\AED ${property.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            // Handle any other state, e.g., initial state where there are no properties loaded yet
            return const Center(child: Text('No properties found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<PropertyCubit>().fetchProperties(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
