#!/usr/bin/csh
#downloading files from Kurucz's web site

#old stuff, but including ohnew and ohxxgoldman that I missed years ago
set site = http://kurucz.harvard.edu/
set path = /LINELISTS/LINESMOL/
set files = (c2ax.asc c2ba.asc c2da.asc c2ea.asc ch.asc cnax.asc cnbx.asc \
	      coax.asc coxx.asc h2.asc mgh.asc nh.asc oh.asc ohnew.asc ohxxgoldman.asc \
	      sih.asc sihnew.asc sioax.asc sioex.asc sioxx.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	      

#new stuff: AlO
set site = http://kurucz.harvard.edu/
set path = /molecules/alo/
set files = (alopatrascu.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 

#new stuff: C2
set site = http://kurucz.harvard.edu/
set path = /molecules/c2/
set files = (c2dabrookek.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 

#new stuff: CaH
set site = http://kurucz.harvard.edu/
set path = /molecules/cah/
set files = (cah.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 

#new stuff: cao
set site = http://kurucz.harvard.edu/
set path = /molecules/cao/
set files = (caoyurchenko.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end


#new stuff: CH
set site = http://kurucz.harvard.edu/
set path = /molecules/ch/
set files = (chjorg.asc chmasseron.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 


#new stuff: CN
set site = http://kurucz.harvard.edu/
set path = /molecules/cn/
set files = (cnaxbrookek.asc cnbxbrookek.asc cnxx12brooke.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 


#new stuff: CO
set site = http://kurucz.harvard.edu/
set path = /molecules/co/
set files = (coax.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 


#new stuff: CrH
set site = http://kurucz.harvard.edu/
set path = /molecules/crh/
set files = (crhaxbernath.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 

#new stuff: FeH
set site = http://kurucz.harvard.edu/
set path = /molecules/feh/
set files = (fehfx.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 

#new stuff:  H2
set site = http://kurucz.harvard.edu/
set path = /molecules/h2/
set files = (h2xx.asc hdxx.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 

#new stuff: H3+
set site = http://kurucz.harvard.edu/
set path = /molecules/h3plus/
set files = (h3plus.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 

#new stuff: MgO
set site = http://kurucz.harvard.edu/
set path = /molecules/mgo/
set files = (mgodaily.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 

#new stuff: NaH
set site = http://kurucz.harvard.edu/
set path = /molecules/nah/
set files = (nahrivlin.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 

#new stuff: OH
set site = http://kurucz.harvard.edu/
set path = /molecules/oh/
set files = (ohaxupdate.asc ohupdate.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 

#new stuff: OH+
set site = http://kurucz.harvard.edu/
set path = /molecules/ohplus/
set files = (ohplusaxhodges.asc ohplusxxhodges.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 

#new stuff: SiH
set site = http://kurucz.harvard.edu/
set path = /molecules/sih/
set files = (sihax.asc sihaxsightly.asc sihxxsightly.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 


#new stuff: VO
set site = http://kurucz.harvard.edu/
set path = /molecules/vo/
set files = (vo.asc vomyt.asc)
	      
foreach file ($files)
	echo downloading $site/$path/$file
	/bin/wget -q --tries=1 $site/$path/$file
end	 

echo done!
