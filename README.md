# soal-shift-sisop-modul-1-A12-2021
Repo github soal shift modul 1 sisop semester genap tahun 2021 

<hr>

# Jawaban No 1.<br/>
![Capture](https://user-images.githubusercontent.com/7587945/113503264-ed8d7c80-955a-11eb-976a-d500bdc8b36e.PNG)<br/>
Pada soal ini 'grep' digunakan karena 'AWK' tidak diperbolehkan untuk mengambil informasi dari file 'syslog.log' berdasarkan informasi yang diinginkan.<br/>
# Penjelasan Soal 1. A (text.txt)<br/>
Pada soal ini kita perlu informasi dari syslog.log berupa jenis log (ERROR/INFO), pesan log, dan username.<br/>
`grep -oP '(?<=ticky: ).*' syslog.log > text.txt`<br/>
Kita menggunakan grep untuk melakukan ini. -oP berarti "matching only" sehingga hanya informasi yang diperlukan muncul dan `(?<ticky: )` berarti kita hanya mengambil teks setelah "ticky: " muncul.<br/>
![Capture](https://user-images.githubusercontent.com/7587945/113503772-22e79980-955e-11eb-94fc-f6095e8a8439.PNG)<br/>
# Penjelasan Soal 1. B dan 1. D (error_message.csv)<br/>
Pada soal ini kita perlu menyimpan informasi berupa error message dan error count ke error_message.csv.<br/>
`grep -oP '(?<=ERROR ).*(?= \()' syslog.log | sort -u > temp1.txt`<br/>
Kita mengambil teks setelah "ERROR " muncul, tetapi sebelum "(", yaitu error messagenya. Kemudian teks tersebut disort yang unique sehingga akan terlihat seperti ini.<br/>
![Capture](https://user-images.githubusercontent.com/7587945/113504149-6c38e880-9560-11eb-852a-48020af4d41d.PNG)<br/>
`echo "$(grep -m1 "" temp1.txt),$(grep "$(grep -m1 "" temp1.txt)" syslog.log | wc -l)" >> error.txt`<br/>
Command ini akan menampilkan error message (mengambil line pertama dari temp1.txt), error count (wc -l) dan menyimpannya ke error.txt.<br/>
`echo "$(cat error.txt | sort -t, -k 2 -n -r)" >> error_message.csv`<br/>
Setelah error.txt lengkap, text file tersebut disort berdasarkan numerical dan disimpan ke error_message.csv.  <br/>
# Penjelasan Soal 1. C dan 1. E (user_statistic.csv)<br/>
Soal ini mirip dengan soal 1. B dan 1. D. Kita perlu informasi Username, INFO count, ERROR count.<br/>
`grep -oP '(\().*(?=\))' syslog.log | sort -u | cut -c 2- > temp1.txt`<br/>
Kita mengambil teks setelah "(" dan sebelum ")" dan sort unique, tetapi yang ditampil akan menjadi "(username" sehingga perlu dicut.<br/>
`echo "$(grep -m1 "" temp1.txt),$(grep -w "INFO" syslog.log | grep -w "$(grep -m1 "" temp1.txt)" | wc -l),$(grep -w "ERROR" syslog.log | grep -w "$(grep -m1 "" temp1.txt)" | wc -l)" >> user_statistic.csv`<br/>
Command ini mirip dengan command di nomor sebelumnya, tetapi perlu difilter dulu menjadi "ERROR" atau "INFO" sebelum difilter lagi berdasarkan username.<br/>

<hr>

# Jawaban No 2. 
![ss_Laporan-TokoShiSop](https://user-images.githubusercontent.com/75328763/113485508-0bfe6400-94d8-11eb-9d32-64c6a525112c.png)
Masalah pada nomer 2 ini deselesaikan menggunakan program `AWK`.
pada nomor 2 ini kita diminta untuk membuat rangkuman informasi yang diinginkan dari file `Laporan-TokoShiSop.tsv` sesuai dengan soal yang diberikan. Untuk itu pengerjaan soal ini untuk menentukan file seperator (pemisah antar datanya) yang digunakan pada file yang berisi data yang akan diperoses menggunakan AWK. Kode di bawah berikut  untuk mendefinisikan file seperator  
> BEGIN { FS = "\t" ;}  
# Penjelasan Soal 2. A
pada nommor 2.A kita diminta untuk mencari dan menampilkan `ID Transaksi` dan `Profit Persentase` terbesar dalam data laporan tersebut. Untuk itu diperlukan rumus dimana profit persentasinya adalah `Profit Percentage = (Profit/Cost)*100%  
```Shell
#A
{ tmpp = ($21/($18-$21))*100;
  if(maxp<tmpp) {
    maxp = tmpp;
    maxid = $2;
    maxrow = $1;
  }
  if(maxp == tmpp) {
    if(maxrow<$1) { 
      maxid = $2;
      maxrow = $1; 
    }
  }
}
```
kode datas digunakan untuk mencari `Profit Percentage` tiap barisnya dan menyimpan data nilai didalam variabel `tmpp`. lalu kita akan mengecheck disetiap linenya bahwasannya apakah ada nilai lebih besar didalam variabel `maxpp`. pengecekan tersebut membandingkan nilai dari `maxpp` dan nilai dari `tmpp`.  
pada soal 2.A dijelaskan bahwasannya jika ada nilai terbesar yang sama maka nilai yang diambil akan dilihat dari nilai `Row ID` terbesar oleh karena itu ada pengechekan lagi di bawah kode tersebut. Lalu kode akan ditampilkan dengan format kode  
```Shell
#A
   printf("Transaksi terakhir dengan profit percentage terbesar yaitu %s dengan persentase %.2f%%\n\n",maxrow,maxp);
```
# Revisi Soal 2. A
tidak ada kendala major yang dialami, hanya sekedar kendala minor seperti typo dan salah penempatan variabel  
# Kendala Soal 2. A
terdapat sedikit kendala dimana output input dan program yang dibuat tidak sesuai dengan output yang diharapkan dimana `maxrow` di laptop pc Afifan memiliki keanehan yang sebelumnya isi variabel tersebut 9966 dan bilamana program ini dikerjakan di pc lainnya maka menunujakan nilai 9952.  
# Penjelasan Soal 2. B
Pada soal nomor 2 yang B kita diminta untuk mencari daftar nama `Customer` yang melakukan transaksi pada tahun 2017 dan terbatas pada `City` dimana variable tersebut haruslah "Albuquerque".
```Shell
#B
{
	orderid = $2
	city = $10
	if (orderid != "Order ID" && city != "City")
	{ 
	  if(substr($2,4,4) == 2017 && $10 == "Albuquerque"){
		sama = 0;
		for(i = 0; i < jumlah2017 ; i++){
		  if(customer[i] == $7) sama = 1;
		}
		if(sama == 0) customer[jumlah2017++] = $7;
	  }
	}
}
```  
untuk potongan kode diatas ditunjukan bahwasannya memasukan variabel `orderid` dan `city` sebagai pengecehkan agar baris pertama sebagai nama kolom tidak dianggap nantinya. Lalu kita melakukan pengechekan menggunakan `substr` diamana itu digunakan untuk mengechek string yang sesuai dengan indexing dari array string tersebut, kebetulan kita hanya perlu mengecheck 4 digit berikutnya dari `Order ID` yang hal tersebut merupakan tahun sebuah orderan itu dibuat. Dan kita tambahi AND untuk mngechek lagi pada kolom `City` apakah terdapat kota bernama "Albuquerque", jika pengecheckan suskes maka akan masuk ke perulangan dimana memasukan kedalam array daftar nama tersebut. untuk perulangannya sendiri saya melakukan sedikit tambhan bilamana ada nama lebih dari satu maka akan trigger sebuah flag yang dimana nantinya nama tersebut tidak akan ter-output lagi. Lalu ditampilkan menggunakan potongan kode dibawah ini.  
```Shel
#B
   printf("Daftar nama customer di Albuquerque pada tahun 2017 antara lain: \n");
  for(i = 0 ; i < jumlah2017; i++) printf("%s\n",customer[i]);
  printf("\n");
```  
# Kendala Soal 2. B
tidak ada kendala selama pengerjaan dan sukses, namun kami diminta untuk mengganti code sebelumnya karena menggunakan `/2017/` karena hal tersebut mengechek keseluruhan data meskipun itu bukan dari target kolom maupun baris.  
# Revisi Soal 2. B
mengganti potongan kode sebelumnya yaitu berikut dibawah ini.
```Shell
/2017/ {
  if($10 == "Albuquerque"){
    samename = 0;
    for(itr = 0; itr < jml2017 ; itr++){
      if(custname[itr] == $7) samename = 1;
    }
    if(samename == 0) custname[jml2017++] = $7;
  }
}
```  
# Penjelasan Soal 2. C
Pada soal ini kita diminta untuk mencari dan menampilkan jenis dari 3 `Segment Customer` yang dimana terdapat 3 jenis yaitu _Home Office_, _Corporate_, _Consumer_ dengan jumlah paling sedikit transaksinya.  
```Shell
#C
/Home Office/ { homeOf++ }
/Corporate/ { corporate++ }
/Consumer/ { consumer++ }
```   
kode diatas untuk menghitung data yang ada dari ketiga segment yang muncul. jika salah satu data muncul maka akan memberi nilai +1 pada variabel terkait lalu untuk pengechekan dan output kodenya akan ditampilkan dibawah ini.  
```Shel
#C
  if(homeOf < corporate){
    if(homeOf < consumer) { minseg = "Home Office"; mintotseg = homeOf; }
    else {minseg = "Customer"; mintotseg = consumer; }
  }
  else{
    if(corporate < consumer) { minsegt = "Corporate"; mintotseg = corp; }
    else {minseg = "Customer"; mintotseg = consumer; }
  }
  printf("Tipe segment customer yang penjualannya paling sedikit adalah %s dengan %d transaksi.\n",minseg,mintotseg);
```  
Kode diiatas merupakan sebuah percabangan sederhana diamana yang akan mengecheck apakah ketiga variabel tersebut lebih kecil dari yang lainnya.  
# Kendala Soal 2. C
tidak ada kendala dalam pengerjaan soal tersebut.  
# Penjelasan Soal 2. D
Pada Soal ini tidak bereda jauh dari soal C sebelumnya. Yaitu kita diminta mencari dan menampilkan `Region` dangan total `Profit` paling sedikit.
```Shell
#D
/Central/ { central += $21 }
/East/ { east += $21 }
/South/ { south += $21 }
/West/ { west += $21 }
```  
kode diatas sama hampir persis dari kode dari Soal C namun dalam keempat variabel tersbut, kita menjumlahkan seluruh `Profit` yang ada pada `Region` terkait. Yaitu dengan menjumlahkan pada kolom `$21` pada variabel penampungnya. Output akan dikeluarkan dengan beberapa dengan code sebagai berikut.  
```Shell
#D 
  if(central < east){
    if(central < south){
      if(central < west){ minregion = "Central"; profregion = central; }
      else { minregion = "West"; profregion = west; }
    }
    else {
      if(south < west) { minregion = "South"; profregion = south; }
      else { minregion = "West"; profregion = west; }
    }
  }
  else {
    if(east < south) {
      if(east < west) { minregion = "East"; profregion = east; }
      else { minregion = "West"; profregion = west; }
    }
    else {
      if(south < west) { minregion = "South"; profregion = south; }
      else { minregion = "West"; profregion = west; }
    }
  }
  printf("\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %f\n",minregion,profregion);
}
```  
kode diatas merupakan percabangan sederhana dimana akan mencari nilai terkecilnya. percabangan tersebut mirip seperti soal C namun lebih banyak jumlah percabangannya.  
# Kendala Soal 2. D
Kendala pada Soal D ini mirip seperti Soal A dimana code program ini tidak berjalan sesuai dengan apa yang diharapkan karena anehan dari laptop Afifan ini. sebelumnya hasil ouput `Profit` eksekusi prgram di laptop ini adalah **39250,000000** dimana itu merupakan penjumlahan dalam integer yang seharsunya `Profit` dalam data yang telah disediakan merupakan bilangan berkoma. Program code ini berjalan baik di komputer lainnya dimana mendapatkan nilai `Profit` sebesar **39725,729100** dimana itu merupakan penjumlahan _float_/_double_ yang berbeda dari penjumlahan integer.  
# Penjelasan Soal 2. E
Soal ini merupakan tugas iuntuk menjalankan scriptcode untuk menyelesaikan problem yang ada pada soal 2. A-D dengan menghasilkan file baru bernama `hasil.txt` yang berisi rangkuman inforamasi dengan tempalte yang telash disediakan. Scriptcode tersebut sebagai berikut.  
```Shell
#!/bin/bash

# Soal No 2
awk 'BEGIN { FS = "\t" ;}
#A
{ tmpp = ($21/($18-$21))*100;
  if(maxp<tmpp) {
    maxp = tmpp;
    maxid = $2;
    maxrow = $1;
  }
  if(maxp == tmpp) {
    if(maxrow<$1) {
      maxid = $2; 
      maxrow = $1;
    }
  }
}
#B
{
	orderid = $2
	city = $10
	if (orderid != "Order ID" && city != "City")
	{ 
	  if(substr($2,4,4) == 2017 && $10 == "Albuquerque"){
		sama = 0;
		for(i = 0; i < jumlah2017 ; i++){
		  if(customer[i] == $7) sama = 1;
		}
		if(sama == 0) customer[jumlah2017++] = $7;
	  }
	}
}
#C
/Home Office/ { homeOf++ }
/Corporate/ { corporate++ }
/Consumer/ { consumer++ }
#D
/Central/ { central += $21 }
/East/ { east += $21 }
/South/ { south += $21 }
/West/ { west += $21 }
END { 
#A
   printf("Transaksi terakhir dengan profit percentage terbesar yaitu %s dengan persentase %.2f%%\n\n",maxrow,maxp);
   
#B
   printf("Daftar nama customer di Albuquerque pada tahun 2017 antara lain: \n");
  for(i = 0 ; i < jumlah2017; i++) printf("%s\n",customer[i]);
  printf("\n");
#C
  if(homeOf < corporate){
    if(homeOf < consumer) { minseg = "Home Office"; mintotseg = homeOf; }
    else {minseg = "Customer"; mintotseg = consumer; }
  }
  else{
    if(corporate < consumer) { minsegt = "Corporate"; mintotseg = corp; }
    else {minseg = "Customer"; mintotseg = consumer; }
  }
  printf("Tipe segment customer yang penjualannya paling sedikit adalah %s dengan %d transaksi.\n",minseg,mintotseg);
  
#D 
  if(central < east){
    if(central < south){
      if(central < west){ minregion = "Central"; profregion = central; }
      else { minregion = "West"; profregion = west; }
    }
    else {
      if(south < west) { minregion = "South"; profregion = south; }
      else { minregion = "West"; profregion = west; }
    }
  }
  else {
    if(east < south) {
      if(east < west) { minregion = "East"; profregion = east; }
      else { minregion = "West"; profregion = west; }
    }
    else {
      if(south < west) { minregion = "South"; profregion = south; }
      else { minregion = "West"; profregion = west; }
    }
  }
  printf("\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %f\n",minregion,profregion);
}
' Laporan-TokoShiSop.tsv > hasil.txt
```  
Scriptcode diatas dijalankan dengan menggunkan printah bash pada terminal dan menghasilkan file baru yaitu `hasil.txt`. File berisi sebagai berikut.  
![hasil](https://user-images.githubusercontent.com/75328763/113511597-bd5dd200-958a-11eb-910d-2702e7f03131.jpg)  
# Kendala dalam Output 2. E
seperti kendala pada soal sebelumnya yang dikarenakan keanehan laptop Afifan ini, yaitu hasil Outputnya sebagai berikut.  
![image](https://user-images.githubusercontent.com/75328763/113511666-280f0d80-958b-11eb-8fb9-6770c969febc.png)  
hal tersebut tidak berefek pada eksekusi kode program di PC lainnya.  

<hr>

# Jawaban Soal 3. A <br/>
![Capture](https://user-images.githubusercontent.com/7587945/113505184-714d6600-9567-11eb-9ba5-8410d0b23845.PNG) <br/>
![Capture](https://user-images.githubusercontent.com/7587945/113505636-55978f00-956a-11eb-83e7-7ebe1905b386.PNG) <br/>
Pada soal ini kita perlu mendownload 23 gambar dari suatu url, hapus gambar duplikat dan rename menjadi Koleksi_XX <br/>
# Penjelasan Soal 3. A <br/>
`wget https://loremflickr.com/320/240/kitten -a foto.log` <br/>
Command ini digunakan untuk mendownload file dari url dan tambahkan lognya ke foto.log <br/>
`find -type f -exec md5sum '{}' ';' | sort | uniq --all-repeated=separate -w 15 | awk -F/ '{print $2}' > dupes.txt` <br/>
Command find akan menampilkan hash MD5 dari file seperti ini <br/>
![Capture](https://user-images.githubusercontent.com/7587945/113505427-f2f1c380-9568-11eb-95a7-5ba829c26bab.PNG) <br/>
Teks tersebut disort dan hanya nama file duplikat akan muncul dan dipisah dengan newline. Contohnya jika kitten1 dan kitten2 merupakan duplikat dan kitten3 dan kitten 5 juga duplikat, maka yang muncul pada dupes.txt adalah <br/>
kitten1<br/>
kitten2<br/>
<br/>
kitten3<br/>
kitten4<br/>
Dari teks dupes.txt tersebut, file dengan nama di line pertama akan diremove.<br/>
`mv $(ls -l | awk '{print $NF}' | grep -m1 "kitten") Koleksi_$j` <br/>
Command ini digunakan untuk merename file menjadi Koleksi_XX.

# Kendala Soal 3. A <br/>
Seperti pada screenshot awal, tidak semua file direname menjadi Koleksi_XX. Ternyata terdapat masalah pada command loop for<br/>
`for ((j=1; j<=$(ls -l | awk '{print $NF}' | grep "kitten" | wc -l); j=j+1))`<br/>
dimana angka setelah "for<=" dapat berubah saat loop berjalan. Untuk memperbaiki hal tersebut, variabel baru dapat dibuat supaya program berjalan seperti yang seharusnya.<br/>
`n=$(ls -l | awk '{print $NF}' | grep "kitten" | wc -l)`<br/>
`for ((j=1; j<=n; j=j+1))`<br/>
![Capture](https://user-images.githubusercontent.com/7587945/113505620-40bafb80-956a-11eb-952e-02505810067f.PNG)
