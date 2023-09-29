import 'package:mycashbook/constant/route_constants.dart';
import 'package:mycashbook/helper/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalIncome = 0;
  int totalExpense = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotalIncomeAndExpense();
  }

  Future<void> _fetchTotalIncomeAndExpense() async {
    // Initialize your DBHelper
    final dbHelper = DbHelper();

    // Fetch the total income and total expense
    final income = await dbHelper.getTotalIncome();
    final expense = await dbHelper.getTotalExpense();

    setState(() {
      totalIncome = income;
      totalExpense = expense;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchTotalIncomeAndExpense(); // Refresh data when navigating back
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // final user = userProvider.user;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Center(
            child: Column(
          children: [
            const Text(
              "Rangkuman Bulan Ini",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text("Pengeluaran : Rp. $totalExpense"),
            Text("Pemasukan   : Rp. $totalIncome"),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: LineChart(LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.green, width: 3)),
                  minX: 0,
                  maxX: 7,
                  minY: 0,
                  maxY: 1000,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 200),
                        const FlSpot(1, 150),
                        const FlSpot(2, 450),
                        const FlSpot(3, 300),
                        const FlSpot(4, 600),
                        const FlSpot(5, 500),
                        const FlSpot(6, 800),
                        const FlSpot(7, 1000),
                      ],
                      isCurved: true,
                      color: Colors.black38,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    )
                  ])),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavButton(
                        imagePath: 'assets/images/pemasukan.png',
                        label: "Tambah Pemasukan",
                        onTap: () {
                          Navigator.pushNamed(context, addIncomeRoute);
                        }),
                    NavButton(
                        imagePath: 'assets/images/pengeluaran.png',
                        label: "Tambah Pengeluaran",
                        onTap: () {
                          Navigator.pushNamed(context, addExpenseRoute);
                        }),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavButton(
                        imagePath: 'assets/images/cashflow.png',
                        label: "Detail Cash Flow",
                        onTap: () {
                          Navigator.pushNamed(context, detailCashFlowRoute);
                        }),
                    NavButton(
                        imagePath: 'assets/images/setting.png',
                        label: "Pengaturan",
                        onTap: () {
                          Navigator.pushNamed(context, '/settings');
                        }),
                  ],
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const NavButton(
      {super.key,
      required this.imagePath,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
          const SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }
}
