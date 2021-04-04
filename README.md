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
# Kendala Soal 2. A
tidak ada kendala major yang dialami, hanya sekedar kendala minor seperti typo dan salah penempatan variabel
# Penjelasan Soal 2. B


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
