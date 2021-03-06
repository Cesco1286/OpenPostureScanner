classdef (Sealed) Controller < handle 
    %%la classe controller gestisce gli eventi e le chiamate dalle varie
    %%UI.E' singleton e puo esisterne una sola istanza per esecuzione.
    %% per utilizzare i suoi metodi usare il metodo getInstance (descritto sotto)
    properties
        kinect;
        balanceBoard;
        parametriUtente;
        scheletro; 
        elaboratore;
        errore2parametro;
    end
    
    methods 
        function controller= Controller
            controller.kinect = Kinect();
            %controller.balanceBoard=BalanceBoard();
        end
        
        function setKinectAngle(controller,angle)
            %controller.kinect.setAngle();
            controller.kinect.setAngle(angle);
        end
        
        %% questa funzione viene lanciata dal tasto "start" dell'ui 'SchermataPrincipale'
        %%acquisice il frame dalla kinect, costruisce lo scheletro e
        %%memorizza all'interno della variabile errore2parametro la mappa
        %%con i valori e le coordinate degli errori. memorizza inoltre
        %%l'elaboratore
        % ritorna img, ovvero l'immagine che viene poi mostrata in axes
        % dall'UI
        function  img =acquisisci(controller)
            controller.kinect.acquisisci();
            schel= Skeleton(controller.kinect.getMetaDati.JointImageIndices(:,:,(controller.kinect.getSkeletonId)));
            controller.setScheletro(schel);
            elab=Elaboratore(schel);
            controller.setElaboratore(elab);
            elab.CalcoloErrori(controller.parametriUtente);
            errore2param=elab.Export();
            controller.setErrore2parametro(errore2param);
            img = Visualizer(controller.kinect.metadati.SegmentationData , coloraErrori(controller.errore2parametro)); 
            return;
        end
        
        %function setParametriRiferimento(controller) 
        
        function startKinectPreview(controller)
            controller.kinect.startPreview();
        end
        
        function stopKinectPreview(controller)
            controller.kinect.stopPreview();
        end
        
        function stopCamera(controller)
            controller.kinect.stopCamera();
        end
        
        function controller=setScheletro(controller,scheletro)
            controller.scheletro=scheletro;
        end
        
      
        function controller=setParametriUtente(controller,param)
            controller.parametriUtente=param;
            
        end 
       
        function controller=setElaboratore(controller,elab)
            controller.elaboratore= elab; 
        end 
       
        function controller=setErrore2parametro(controller,err)
            controller.errore2parametro= err; 
        end 
       
    end 
    methods (Static) 
        function singleController = getInstance
            persistent localController 
            if isempty(localController) || ~isvalid(localController)
            localController = Controller ;    
            end
            singleController = localController;
        end
        
    end
    

end
