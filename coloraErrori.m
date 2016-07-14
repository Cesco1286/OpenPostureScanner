 function mat= coloraErrori(parametro2errore)
    
   
    
    m=480;
	n=640;
	mat= zeros(m,n,3);
	offset= 10;
	keySet=keys(parametro2errore);
            
	for i=0:(parametro2errore.size()),
    	chiave= cell2mat(keySet(i)) ;
        valore=parametro2errore(chiave);
        errore=valore(1);
        x=valore(2);
        y=valore(3);
        x1=valore(4);
        y1=valore(1);
        if errore>0,
        	mat( max( y-(offset+errore) ,1):min( (y+offset+errore),m) , max(x-(offset+errore),1): min(x+offset+errore,n),1 )=errore;
            mat( max( y1-(offset+errore) ,1):min( (y1+offset+errore),m) , max(x1-(offset+errore),1): min(x1+offset+errore,n), 1 )=errore;
         end 
	end    
                
end