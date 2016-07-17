function [ metaDataDepth, imgColor ] = acquisition()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% setup variabili
angleOK=0;
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
    angleOK=input('se l''angolo è ok inserire 1, 0 altrimenti');
   
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

% Get the data on the object.
trigger([vidDepth vidRGB]); %cattura i frame

[frame, ts, metaDataDepth] = getdata(vidDepth);
[imgColor, ts_rgb, metaDataRGB] = getdata(vidRGB);


% controllo su "metaData.isSkeletonTracked" -> se è 1, possiamo fermare l'acquisizione,altrimenti dobbiamo riottenere i metadati.(sia DEPTH che RGB)
%
while metaDataDepth.IsSkeletonTracked==0,
    trigger([vidDepth vidRGB]);
    [frame, ts, metaDataDepth] = getdata(vidDepth);
    [imgColor, ts_rgb, metaDataRGB] = getdata(vidRGB);
end

stop([vidDepth vidRGB]);
return;
end