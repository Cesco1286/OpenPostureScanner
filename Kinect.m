classdef Kinect < handle
    properties
        vidRGB;
        vidDepth;
        srcDepth;
        DepthFrame;
        RGBFrame;
        metadati;
        skeletonId;
        
    end
    
    methods
        function kinect = Kinect()
        kinect.vidRGB=videoinput('kinect',1,'RGB_640x480');
        kinect.vidDepth = videoinput('kinect',2,'Depth_640x480');
        kinect.srcDepth = getselectedsource(kinect.vidDepth);
    
        end
        
%         function kinect=set.metadati(kinect,metadati)
%             kinect.metadati=metadati;
%         end
%  
           function kinect=setMetadati(kinect,metadati)
               kinect.metadati=metadati;
           end
           
           function kinect=setRGBFrame(kinect,RGBFrame)
               kinect.RGBFrame=RGBFrame;
           end
 
           function kinect=setSkeletonId(kinect,skeletonId)
               kinect.skeletonId=skeletonId;
           end
            
           
%         function setAngle(kinect)
%         preview(kinect.vidRGB);
%         angleOK=0;
%         while angleOK==0,
%             angle=input('inserire l''angolo da aggiungere all''attuale\n');
%             if kinect.srcDepth.CameraElevationAngle+angle>=0 && kinect.srcDepth.CameraElevationAngle+angle<=27
%                 kinect.srcDepth.CameraElevationAngle=kinect.srcDepth.CameraElevationAngle+angle;
%             end
%             angleOK=input('se l''angolo è ok inserire 1, 0 altrimenti');
%         end
%         closepreview(kinect.vidRGB);
%         end

      function kinect= setAngle(kinect,angle)
              kinect.srcDepth.CameraElevationAngle=kinect.srcDepth.CameraElevationAngle+angle;
        end


        function kinect = acquisisci(kinect)
            stop([kinect.vidDepth kinect.vidRGB]);
            kinect.srcDepth.TrackingMode ='Skeleton';
            kinect.srcDepth.SkeletonsToTrack=1;
            
            %specifichiamo il numero di frame memorizzati per trigger
            kinect.vidDepth.FramesPerTrigger = 1;
            kinect.vidDepth.TriggerRepeat=200;
            kinect.vidRGB.TriggerRepeat=200;
            triggerconfig([kinect.vidDepth kinect.vidRGB],'manual');
            skID=99;
            %% start acquisizione
            acquired=0;
            start([kinect.vidDepth kinect.vidRGB]);
            while acquired==0,
                %if input('premere 1 per fare una nuova acquisizione\n'), %
                % nella versione precedente, questa funzione ciclava
                % sull'input da tastiera. adesso l'acquisizione è diventata
                % completamente tasparente all'utente dell'applicazione, e
                % in caso di mancato riconoscimento dello scheletro, viene
                % mostrato un popup che segnala l'errore.
                
                
                    trigger([kinect.vidDepth kinect.vidRGB]);
                    [DepthFrame, ts, metaDataDepth] = getdata(kinect.vidDepth);
                    [RGBFrame, ts_rgb, metaDataRGB] = getdata(kinect.vidRGB);
                    
                    % Fixme: attualmente lo skeletonID per lo skeletonViewer viene
                    % trovato tramite un for.
                    % Sicuramente c'è un modo per farlo in una sola riga
                    % skID=metaDataDepth.JointImageIndices(~=0);
                    % fiXME
                    for val=1:6,
                        if metaDataDepth.JointImageIndices(:,:,val)~=0,
                            skID=val;
                        end
                    end
                    
                    %skeleton=skeletonViewer(metaDataDepth.JointImageIndices,imgColor,1,skID);
                    if skID==99,
                        ScheletroAcqError(); %%QUANDO LO SCHELETRO NON VIENE RICONOSCIUTO, l'esecuzione di questa funzione si blocca
                        stop([kinect.vidDepth kinect.vidRGB]);%e viene mostrato un popup
                        return;
                    else acquired=1;
                    end
             end
            

              kinect.setRGBFrame(RGBFrame);
              kinect.setMetadati(metaDataDepth);
              
              kinect.setSkeletonId(skID); 
              stop([kinect.vidDepth kinect.vidRGB]);
            
        end
        
        function startPreview(kinect)
            preview(kinect.vidRGB);
        end 
        
        function closePreview(kinect)
            closepreview(kinect.vidRGB);
        end 
        
        function stopCamera(kinect)
            stop([kinect.vidDepth kinect.vidRGB]);
        end 
        
        function f = getFrameRGB(kinect)
            f=kinect.RGBFrame;
        end %fixme
        
        function m = getMetaDati(kinect) %fixme
        m=kinect.metadati;
        end
        
        function m = getSkeletonId(kinect) %fixme
        m=kinect.skeletonId;
        end
    end
end
    
