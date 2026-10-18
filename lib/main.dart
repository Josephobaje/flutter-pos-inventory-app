
import 'package:flutter/material.dart';
import 'logic.dart';
void main()=>runApp(const MyApp());
class MyApp extends StatelessWidget{const MyApp({super.key});@override Widget build(BuildContext c)=>MaterialApp(debugShowCheckedModeBanner:false,title:'ShopPOS',theme:ThemeData(colorScheme:ColorScheme.fromSeed(seedColor:Color(0xFF2E7D32)),useMaterial3:true),home:const Home());}
String naira(num v)=>'₦${v.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\B)(?=(\d{3})+(?!\d))'),(m)=>',')}';

class Home extends StatefulWidget{const Home({super.key});@override State<Home> createState()=>_S();}
class _S extends State<Home>{int tab=0;final cart=Cart();int sales=0;
 @override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:const Text('ShopPOS')),body:[_pos(),_stock(),_report()][tab],bottomNavigationBar:NavigationBar(selectedIndex:tab,onDestinationSelected:(i)=>setState(()=>tab=i),destinations:[NavigationDestination(icon:Badge(label:Text('${cart.count}'),child:const Icon(Icons.point_of_sale)),label:'Checkout'),const NavigationDestination(icon:Icon(Icons.inventory),label:'Stock'),const NavigationDestination(icon:Icon(Icons.bar_chart),label:'Report')]));}
 Widget _pos()=>Column(children:[ListTile(leading:const Icon(Icons.qr_code_scanner),title:const Text('Barcode scan (placeholder)'),subtitle:const Text('Tap a product below to add it, as a scanner would')),Expanded(child:ListView(children:products.map((p)=>ListTile(title:Text(p.name),subtitle:Text('${naira(p.price)} · ${p.stock} in stock'),trailing:IconButton(icon:const Icon(Icons.add_circle),onPressed:()=>setState(()=>cart.add(p))))).toList())),Card(child:ListTile(title:Text('Total ${naira(cart.total)}'),subtitle:Text(cart.receipt().isEmpty?'Cart is empty':cart.receipt()),trailing:ElevatedButton(onPressed:cart.total==0?null:()=>setState((){sales+=cart.total;cart.items.clear();}),child:const Text('Checkout'))))]);
 Widget _stock()=>ListView(children:products.map((p)=>ListTile(title:Text(p.name),subtitle:Text('${p.stock} left'),trailing:p.low?const Chip(label:Text('Low stock')):const Chip(label:Text('OK')))).toList());
 Widget _report()=>Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Daily sales: ${naira(sales)}',style:const TextStyle(fontSize:22,fontWeight:FontWeight.bold)),Text('Low stock items: ${lowStock.length}'),...lowStock.map((p)=>Text('• ${p.name} (${p.stock} left)'))]));
}
