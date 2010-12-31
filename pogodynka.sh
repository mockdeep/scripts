sciezka=~/scripts

kod=USIL0225

plik=~/weather
 	w3m -dump http://weather.yahoo.com/forecast/"$kod".html | grep -A21 "Current" | sed 's/DEG/°/g' > $plik

	stan=`head -n3 $plik | tail -n1`
	temp=`tail -n1 $plik | awk '{print $1}'`
	tempo=`head -n6 $plik | tail -n1`
	cisn=`head -n8 $plik | tail -n1`
	wiatr=`head -n16 $plik | tail -n1`
	wilg=`head -n10 $plik | tail -n1`
	wsch=`head -n18 $plik | tail -n1`
	zach=`head -n20 $plik | tail -n1`
	if [ `cat "$sciezka"/pogodynka.sh | grep -x "# $stan" | wc -l` -eq 0 ]
	  then
		stanpl=$stan
	  else
		stanpl=`cat "$sciezka"/pogodynka.sh | grep -xA1 "# $stan" | tail -n1 | awk '{print $2,$3,$4,$5,$6,$7}'`
	fi
	
	echo $temp F  /  $tempo F