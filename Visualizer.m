function [] = Visualizer( imgBN, Colori)
%Visualizer permette di valutare cromaticamente la postura acquisita
%   Input:
%       metaDataDepth.SegmentationData, l'immagine BN viene utilizzata come
%       riferimento per le campiture di colore
%       
%       colori, contiene l'immagine RGB con le zone di maggior distacco dal
%       riferimento di postura colorate
%
%       info, è l'uscita dell'acquisizione della balance board con le
%       informazioni sulla distribuzione del peso
figure();
mesh(Colori(:,:,1));
hold on;
mesh(Colori(:,:,2));
mesh(Colori(:,:,3));
mesh(imgBN());
hold off;
end

