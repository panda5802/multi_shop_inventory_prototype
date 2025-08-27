import 'package:flutter/material.dart';

void main() {
  runApp(MultiShopInventoryApp());
}

class MultiShopInventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Shop Inventory',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ShopListScreen(),
    );
  }
}

class ShopListScreen extends StatelessWidget {
  final List<String> shops = List.generate(20, (i) => "වෙළඳසැල ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("වෙළඳසැල් ලැයිස්තුව")),
      body: ListView.builder(
        itemCount: shops.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(shops[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopDetailScreen(shopName: shops[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ShopDetailScreen extends StatefulWidget {
  final String shopName;
  ShopDetailScreen({required this.shopName});

  @override
  _ShopDetailScreenState createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  int initialStock = 0;
  int directPurchases = 0;
  int cashPurchases = 0;
  int creditPurchases = 0;
  int transfersIn = 0;
  int transfersOut = 0;
  int damages = 0;
  int nutritionStamps = 0;
  int salesCash = 0;
  int salesCredit = 0;

  @override
  Widget build(BuildContext context) {
    int totalStock = initialStock + directPurchases + transfersIn;
    totalStock -= (transfersOut + damages);
    int remainingStock = totalStock - (salesCash + salesCredit + nutritionStamps);

    return Scaffold(
      appBar: AppBar(title: Text(widget.shopName)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildInput("ආරම්භක තොග", (val) => setState(() => initialStock = int.tryParse(val) ?? 0)),
            buildInput("දිනට ඍජු ගැනුම්", (val) => setState(() => directPurchases = int.tryParse(val) ?? 0)),
            buildInput("අත්පිට ගැනුම්", (val) => setState(() => cashPurchases = int.tryParse(val) ?? 0)),
            buildInput("ණයට ගැනුම්", (val) => setState(() => creditPurchases = int.tryParse(val) ?? 0)),
            buildInput("හැරවුම් ලැබීම් (F18)", (val) => setState(() => transfersIn = int.tryParse(val) ?? 0)),
            buildInput("හැරවුම් යැවීම් (F18)", (val) => setState(() => transfersOut = int.tryParse(val) ?? 0)),
            buildInput("නරක්වීම් (F17)", (val) => setState(() => damages = int.tryParse(val) ?? 0)),
            buildInput("පෝෂණ මුද්දර", (val) => setState(() => nutritionStamps = int.tryParse(val) ?? 0)),
            buildInput("විකුණුම් - අත්පිට", (val) => setState(() => salesCash = int.tryParse(val) ?? 0)),
            buildInput("විකුණුම් - ණයට", (val) => setState(() => salesCredit = int.tryParse(val) ?? 0)),
            SizedBox(height: 20),
            Text("මුලු තොග: $totalStock", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("අවසාන ඉතිරිය: $remainingStock", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
          ],
        ),
      ),
    );
  }

  Widget buildInput(String label, Function(String) onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
      ),
    );
  }
}