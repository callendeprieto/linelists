#!/usr/bin/csh
# This script, in combination with the f90 program mk20, creates
# master molecular linelists for synspec from Kurucz's molecular linelists
# for separate species. The input data are the desired wavelength range,
# a list of input (Kurucz) linelists, a list of corrections for the log(gf)
# values (0.0 for no changes), and the name of the output (synspec .20) file.
#
# Carlos, October 2004
#	  June 2007, updated to handle new files from Kurucz's web site
#	  June 2018, updated to include new files from Kurucz
#

#tests pending:
#try chjorg.as instead of chmasseron.asc?

# 0 - 1e10 AA (0.01 - 30 um)
set lambda_begin = 	0.
set lambda_end = 	1.e10
set outfile = kmol2020_giant

if (-e tmp.20) rm tmp.20

echo processing H2 ...
# 1H1H -> 1
echo h2.asc $lambda_begin $lambda_end  1 1 0.0000           | \
        tr ' ' '\n' | mk20 >> tmp.20

echo processing CH ...
# 12C1H -> 12 		13C1H -> 13
#OLD echo ch.asc $lambda_begin $lambda_end   2 12 -0.0280287 13 -1.20412      | \
echo chmasseron.asc $lambda_begin $lambda_end   2 12 -0.0280287 13 -1.20412       | \
#echo chjorg.asc $lambda_begin $lambda_end   2 12 -0.0280287 13 -1.20412      | \
        tr ' ' '\n' | mk20 >> tmp.20

echo "processing C2  ..."
# 12C12C -> 12 		12C13C -> 13	13C13C -> 33
echo c2ax.asc $lambda_begin $lambda_end   3 12 -0.0560574 13 -1.23215 33 -2.40824 | \
        tr ' ' '\n' | mk20 >> tmp.20

echo c2ba.asc $lambda_begin $lambda_end   3 12 -0.0560574 13 -1.23215 33 -2.40824 | \
        tr ' ' '\n' | mk20 >> tmp.20

#OLD echo c2da.asc $lambda_begin $lambda_end   3 12 -0.0560574 13 -1.23215 33 -2.40824 | \
echo c2dabrookek.asc $lambda_begin $lambda_end   3 12 -0.0560574 13 -1.23215 33 -2.40824 | \
        tr ' ' '\n' | mk20 >> tmp.20

echo c2ea.asc $lambda_begin $lambda_end   3 12 -0.0560574 13 -1.23215 33 -2.40824 | \
        tr ' ' '\n' | mk20 >> tmp.20
        
        
echo "processing CN  ..."
# 12C14N -> 12		13C14N -> 13	12C15N -> 15
echo cnax.asc $lambda_begin $lambda_end 3 12  -0.0296299 13 -1.20572  15 -2.46218 | \
        tr ' ' '\n' | mk20 >> tmp.20

echo cnbx.asc $lambda_begin $lambda_end 3 12  -0.0296299 13 -1.20572  15 -2.46218 | \
        tr ' ' '\n' | mk20 >> tmp.20

echo "processing CO  ..."
# 12C16O -> 12 		13C16O -> 13	12C17O -> 17	12C18O -> 18
echo coax.asc $lambda_begin $lambda_end 4 12 -0.0290854 13 -1.97167  17 -3.44825 18 -2.71627 | \
        tr ' ' '\n' | mk20 >> tmp.20
        
echo coxx.asc $lambda_begin $lambda_end 4 12 -0.0290854 13 -1.97167  17 -3.44825 18 -2.71627 | \
        tr ' ' '\n' | mk20 >> tmp.20        

echo "processing NH ..."
# 14N1H -> 14		15N1H -> 15      
echo nh.asc  $lambda_begin $lambda_end 2 14 -0.0017 15 -2.4342 | \
        tr ' ' '\n' | mk20 >> tmp.20

