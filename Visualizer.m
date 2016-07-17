function visual = Visualizer( imgBN, Colori)
%Visualizer permette di valutare cromaticamente la postura acquisita
%   Input:
%       metaDataDepth.SegmentationData, l'immagine BN viene utilizzata come
%       riferimento per le campiture di colore
%       
%       colori, contiene l'immagine RGB con le zone di maggior distacco dal
%       riferimento di postura colorate
%

%normalizzazione imgBN
imgBN=imgBN/max(max(imgBN));

%scontorno alla sagoma, imgBN.^-1 da i bianchi==Inf
coloriSagoma3=Colori(:,:,3)+imgBN.^-1;
coloriSagoma2=Colori(:,:,2)+imgBN.^-1;
coloriSagoma1=Colori(:,:,1)+imgBN.^-1;
coloriSagoma(:,:,1)=coloriSagoma1;
coloriSagoma(:,:,2)=coloriSagoma2;
coloriSagoma(:,:,3)=coloriSagoma3;

%range colori [0 - 255]
coloriSagoma(coloriSagoma(:,:,:)==Inf)=256;
coloriSagoma=coloriSagoma-1;
coloriSagoma(coloriSagoma(:,:,:)==-1)=0;

% 
% figure();
% mesh(Colori(:,:,1));
% hold on;
% mesh(Colori(:,:,2));
% mesh(Colori(:,:,3));
% mesh(imgBN());
% hold off;
% 
% figure();
% imshow(coloriSagoma,[]);

visual=coloriSagoma;
return;
end
