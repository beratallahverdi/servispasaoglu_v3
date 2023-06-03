// create a widget with provider package
//

import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:servispasaoglu_v3/models/sample_model.dart';
import 'package:servispasaoglu_v3/providers/sample_provider.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class SampleScreen extends StatelessWidget {
  static const String id = 'SampleScreen';
  const SampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> samples = context.watch<SampleProvider>().sampleData;
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Sample Screen'),
        ),
        body: ListView.builder(
          itemCount: samples.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(samples[index].name),
              subtitle: Text(samples[index].description),
              leading: Image.network(
                samples[index].image.toString(),
              ),
              trailing: Text(samples[index].price.toString()),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Dio dio = Dio();
            Response response = await dio.get('https://picsum.photos/300');
            SampleBuilder builder = SampleBuilder();
            builder
                .withId(1)
                .withName('Sample Name')
                .withDescription('Sample Description')
                .withImage(response.realUri.toString())
                .withPrice(1000);
            if (context.mounted) {
              context.read<SampleProvider>().add(builder.build());
            }
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
