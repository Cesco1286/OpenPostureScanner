classdef Kinect
    properties
        vidRGB;
        vidDepth;
        srcDepth;
        DepthFrame;
        RGBFrame;
    end
    
    methods
        function kinect = Kinect()
        kinect.vidRGB=videoinput('kinect',1,'RGB_640x480');
        kinect.vidDepth = videoinput('kinect',2,'Depth_640x480');
        kinect.srcDepth = getselectedsource(kinect.vidDepth);
    
        end
    
        function setAngle(kinect)
        preview(kinect.vidRGB);
        angleOK=0;
        while angleOK==0,
            angle=input('inserire l''angolo da aggiungere all''attuale\n');
            if kinect.srcDepth.CameraElevationAngle+angle>=0 && kinect.srcDepth.CameraElevationAngle+angle<=27
                kinect.srcDepth.CameraElevationAngle=kinect.srcDepth.CameraElevationAngle+angle;
            end
            angleOK=input('se l''angolo è ok inserire 1, 0 altrimenti');
        end
        closepreview(kinect.vidRGB);
        end

        function acquisisci(kinect)
        kinect.srcDepth.TrackingMode ='Skeleton';
        kinect.srcDepth.SkeletonsToTrack=1;
        
        %specifichiamo il numero di frame memorizzati per trigger
        kinect.vidDepth.FramesPerTrigger = 1;
        kinect.vidDepth.TriggerRepeat=200;
        kinect.vidRGB.TriggerRepeat=200;
        triggerconfig([kinect.vidDepth kinect.vidRGB],'manual');

        %% start acquisizione
        start([kinect.vidDepth kinect.vidRGB]);
        trigger([kinect.vidDepth kinect.vidRGB]); %cattura i frame
        [DepthFrame, ts, metaDataDepth] = getdata(kinect.vidDepth);
        [RGBFrame, ts_rgb, metaDataRGB] = getdata(kinect.vidRGB);
        while metaDataDepth.IsSkeletonTracked==0,
            trigger([vidDepth vidRGB]);
            [DepthFrame, ts, metaDataDepth] = getdata(kinect.vidDepth);
            [RGBFrame, ts_rgb, metaDataRGB] = getdata(kinect.vidRGB);
        end
        stop([kinect.vidDepth kinect.vidRGB]);
        kinect.DepthFrame= DepthFrame;
        kinect.RGBFrame= RGBFrame;
        end
        
        function launchPreview(kinect)
            preview(kinect.vidRGB);
        end 
        
        function closePreview(kinect)
            closepreview(kinect.vidRGB);
        end 
        
    end
end
    