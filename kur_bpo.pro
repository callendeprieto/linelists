pro kur_bpo,datfile,fixed_datfile,x=x

;+
;	Given a Kurucz/synspec .19 file with spectral lines, this routine 
;	searches Barklem et al (2002; BPO) line list and adds H broadening 
;	constants for the lines in BPO's list.
;
;	IN: datfile	 	-string		name of the .19 input file 
;	    fixed_datfile	-string		name of the .19 output file
;
;	C. Allende Prieto, UT, 2004 - adapted from miss_bpo
;			 , UT, 2006 - keyword 'x' introduced to handle the
;				eXtended linelist format [usual + (2*S+1)LP]
;-

if N_params() lt 2 then begin
	print,'% KUR_BPO: use - kur_bpo,datfile,fixed_datfile[,x=x]'
	return
endif

myformat='(F11.4,F7.2,F7.3,F12.3,F6.1,F12.3,F6.1,F7.2,F7.2,F7.2,I2,6(I3))'


get_lun,u
get_lun,v
d=dblarr(16,4891)
openr,u,'./table1.dat'
readf,u,d
close,u 
openr,u,datfile
openw,v,fixed_datfile
if keyword_set(x) then begin
while not eof(u) do begin
	row=dblarr(17)	
	readf,u,row,$
	;format='(F10.4,F6.2,F7.3,F12.3,F4.1,F12.3,F4.1,F8.2,F7.2,F7.2,I2,6(I3))'
	format=myformat
	;print,'% KUR_BPO: Line ',row[0],' nm'
	w=where(abs(row(1)-d(0,*)) le 1e-3 $
		and abs(row(0)*10.d0-d(1,*)) le 0.01 and $
		((abs(row(3)-d(6,*)) le 0.1 and abs(row(5)-d(8,*)) le 0.1) or $
		 (abs(row(3)-d(8,*)) le 0.1 and abs(row(5)-d(6,*)) le 0.1)))
	if (n_elements(w) eq 1 and max(w) gt -1) then begin
		print,'% KUR_BPO: Line ',row[0],' nm : ',row(9),' -> ',d(14,w(0))
		row(9)=d(14,w(0))
		printf,v,row,format=myformat
		;format='(F10.4,F6.2,F7.3,F12.3,F4.1,F12.3,F4.1,F8.2,F7.2,F7.2,I2,6(I3))'
	endif else begin
		printf,v,row,format=myformat
		;format='(F10.4,F6.2,F7.3,F12.3,F4.1,F12.3,F4.1,F8.2,F7.2,F7.2,I2,6(I3))'
	endelse
endwhile
endif else begin
while not eof(u) do begin
	row=dblarr(11)	
	readf,u,row,$
	format='(F10.4,F6.2,F7.3,F12.3,F4.1,F12.3,F4.1,F8.2,F7.2,F7.2,I2)'
	;print,'% KUR_BPO: Line ',row[0],' nm'
	w=where(abs(row(1)-d(0,*)) le 1e-3 $
		and abs(row(0)*10.d0-d(1,*)) le 0.01 and $
		((abs(row(3)-d(6,*)) le 0.1 and abs(row(5)-d(8,*)) le 0.1) or $
		 (abs(row(3)-d(8,*)) le 0.1 and abs(row(5)-d(6,*)) le 0.1)))
	if (n_elements(w) eq 1 and max(w) gt -1) then begin
		print,'% KUR_BPO: Line ',row[0],' nm : ',row(9),' -> ',d(14,w(0))
		row(9)=d(14,w(0))
		printf,v,row,format='(F10.4,F6.2,F7.3,F12.3,F4.1,F12.3,F4.1,F8.2,F7.2,F7.2,I2)'
	endif else begin
		printf,v,row,format='(F10.4,F6.2,F7.3,F12.3,F4.1,F12.3,F4.1,F8.2,F7.2,F7.2,I2)'
	endelse
endwhile
endelse

close,/all
free_lun,u & free_lun,v
end
