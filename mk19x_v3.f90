
	program mk19x
	
!
!	Extracting atomic lines from a Kurucz linelist
!	and formatting the output for synspec (.19 type of file)
!	including quantum numbers for the levels involved 
!	at the end of the line (2S+1, L, and P)
!
!	Input are: 1) the name of the input files
!		   2) the starting wavelength (nm)
!		   3) the ending wavelength (nm)
!
!
!	Carlos, February 5, 2005 
!	Carlos, March 21, 2006, expanded to print quantum numbers
!		(see mk19.f90 for the old version without them)
!
	
implicit none

real(selected_real_kind(14, 60))::	lambda_begin,lambda_end
real(selected_real_kind(14, 60))::	wl,gflog,newgflog,code,e,xj,ep,xjp
real(selected_real_kind(14, 60))::	astgflog,gammar,gammas,gammaw
real(selected_real_kind(14, 60))::	x1,hyp,iso
character(len=250) 		::	theline
character(len=30) 		::	infile
character(len=10)		::	label,labelp
character(len=7)		::	gftest1,gftest2
character(len=2)		::	two
character(len=4)		::	ref
character(len=1)		::	ch,firstchar
integer,parameter		:: 	nl=18 	!size of letters and numbers
character(len=1)		::	letters(nl)
integer				::	numbers(nl)
integer				::	i,inext=0,j,lent,s,l,p,s1,l1,p1
logical				::	notdone

!initialize
letters = (/'S','P','D','F','G','H','I','K','L','M','N','O','Q',  &
	    'R','T','U','V','W'/)
do i=1,nl
	numbers(i)=i-1
enddo
	

notdone=.true.
	
!write(*,*)'filename='
read(*,*)infile
!write(*,*)'lambda_begin[nm]='
read(*,*)lambda_begin
!write(*,*)'lambda_end[nm]='
read(*,*)lambda_end

open(1,file=infile,status='old')
		
do while (notdone)      	 
         theline=''
	 read(1,"(A250)",err=10,end=10) theline
	 read(theline,"(A1)",err=10,end=10) firstchar
	 if (firstchar /= "#") then
!  Here is where I make sure the hyperfine and isotope splitting parts are 0
                 HYP = 0
                 ISO = 0
                 !write(*,*)theline
		 read(theline,144,err=10,end=10)WL,GFLOG,CODE,E,XJ,LABEL,EP,	&
           XJP,LABELP,GAMMAR,GAMMAS,GAMMAW,REF,HYP,ISO

                 !write(*,*)WL,GFLOG,CODE,E,XJ,LABEL,EP,	&
           !XJP,LABELP,GAMMAR,GAMMAS,GAMMAW,REF,HYP,ISO
     	        	   
		  if((WL >= lambda_begin) .and. (WL <= lambda_end)) then

!  Here is where I add in the hyperfine and isotope splitting parts
                        GFLOG = GFLOG + HYP + ISO
!  The following is from the original code
     		 	do j=1,2	!lower and upper 
     	 	
     		 	!decode SLP
     		 	if (j == 2) label=labelp
     		 	lent=len_trim(label)
			ch=label(lent:lent)
			if (ch .eq. ']' .or. ch .eq. 'X'  			   &
				.or. ch .eq. '.' .or. ch .eq. '*' .or. ch .eq. '+' &
				.or. label(lent-2:lent) .eq. 'IES' 	           &
				.or. label(lent-2:lent) .eq. 'AGE') then 
				
			!we disregard right away the terms ending on 'X' or '*' or '.'
			!those with 'AVERAGE' or 'ENERGIES'
			!and those that follow a coupling notation different from LS
			
			   s=-1
			   l=-1
			   p=-1
			else
			
				!if present, we skip the X and read the  attached string
				!if (ch .eq. 'X') lent=lent-1
				!ch=label(lent:lent)
				
				l=-1
				do i=1,nl
					if (letters(i) .eq. ch) l=numbers(i)
				enddo
				if (l == -1) then
				!if we cannot identify L, chars to the left do not,
				!most likely, provide information on S and P			
					s=-1
					p=-1
				else
					ch=label(lent-1:lent-1)
					s=-1
					do i=0,10
						!write(*,*) iachar(ch)-48,i
						if (iachar(ch)-48 == i) s=i
					enddo
					ch=label(lent-2:lent-2)
						if (ch .eq. '*') then 
							p=1 
						elseif (ch .eq. ' ') then 
							p=0
						else
							p=-1
					endif
				endif
			endif
				
			!write(*,*)wl,label,'-->', s, l, p	
			
			if (j == 1) then 
				!store the first ones
				s1=s
				l1=l
				p1=p
			endif
			
			enddo					
			
		
      			if (CODE < 100) write(*,512)WL,CODE,GFLOG,E,XJ,EP,XJP,	&
                             GAMMAR,GAMMAS,GAMMAW,INEXT,s1,l1,p1,s,l,p	
                             
      	                       	
      		else
  			if (WL>lambda_end) notdone=.false.
      		endif
	 endif
     	   
     	 
enddo	
close(1)


!144 FORMAT(F9.4,1X,F7.3,1X,A7,9X,A7,10X,F8.2,F12.3,F5.1,1X,A10,F12.3,F5.1,1X,A10,F6.2,F6.2,F6.2,A4,8X,F6.3,3X,F6.3)
144 FORMAT(F11.4,F7.3,F6.2,F12.3,F5.1,1X,A10,F12.3,F5.1,1X,A10,F6.2,F6.2,F6.2,A4,7X,F6.3,3X,F6.3)
!1234567890112345671234561234567890121234511234567890123456789012123451123456789112345612345612345612341234567123456123123456
!     4.2225 -5.850  6.03  497735.000  0.5 9s 2S      2866000.000  1.5 (3S)5p 2P  10.52 -3.97 -7.15K14  0 0  0 0.000  0 0.000
!WL,GFLOG,CODE,E,XJ,LABEL,EP,XJP,LABELP,GAMMAR,GAMMAS,GAMMAW,REF,HYP,ISO
      
!512    FORMAT(F10.4,F6.2,F7.3,F12.3,F4.1,F12.3,F4.1,F7.2,F7.2,F7.2,I2)
!512    FORMAT(F10.4,F6.2,F7.3,F12.3,F4.1,F12.3,F4.1,F7.2,F7.2,F7.2,I2,6(I3))
512    FORMAT(F11.4,F7.2,F7.3,F12.3,F6.1,F12.3,F6.1,F7.2,F7.2,F7.2,I2,6(I3))

 10 continue
	
end
