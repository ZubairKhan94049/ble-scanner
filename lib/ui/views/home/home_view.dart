import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:stacked/stacked.dart';
import 'package:ble_scanner/ui/common/app_colors.dart';
import 'package:ble_scanner/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Hello, BLE!',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        MaterialButton(
                          color: Colors.black,
                          onPressed: () => viewModel.isLoading ? null : viewModel.startScanning(),
                          child: viewModel.isLoading
                              ? const SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                                )
                              : const Text(
                                  "Scan",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 300,
                      child: StreamBuilder<List<ScanResult>>(
                        stream: viewModel.blescaneService.getDevices(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data![index];
                                return Card(
                                  child: ListTile(
                                    onTap: () => viewModel.connectToDevice(data.device),
                                    title: Text(data.device.name),
                                    subtitle: Text(data.device.id.id.toString()),
                                    trailing: Text(data.rssi.toString()),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Text("No devices found");
                          }
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
