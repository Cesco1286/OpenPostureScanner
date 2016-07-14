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
    end
    
    methods 
        function controller= Controller
            controller.kinect = Kinect();
            %controller.balanceBoard=BalanceBoard();
        end
        
        function setKinectAngle(controller)
            controller.kinect.setAngle();
        end
        
        %% questa funzione viene lanciata dal tasto "start" dell'ui 'SchermataPrincipale'
        %%acquisice il frame dalla kinect, costruisce lo scheletro e
        %%memorizza all'interno della variabile errore2parametro la mappa
        %%con i valori e le coordinate degli errori. memorizza inoltre
        %%l'elaboratore
        function  controller=acquisisci(controller)
            controller.kinect.acquisisci();
            scheletro= Skeleton(controller.kinect.getMetaDati.JointImageIndices(:,:,(controller.kinect.getSkeletonId)));
            controller.setScheletro(scheletro);
            elaboratore= Elaboratore(scheletro);
            controller.setElaboratore(elaboratore);
            err=elaboratore.CalcoloErrori(controller.parametriUtente);
            errore2parametro=elaboratore.export();
           
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
            controller.parametriUtente= param; 
        end 
       
        function controller=setElaboratore(controller,elab)
            controller.elaboratore= elab; 
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
        
        
