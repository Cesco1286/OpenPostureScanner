classdef (Sealed) Controller < handle 
    properties
        kinect;
        balanceBoard;
        parametriRiferimento;
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
        
        function acquisisci(controller)
            controller.kinect.acquisisci();
            scheletro= Skeleton(controller.kinect.getMetaDati.JointImageIndices(:,:,(controller.kinect.getSkeletonId)));
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
        
       %matrice 20x2 allo scheletro . va creato all'interno
       %dell'acquisizione (che comprenderà acquisizione kinect e scheletro
       %scheletro , bb,parametri riferimento 
        
       
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
        
        