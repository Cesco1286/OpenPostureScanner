%% funzione di visualizzazione errori per colori sulla sagoma

% Data una mappa parametro2errore restituisce un matrice 640x480x3 con
% valori positivi nelle zone che circondano le coordinate degli errori
% La dimensione del colore è proporzionale 10 volte all'entità
% dell'errore "x-(offset*errore)"

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
    
    %preparazione parametri per l'errore sulla prima coordinata
    errx_1=floor(max(x-(offset*errore),1));
    errx_2=floor(min(x+offset*errore,n));
    erry_1=floor(max( y-(offset*errore) ,1));
    erry_2=floor(min( (y+offset*errore),m));
    errx=errx_2-errx_1;
    erry=erry_2-erry_1;
    dist=fftshift(distmatrix(erry,errx));
    
    %preparazione parametri per l'errore sulla seconda coordinata
    errx1_1=floor(max(x1-(offset*errore),1));
    errx1_2=floor(min(x1+offset*errore,n));
    erry1_1=floor(max( y1-(offset*errore) ,1));
    erry1_2=floor(min( (y1+offset*errore),m));
    errx1=errx1_2-errx1_1;
    erry1=erry1_2-erry1_1;
    dist1=fftshift(distmatrix(erry1,errx1));
    
    %colorazione porzione di matrice, un errore nullo è colorato di blu,
    %errore trascurabile è colorato di verde, errore maggiore di 1.5 è
    %rosso.
    if errore==0
        mat( erry_1+1:erry_2 , errx_1+1:errx_2, 3)=((dist/max(max(dist)))-1)*-1*errore;
        mat( erry1_1+1:erry1_2 ,errx1_1+1:errx1_2, 3)=((dist1/max(max(dist1)))-1)*-1*errore;
        
    elseif errore<1.5
        mat( erry_1+1:erry_2, errx_1+1:errx_2, 2)=((dist/max(max(dist)))-1)*-1*errore;
        mat( erry1_1+1:erry1_2 ,errx1_1+1:errx1_2, 2)=((dist1/max(max(dist1)))-1)*-1*errore;
        
    else
        mat( erry_1+1:erry_2, errx_1+1:errx_2, 1)=((dist/max(max(dist)))-1)*-1*errore;
        mat( erry1_1+1:erry1_2 ,errx1_1+1:errx1_2, 1)=((dist1/max(max(dist1)))-1)*-1*errore;
        
    end %end if
end

return;
end
