import 'package:agrolyn_web/widget/no_found_custom.dart';
import 'package:agrolyn_web/widget/spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrolyn_web/provider/harvest_calculator_notifier.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:intl/intl.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/widget/typography.dart';

class HarvestCalculatorSection extends StatelessWidget {
  const HarvestCalculatorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HarvestCalculatorNotifier(context: context),
      child: Consumer<HarvestCalculatorNotifier>(
        builder: (context, value, child) {
          return ResponsiveRowColumn(
            layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            rowCrossAxisAlignment: CrossAxisAlignment.start,
            columnCrossAxisAlignment: CrossAxisAlignment.center,
            columnMainAxisSize: MainAxisSize.min,
            rowPadding: const EdgeInsets.only(top: 100, right: 20, left: 20),
            columnPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            columnSpacing: 50,
            rowSpacing: 50,
            children: [
              // Form Section
              ResponsiveRowColumnItem(
                rowFlex: 1,
                rowFit: FlexFit.tight,
                columnOrder:
                    1, // Make sure this is displayed first on smaller screens
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: border)),
                  margin: blockMargin,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title Section
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Kalkulator Panen',
                              style: TextStyle(
                                color: MyColors.primaryColorDark,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Form Fields
                        Form(
                          key: value.keyForm,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Dropdown for plant selection
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: DropdownButton<String>(
                                    value: value.selectedPlant.isEmpty
                                        ? null
                                        : value.selectedPlant,
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        value.setChangePlant(newValue);
                                      }
                                    },
                                    items: <String>['corn', 'rice']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                // Input for price per kilogram
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: TextFormField(
                                    controller: value.hargaPerKgController,
                                    decoration: InputDecoration(
                                      labelText: 'Harga Per Kg',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Masukkan harga per kg';
                                      }
                                      if (double.tryParse(value) == null) {
                                        return 'Masukkan angka yang valid';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                // Input for field area
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: TextFormField(
                                    controller: value.luasSawahController,
                                    decoration: InputDecoration(
                                      labelText: 'Luas Sawah (m²)',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Masukkan luas sawah';
                                      }
                                      if (double.tryParse(value) == null) {
                                        return 'Masukkan angka yang valid';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                // Input for planting date using showDatePicker
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: GestureDetector(
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: value.tanggalTanam,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      if (pickedDate != null &&
                                          pickedDate != value.tanggalTanam) {
                                        value.setUpdateTanggalTanam(pickedDate);
                                      }
                                    },
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        controller: TextEditingController(
                                          text: DateFormat('yyyy-MM-dd')
                                              .format(value.tanggalTanam),
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Tanggal Tanam',
                                          border: OutlineInputBorder(),
                                        ),
                                        readOnly: true, // Cannot type, only tap
                                      ),
                                    ),
                                  ),
                                ),
                                // Button to submit the form
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: TextButton(
                                    onPressed: () async {
                                      await value.submit();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              MyColors.primaryColorDark),
                                      overlayColor:
                                          WidgetStateProperty.resolveWith<
                                              Color>((Set<WidgetState> states) {
                                        if (states
                                            .contains(WidgetState.hovered)) {
                                          return MyColors.primaryColor;
                                        }
                                        if (states.contains(
                                                WidgetState.focused) ||
                                            states.contains(
                                                WidgetState.pressed)) {
                                          return MyColors.primaryColorDark;
                                        }
                                        return MyColors.primaryColorDark;
                                      }),
                                      shape: WidgetStateProperty.resolveWith<
                                              OutlinedBorder>(
                                          (Set<WidgetState> states) {
                                        if (states.contains(
                                                WidgetState.focused) ||
                                            states.contains(
                                                WidgetState.pressed)) {
                                          return const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16)));
                                        }
                                        return const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16)));
                                      }),
                                      padding: WidgetStateProperty.all<
                                              EdgeInsetsGeometry>(
                                          const EdgeInsets.symmetric(
                                              vertical: 32, horizontal: 84)),
                                      side: WidgetStateProperty.resolveWith<
                                              BorderSide>(
                                          (Set<WidgetState> states) {
                                        if (states.contains(
                                                WidgetState.focused) ||
                                            states.contains(
                                                WidgetState.pressed)) {
                                          return const BorderSide(
                                              width: 3,
                                              color:
                                                  buttonPrimaryPressedOutline);
                                        }
                                        return const BorderSide(
                                            width: 3, color: Colors.white);
                                      }),
                                    ),
                                    child: Text("Hitung",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            height: 1,
                                            fontFamily: fontFamily)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Section for two columns (Results Section)
              ResponsiveRowColumnItem(
                rowFlex: 1,
                columnOrder:
                    2, // Make sure this is displayed after form on smaller screens
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.primaryColorDark,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: border),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Hasil Perhitungan Panen',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        value.harvestData.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Displaying result data
                                  Text(
                                    'Harga Per Kg: ${value.hargaPerKg}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Luas Sawah: ${value.luasSawah} m²',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Tanggal Tanam: ${DateFormat('yyyy-MM-dd').format(value.tanggalTanam)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // Displaying more details for each harvest data
                                  for (var data in value.harvestData)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sisa Hari: ${data['sisa_hari']}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          'Tanggal Panen: ${data['tanggal_panen']}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          'Total Harga Rupiah: ${data['total_harga_rupiah']}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          'Total Hasil (Kg): ${data['total_hasil_kilogram']}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          'Total Hasil (Ton): ${data['total_hasil_ton']}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                ],
                              )
                            : NoFoundCustomWhite(
                                message: 'Hasil perhitungan tidak ditemukan',
                                subMessage:
                                    'Lakukan perhitungan dengan mengisi form terlebih dahulu',
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