echo "processing OH ..."
# 16O1H -> 16		18O1H -> 18
#echo oh.asc $lambda_begin $lambda_end 2 16 -0.0011 18 -2.6883  |  \
#echo ohnew.asc $lambda_begin $lambda_end 2 16 -0.0011 18 -2.6883  |  \
echo ohupdate.asc $lambda_begin $lambda_end 2 16 -0.0011 18 -2.6883  |  \
        tr ' ' '\n' | mk20 >> tmp.20

echo "processing MgH ..."
# 24Mg1H -> 24 		25Mg1H -> 25	26Mg1H -> 26
echo mgh.asc $lambda_begin $lambda_end  3 24 -0.1025 25 -1.0001 26  -0.9583 | \
	tr ' ' '\n' | mk20 >> tmp.20	
	
echo "processing SiH ..."
# 28Si1H -> 28		29Si1H -> 29	30Si1H -> 30
echo sihaxsightly.asc $lambda_begin $lambda_end 3 28 -0.03518 29 -1.3295 30 -1.5105 | \
       tr ' ' '\n' | mk20 >> tmp.20	

echo sihxxsightly.asc $lambda_begin $lambda_end 3 28 -0.03518 29 -1.3295 30 -1.5105 | \
	tr ' ' '\n' | mk20 >> tmp.20	

echo "processing SiO (only A-X system) ..."
# 28Si18O -> 18		28Si16O -> 28	29Si16O -> 29	30Si16O -> 30
echo sioax.asc $lambda_begin $lambda_end 4 18 -2.7234 28 -0.0362 29 -1.3305 30 -1.5115  | \
	tr ' ' '\n' | mk20 >> tmp.20	

echo "processing AlO  ..."
# 27Al18O -> 18		27Al16O -> 18
echo alopatrascu.asc $lambda_begin $lambda_end 3 16 -0.0011 17 -3.4202 18 -2.6883    | \
	tr ' ' '\n' | mk20 >> tmp.20		
	
echo "processing CaH ..."
# 40Ca1H -> 40
echo cah.asc $lambda_begin $lambda_end 1 40 0.0000    | \
	tr ' ' '\n' | mk20 >> tmp.20			

echo "processing CaO ..."
# 40CaO -> 40 
echo caoyurchenko.asc $lambda_begin $lambda_end 1 40 0.0000    | \
	tr ' ' '\n' | mk20 >> tmp.20			


echo "processing CrH ..."
# 52CrH -> 52
echo crhaxbernath.asc $lambda_begin $lambda_end 1 52 0.0000    | \
	tr ' ' '\n' | mk20 >> tmp.20

	
echo "processing FeH ..."
# 56FeH -> 56
echo fehfx.asc $lambda_begin $lambda_end 1 56 0.0000    | \
	tr ' ' '\n' | mk20 >> tmp.20

echo "processing MgO ..."
# 24MgO -> 24
echo mgodaily.asc $lambda_begin $lambda_end 1 24 0.0000    | \
	tr ' ' '\n' | mk20 >> tmp.20
	

echo "processing NaH ..."
# 23NaH -> 23
echo nahrivlin.asc $lambda_begin $lambda_end 1 23 0.0000    | \
	tr ' ' '\n' | mk20 >> tmp.20

echo "processing SiH ..."
# 28SiaH -> 28
echo sihaxsightly.asc $lambda_begin $lambda_end 3 28 -0.03513  29 -1.32946  30 -1.51044     | \
	tr ' ' '\n' | mk20 >> tmp.20

echo sihxxsightly.asc $lambda_begin $lambda_end 3 28 -0.03513  29 -1.32946  30 -1.51044    | \
	tr ' ' '\n' | mk20 >> tmp.20		

echo "processing VO ..."
# 51VO -> 51
echo vomyt.asc $lambda_begin $lambda_end 1 51 0.0000    | \
	tr ' ' '\n' | mk20 >> tmp.20	
	
	
echo sorting ...
sort -T /scratch/callende/tmp/ -n -k 1,1 tmp.20 > $outfile
if (-e tmp.20) rm tmp.20
echo done
