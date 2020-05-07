#!/bin/bash

yol=$(pwd)
#BEEF-WAN 1=> ALPEREN ÇAVUŞ
#BEEF-WAN 1.0 
#PROGRAMIN AMACI PORT YÖNLENDİRMESİZ BEEF-XSS FRAMEWORK'UN ÇALIŞMASINI SAĞLAMAK EĞER İSTENİRSE NORMAL BİR İP ADRESİ İLE DE YAPILABİLİR
ip=`hostname -I`
_logo_() {
      #Kullanıcının göreceği ana menü logosu
arr[0]=" logo/1.txt"
arr[1]=" logo/2.txt"
arr[2]=" logo/3.txt"

rand=$[ $RANDOM % 3 ]
echo -e "\e[1;31m"
cat ${arr[$rand]}

echo -e "\e[1;96m"
cowsay ALPEREN ÇAVUŞ
}
_logo_

#Eğer config klasörü yoksa oluştur
if [ -d config_ ]; then
 echo ""
else
 mkdir config_
fi

#Kullanıcının kendi orjinal dosyalarının klasörünü kontrol et
#Eski index.html'i buraya kopyala
if [ -d html ]; then
   echo ""
else
 mkdir html
fi

#Eski config.yaml dosyasını kopyala
#cp -L /usr/share/beef-xss/config.yaml $yol/config_/

#Eski html dosyalarını kopyala

#cp -rf /var/www/html/* $yol/html


#GEREKLİ OLAN ARAÇLARI KONTROL ET
kontrol_et() {
#Apache2 sunucusunu kontrol et

 which apache2 > /dev/null 2>&1
   if [ "$?" -eq "0" ]; then
      echo ""
     else
        apt-get install apache2 -y
          clear
           kontrol_et
fi


  sleep 2
#Beef-xss framework'u kontrol et
  which beef-xss > /dev/null 2>&1
   if [ "$?" -eq "0" ]; then
      echo ""
     else
         apt-get install beef-xss -y
 sleep 2       
clear 
         kontrol_et
      fi
#Ngrok programını kontrol et
sleep 2
  if [ -e ngrok ]; then
   echo ""
    else
     wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
        unzip ngrok-stable-amd64.zip
         rm -rf ngrok-stable-amd64.zip
           kontrol_et
fi
sleep 2

#Config.yaml dosyasını kontrol et
if [ -e config.yaml ]; then
    echo ""
else
    echo -e "\e[1;31m CONFİG YAML DOSYASI BULUNAMADI "
     sleep 0.56
         echo -e "\e[1;31mARACI TEKRAR İNDİRİN ! "
             exit 1
sleep 1
  fi

}
kontrol_et

menu() {
echo -e "\e[1;32m[ + ]NGROK[ + ] "
echo -e "\e[1;32m[ + ]ÇIKIŞ[ + ]"

read -p $"#_#> " islem


if [[ $islem == 1 || $islem == 01 ]]; then
  echo -e "\e[1;31mYAPMAN GEREKENLER:\e[1;32m \n ./ngrok http 80"
               
    echo -e "\e[1;32mNGROK LİNKİNİ GİR ÖRNEK:\e[1;31malperenCavuS.ngrok.io "
   sleep 1
    read -p $"#_# > " ngrok
     #Config.yaml
      #unzip config.zip
       #cp -L /usr/share/beef-xss/config.yaml $yol/
        sed -i "s|CAVUS|$ip|g" config.yaml


#İndex.html dosyasındakı ALPEREN yazısını değiştir
      #unzip web_server.zip
       sed -i "s|ALPEREN|$ip|g" web_server/index.html
        #cp -L web_server/index.html /var/www/html && cp -r web_server/res /var/www/html
         #rm -rf web_server
           #rm index.html
      #Eski config.yaml sil yerine yenisini kopyala
         rm /usr/share/beef-xss/config.yaml && cp -L config.yaml /usr/share/beef-xss/
      #Ve en sonunda gerekli olan servisleri başlat
         service apache2 start
          beef-xss
       which chrome > /dev/null 2>&1
       if [ "$?" -eq "0" ]; then
         google-chrome https://$ngrok/index.html
         else
             firefox https://$ngrok/index.html
fi
else
     echo "mdöeğ"
fi
}
menu
