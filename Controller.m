classdef (Sealed) Controller < handle 
    properties
        kinect;
        balanceBoard;
        parametriUtente;
        scheletro; 
    end
    
    methods 
        function controller= Controller
            controller.kinect = Kinect();
            %controller.balanceBoard=BalanceBoard();
        end
        
        function setKinectAngle(controller)
            controller.kinect.setAngle();
        end
        
        function  controller=acquisisci(controller)
            controller.kinect.acquisisci();
            scheletro= Skeleton(controller.kinect.getMetaDati.JointImageIndices(:,:,(controller.kinect.getSkeletonId)));
            controller.setScheletro(scheletro);
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
        
        
