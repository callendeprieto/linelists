#!/bin/bash

wget http://kurucz.harvard.edu/linelists/gfnew/gfall08oct17.dat
echo gfall08oct17.dat > in
echo 0. >> in
echo 100000000000000000000000000000000000. >> in

./mk19x_v3 < in > gfall08oct17.19

echo kur_bpo,\'gfall08oct17.19\',\'gfall08oct17_bpox.19\',/x > startup.pro
echo exit >> startup.pro
gdl startup.pro > startup.log
echo done

