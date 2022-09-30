
program mk20

!
!	Extracting molecular lines from a Kurucz  linelist
!	and formatting the output for synspec (.20 type of file)
!	The damping constants are as proposed by Kurucz.
!
!	Input are: 1) the name of the input file
!		   2) the starting wavelength (nm)
!		   3) the ending wavelength (nm)
!
!
!	Carlos, October 23 2004
!		June 21, 2007, revised to account for isotopes
!               July 16, 2018, revised, made simple to work with all
!                       Kurucz files
!
	
implicit none
	
	

real(selected_real_kind(14, 60))::	WL,GFLOG,J,E,JP,EP,ZEFF,EFFNSQ,GFLOGCORR
real(selected_real_kind(14, 60))::	GAMMAS,GAMMAR,GAMMAW,WLVAC
real(selected_real_kind(14, 60))::	lambda_begin,lambda_end
character(len=4)                ::      code
real(selected_real_kind(14, 60))::	fcode
integer				::	I,ISO,ION
integer				::	LABEL1B,LABEL1D
integer				::	LABEL2B
integer				::	n_iso
integer,allocatable		::	label_iso(:) !identifier
real(selected_real_kind(14, 60)), &
allocatable			::	labu_iso(:)  !log10(fractions)
character(len=1)		::	LABEL1A,LABEL1C
character(len=1)		::	LABEL2A,LABEL2C,LABEL2D
character(len=30)		::	filename
character(len=22)		::      junk
logical				::	notdone

!write(*,*)'filename='
read(*,*)filename
!write(*,*)'lambda_begin[nm]='
read(*,*)lambda_begin
!write(*,*)'lambda_end[nm]='
read(*,*)lambda_end
!write(*,*)'number of isotopes='
read(*,*)n_iso

!allocate arrays with ids and abundance fractions
allocate(label_iso(n_iso))
allocate(labu_iso(n_iso))

do i=1,n_iso
	!write(*,*)'LABEL_iso='
	read(*,*)label_iso(i)
	!write(*,*)'ABU_iso (total=1.0)='
	read(*,*)labu_iso(i)
enddo

ION=1                                                                     
ZEFF=ION                                                                  
EFFNSQ=25.                                                                
GAMMAS=1.0E-8*EFFNSQ**2*SQRT(EFFNSQ)                                      
GAMMAW=1.E-7                   

notdone=.true.

open(11,file=filename,status='old')
	
do while (notdone) 
	
 read(11,'(F10.4,F7.3,F5.1,F10.3,F5.1,F11.3,A20,I2)', &
        !,I4,A1,I2,A1,I1,3X,A1,I2,A1,A1,3X,I2)', &
 	end=10) &
	WL,GFLOG,J,E,JP,EP,JUNK,ISO
	
!write(*,*)'junk=',junk
!write(*,*)'iso=',ISO

	!,CODE, &
	!LABEL1A,LABEL1B,LABEL1C,LABEL1D,LABEL2A,LABEL2B,LABEL2C,LABEL2D,ISO

 if((WL >= lambda_begin) .and. (WL <= lambda_end)) then
 
 GFLOGCORR=0.0
 do i=1,n_iso
 	if (ISO .eq. label_iso(i)) then
 		GFLOGCORR=labu_iso(i)
 		exit
 	endif
 enddo
  
 if (i .gt. n_iso) then
  write(*,*)'====>',WL
  stop 'Cannot match this line with the isotope list'
 endif
   
   WLVAC=1.E7/ABS(ABS(EP)-ABS(E))
   GAMMAR=2.223E13/WLVAC**2                                                  
   IF(LABEL2A.EQ.'X')THEN
      GAMMAR=GAMMAR*.001
      GAMMAS=3.E-8
!     GAMMAW=3.E-9
      GAMMAW=1.E-8
   ENDIF
   
   !GR=LOG10(GAMMAR)
   !GS=LOG10(GAMMAS)
   !GW=LOG10(GAMMAW)
   
   code = junk
   read(code , *) fcode
	
   write(*,'(F10.4,F10.2,F8.3,F12.3,E10.2,E10.2,E10.2)') &
	WL,fcode,GFLOG+GFLOGCORR,abs(E),GAMMAR,GAMMAS,GAMMAW
  else
  	if (WL>lambda_end) notdone=.false.
  endif

enddo

10 continue

end

