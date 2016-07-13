classdef Elaboratore < handle
       
    %ELABORATORE si occupa di calcolare gli errori di postura
    %   i parametri su cui vengono calcolati gli errori sono gli angoli
    %   delle ossa dello scheletro e le posizioni dei Joint dello
    %   scheletro. Queste informazioni vengono confrontate con gli
    %   attributi di un oggetto ParametriUtente. Attualmente la
    %   BalanceBoard non è prevista nell'elaborazione degli errori
    
    properties
        %% misure sull'oggetto skeleton
        %asse delle spalle, un oggetto Bone(jointA, jointB, name) calcolato tra i Joint Shoulder_Left e
        %Shoulder_Right
        shoulder_axis=Bone();
        
        %   angolo schiena spalle
        angle_backbone_shoulders;
        
        %   angolo schiena
        angle_backbone;
        
        %   angolo hipbone e schiena
        angle_hipbone_backbone;
        
        %   differenza tra l'altezza dei Joint dei fianchi
        hip_right_left;
        
        %   differenza tra l'altezza dei Joint delle ginocchia
        knee_right_left;
        
        %% scostamenti calcolati tra i parametri utente e le misure rilevate
        % errore angolo schiena spalle
        err_angle_backbone_shoulders;
        
        % errore angolo schiena
        err_angle_backbone;
        
        % errore angolo hipbone e schiena
        err_angle_hipbone_backbone;
        
        % errore differenza tra l'altezza dei Joint dei fianchi
        err_hip_right_left;
        
        % errore differenza tra l'altezza dei Joint delle ginocchia
        err_knee_right_left;
        
    end
    
    methods
        %costruttore, attualmente vengono elaborati solo i dati
        %dell'oggetto skeleton, verrà poi aggiunta la misura della
        %balanceboard
        % Input: oggetto Skeleton
        % Funzioni: vengono utilizzate le funzioni GET di Skeleton.m,
        % Bone.m e Joint.m
        function elab = Elaboratore(skel)
            if(nargin>0)
                %assegnazione shoulder_axis, i numeri nei parametri sono
                %riferiti alla numerazione assegnata dalla kinect,
                %esplicitata nella classe Skeleton
                spallaDestra=skel.getJointMap(9);
                spallaSinistra=skel.getJointMap(5);
                elab.shoulder_axis=Bone(spallaSinistra,spallaDestra,'Shoulder_Axis');
                
                %assegnazione angle_backbone_shoulders
                elab.angle_backbone_shoulders=abs(elab.shoulder_axis.GetAngleBone()-skel.getBone('BackBone').GetAngleBone());
                
                %assegnazione angle_backbone
                elab.angle_backbone=skel.getBone('BackBone').GetAngleBone();
                
                %assegnazione angle_hipbone_backbone
                elab.angle_hipbone_backbone=abs(skel.getBone('HipBone').GetAngleBone())+abs(skel.getBone('BackBone').GetAngleBone());
           
                %assegnazione hip_right_left, i numeri nei parametri sono
                %riferiti alla numerazione assegnata dalla kinect,
                %esplicitata nella classe Skeleton
                elab.hip_right_left=abs(skel.getJointMap(13).GetY()-skel.getJointMap(17).GetY());
                
                %assegnazione knee_right_left, i numeri nei parametri sono
                %riferiti alla numerazione assegnata dalla kinect,
                %esplicitata nella classe Skeleton
                elab.knee_right_left=abs(skel.getJointMap(14).GetY()-skel.getJointMap(18).GetY());
            end
            end

        
        %% funzioni di elaborazione 
        function errori=CalcoloErrori(elab, paramUtenti)
%          angle_backbone_shoulders;
%          angle_backbone;
%          angle_hipbone_backbone;
%          hip_right_left;
%          knee_right_left;
            errori(1)=paramUtenti.Get_angle_backbone_shoulders()-elab.Get_angle_backbone_shoulders();
            err_angle_backbone_shoulders=errori(1);
           
            errori(2)=paramUtenti.Get_angle_backbone()-elab.Get_angle_backbone();
            err_angle_backbone=errori(2);
            
            errori(3)=paramUtenti.Get_angle_hipbone_backbone()-elab.Get_angle_hipbone_backbone();
            err_angle_hipbone_backbone=errori(3);
            
            errori(4)=paramUtenti.Get_hip_right_left()-elab.Get_hip_right_left();
            err_hip_right_left=errori(4);
            
            errori(5)=paramUtenti.Get_knee_right_left()-elab.Get_knee_right_left();
            err_knee_right_left=errori(5);
            
            return;
        end

   
    
     %% funzioni GET per attributi
        % funzione Get per angle_backbone_shoulders
        function angle= Get_angle_backbone_shoulders(elab)
            angle=elab.angle_backbone_shoulders;
            return;
        end
        
        % funzione Get per angle_backbone
        function  angle = Get_angle_backbone(elab)
            angle=elab.angle_backbone;
            return;
        end
        
        % funzione Get per angle_hipbone_backbone
        function angle = Get_angle_hipbone_backbone(elab)
            angle=elab.angle_hipbone_backbone;
            return;
        end
        
        % funzione Get per hip_right_left
        function angle = Get_hip_right_left(elab)
            angle=elab.hip_right_left;
            return;
        end
        
        % funzione Get per knee_right_left
        function angle = Get_knee_right_left(elab)
            angle=elab.knee_right_left;
            return;
        end
         end
        
end

