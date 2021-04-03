# soal-shift-sisop-modul-1-A12-2021
Repo github soal shift modul 1 sisop semester genap tahun 2021 
Permasalahan yang ditemukan: pada soal 3a gagal rename menjadi "Koleksi_12" tetapi tidak tahu kenapa

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
