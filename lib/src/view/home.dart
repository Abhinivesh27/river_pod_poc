import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_poc/src/provider/userdata_provider.dart';



class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override 
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(userDataProvider);
    return Scaffold(
      body: Center(
        child: data.when(
          data: (data) => Column(
            children: data.map((e) => 
            SizedBox(
              width: 500,
              height: 100,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  
                  foregroundImage: NetworkImage(
                  e.avatar ?? '',
                
                ),
                ),
                title: Text(
                      'Name: ${e.firstName}',
            
                      style: TextStyle(
              fontSize: 20,
                      ),
                    ),
                    subtitle:Text(
                      'Name: ${e.email}',
            
                      style: TextStyle(
              fontSize: 20,
                      ),
                    ),
              ),
            ),
            ).toList()
          ),

          loading: () => const SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(),
          ),

          error: (a, b) => SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          ),
        )
      ),
    );
  }
}