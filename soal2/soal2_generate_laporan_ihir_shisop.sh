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
' Laporan-TokoShiSop.tsv > hasil2.txt
