function [ metaDataDepth, imgColor ] = acquisition()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% setup variabili
angleOK=0;
acquired=0;
vidRGB = videoinput('kinect',1,'RGB_640x480');
%srcRGB = getselectedsource(vidRGB);

vidDepth = videoinput('kinect',2,'Depth_640x480');
srcDepth = getselectedsource(vidDepth);

% interattività per mettere a posto l'angolazione
preview(vidRGB);
while angleOK==0,
    
    angle=input('inserire l''angolo da aggiungere all''attuale\n');
    if srcDepth.CameraElevationAngle+angle>=0 & srcDepth.CameraElevationAngle+angle<=27
        srcDepth.CameraElevationAngle=srcDepth.CameraElevationAngle+angle;
    end
    angleOK=input('se l''angolo è ok inserire 1, 0 altrimenti\n');
    
end
closepreview(vidRGB);

srcDepth.TrackingMode ='Skeleton';
srcDepth.SkeletonsToTrack=1;



%specifichiamo il numero di frame memorizzati per trigger
vidDepth.FramesPerTrigger = 1;
vidDepth.TriggerRepeat=200;
vidRGB.TriggerRepeat=200;

triggerconfig([vidDepth vidRGB],'manual');

%% start acquisizione
start([vidDepth vidRGB]);

% controllo interattivo sull'acquisizione, continua ad acquisire fino a che
% si inserisce 1 alla domanda dell'acquisizione corretta
%
while acquired==0,
    if input('premere 1 per fare una nuova acquisizione\n'),
        trigger([vidDepth vidRGB]);
        [frame, ts, metaDataDepth] = getdata(vidDepth);
        [imgColor, ts_rgb, metaDataRGB] = getdata(vidRGB);
        
        %attualmente la chiamata dello skeletonViewer funziona ma non
        %riesco a tirare fuori l'ID dello scheletro. Sicuramente
        %qualcun'altro l'ha fatto prima di noi.
        % skID=metaDataDepth.JointImageIndices(:,:,~=0);
        skeletonViewer(metaDataDepth.JointImageIndices,imgColor,1,ERROR);
        acquired=input('inserire 1 se l''acquisizione è corretta, 0 altrimenti\n');
    end
end

stop([vidDepth vidRGB]);
return;



% controllo su "metaData.isSkeletonTracked" -> se è 1, possiamo fermare l'acquisizione,altrimenti dobbiamo riottenere i metadati.(sia DEPTH che RGB)
%
%skelViewer
% imshow(imgColor(:,:,1:3),[]);
% answer=input('Is this image ok? y/n ','s');
% if answer == 'y' || metaDataDepth.IsSkeletonTracked==0,
%     while answer=='n' || metaDataDepth.IsSkeletonTracked==0,
%         if metaDataDepth.IsSkeletonTracked==0,
%             disp('lo scheletro non è stato riconosciuto.');
%         end
%         trigger([vidRGB vidDepth]);
%         [frame, ts, metaDataDepth] = getdata(vidDepth);
%         [imgColor, ts_rgb, metaDataRGB] = getdata(vidRGB);
%
%         imshow(imgColor(:,:,1:3),[]);
%         answer= input('Is this image ok? y/n ','s');
%     end
% end
%
% stop([vidDepth vidRGB]);
% return;
end
