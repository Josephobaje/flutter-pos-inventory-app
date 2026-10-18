
class Product{final String name;int stock;final int price;Product(this.name,this.stock,this.price);bool get low=>stock<=5;}
final products=[Product('Indomie Chicken 70g',42,350),Product('Rice 5kg',8,12500),Product('Peak Milk 400g',4,6800),Product('Coke 50cl',60,500),Product('Groundnut Oil 1L',3,4200),Product('Sugar 1kg',15,1800)];
class Cart{final Map<Product,int> items={};void add(Product p)=>items[p]=(items[p]??0)+1;void remove(Product p){final q=(items[p]??0)-1;q<=0?items.remove(p):items[p]=q;}int get total=>items.entries.fold(0,(s,e)=>s+e.key.price*e.value);int get count=>items.values.fold(0,(a,b)=>a+b);int change(int paid)=>paid-total;String receipt()=>items.entries.map((e)=>'${e.key.name} x${e.value}  ${e.key.price*e.value}').join('\n');}
List<Product> get lowStock=>products.where((p)=>p.low).toList();
