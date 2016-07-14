%% funzione di visualizzazione errori per colori sulla sagoma

% Data una mappa parametro2errore restituisce un matrice 640x480x3 con
% valori positivi nelle zone che circondano le coordinate degli errori
% 

function mat= coloraErrori(parametro2errore)
    
   
    
    m=480;
	n=640;
	mat= zeros(m,n,3);
	offset= 10;
	keySet=keys(parametro2errore);
           
            
	for i=1:(parametro2errore.size()),
    	chiave= cell2mat(keySet(i)) ;
        valore=parametro2errore(chiave);
        errore=abs(valore(1));
        x=valore(2);
        y=valore(3);
        x1=valore(4);
        y1=valore(5);
        if errore<1.5                 %un commentino please
            mat( max( y-(offset+errore) ,1):min( (y+offset+errore),m) , max(x-(offset+errore),1): min(x+offset+errore,n), 2)=errore;
            mat( max( y1-(offset+errore) ,1):min( (y1+offset+errore),m) , max(x1-(offset+errore),1): min(x1+offset+errore,n), 2 )=errore;
        else
            mat( max( y-(offset+errore) ,1):min( (y+offset+errore),m) , max(x-(offset+errore),1): min(x+offset+errore,n),1 )=errore;
            mat( max( y1-(offset+errore) ,1):min( (y1+offset+errore),m) , max(x1-(offset+errore),1): min(x1+offset+errore,n), 1 )=errore;
        end 
	end    
    return;            
end
