%% funzione di visualizzazione errori per colori sulla sagoma

% Data una mappa parametro2errore restituisce un matrice 640x480x3 con
% valori positivi nelle zone che circondano le coordinate degli errori
% La dimensione del colore � proporzionale 10 volte all'entit�
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
    errx_1=floor(max(x-(offset*errore),1)); %parte intera del max tra.. tra?
    errx_2=floor(min(x+offset*errore,n));
    erry_1=floor(max( y-(offset*errore) ,1));
    erry_2=floor(min( (y+offset*errore),m));
    errx=errx_2-errx_1;
    erry=erry_2-erry_1;
    
    %preparazione parametri per l'errore sulla seconda coordinata
    errx1_1=floor(max(x1-(offset*errore),1));
    errx1_2=floor(min(x1+offset*errore,n));
    erry1_1=floor(max( y1-(offset*errore) ,1));
    erry1_2=floor(min( (y1+offset*errore),m));
    errx1=errx1_2-errx1_1;
    erry1=erry1_2-erry1_1;
    
    
    % creazione effetto sfumatura
    dist=fftshift(distmatrix(erry,errx));
    dist1=fftshift(distmatrix(erry1,errx1));
    
    
    %colorazione porzione di matrice, un errore nullo � colorato di blu,
    %errore trascurabile � colorato di verde, errore maggiore di 1.5 �
    %rosso.
    if errore==0
        colore=3;
     elseif errore<1.5
        colore=2;
    else
        colore=1;
    end %end if
    
    %aggiunta colori sulle matrici RGB, il +1 sulle coordinate � un
    %magheggio
    mat( erry_1+1:erry_2, errx_1+1:errx_2, colore)=((dist/max(max(dist)))-1)*errore;
    mat( erry1_1+1:erry1_2 ,errx1_1+1:errx1_2, colore)=((dist1/max(max(dist1)))-1)*errore;
    
end %end for

return;
end