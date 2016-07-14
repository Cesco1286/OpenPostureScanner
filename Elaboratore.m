classdef Elaboratore < handle
    
    %ELABORATORE si occupa di calcolare gli errori di postura
    %   i parametri su cui vengono calcolati gli errori sono gli angoli
    %   delle ossa dello scheletro e le posizioni dei Joint dello
    %   scheletro. Queste informazioni vengono confrontate con gli
    %   attributi di un oggetto ParametriUtente. Attualmente la
    %   BalanceBoard non è prevista nell'elaborazione degli errori
    
    properties
        %asse delle spalle, un oggetto Bone(jointA, jointB, name) calcolato tra i Joint Shoulder_Left e
        %Shoulder_Right
        shoulder_axis=Bone();
        
        %% misure sull'oggetto skeleton
        % mappa delle misure sullo scheletro rilevato
        % KeySet: nome misura
        % ValueSet: [|misura|, X1, Y1, X2, Y2]
        keySet={'angle_backbone_shoulders','angle_backbone','angle_hipbone_backbone','hip_right_left','knee_right_left'};
        valueSet={[0, 0, 0, 0, 0],[0, 0, 0, 0, 0],[0, 0, 0, 0, 0],[0, 0, 0, 0, 0],[0, 0, 0, 0, 0]};
        misure;
        
        
        %% scostamenti calcolati tra i parametri utente e le misure rilevate
        % mappa degli errori calcolati
        % KeySet: nome errore
        % ValueSet: [|errore|, X1, Y1, X2, Y2]
        ErrKeySet={'err_angle_backbone_shoulders','err_angle_backbone','err_angle_hipbone_backbone','err_hip_right_left','err_knee_right_left'};
        ErrValueSet={[0, 0, 0, 0, 0],[0, 0, 0, 0, 0],[0, 0, 0, 0, 0],[0, 0, 0, 0, 0],[0, 0, 0, 0, 0]};
        errori;
        
        
    end
    
    methods
        %costruttore, attualmente vengono elaborati solo i dati
        %dell'oggetto skeleton, verrà poi aggiunta la misura della
        %balanceboard
        % Input: oggetto Skeleton
        % Funzioni: vengono utilizzate le funzioni GET di Skeleton.m,
        % Bone.m e Joint.m
        function elab = Elaboratore(skel)
            elab.misure=containers.Map(elab.keySet,elab.valueSet,'UniformValues',false);
            elab.errori=containers.Map(elab.ErrKeySet,elab.ErrValueSet,'UniformValues',false);
            
            if(nargin>0)
                %assegnazione shoulder_axis, i numeri nei parametri sono
                %riferiti alla numerazione assegnata dalla kinect,
                %esplicitata nella classe Skeleton
                spallaDestra=skel.getJointMap(9);
                spallaSinistra=skel.getJointMap(5);
                elab.shoulder_axis=Bone(spallaSinistra,spallaDestra,'Shoulder_Axis');
                
                %assegnazione angle_backbone_shoulders
                misura=abs(elab.shoulder_axis.GetAngleBone()-skel.getBone('BackBone').GetAngleBone());
                x1=spallaDestra.GetX();
                y1=spallaDestra.GetY();
                x2=spallaSinistra.GetX();
                y2=spallaSinistra.GetY();
                elab.misure('angle_backbone_shoulders')=[misura, x1, y1, x2, y2];
                
                %assegnazione angle_backbone
                misura=skel.getBone('BackBone').GetAngleBone();
                x1=((abs(skel.getJointMap(2).GetX()-skel.getJointMap(3).GetX()))/2)+min(skel.getJointMap(2).GetX(),skel.getJointMap(3).GetX());
                y1=((abs(skel.getJointMap(2).GetY()-skel.getJointMap(3).GetY()))/2)+min(skel.getJointMap(3).GetY(),skel.getJointMap(2).GetY());
                elab.misure('angle_backbone')=[misura, x1, y1, x1, y1];
                
                %assegnazione angle_hipbone_backbone
                misura=abs(skel.getBone('HipBone').GetAngleBone())+abs(skel.getBone('BackBone').GetAngleBone());
                x1=skel.getJointMap(1).GetX();
                y1=skel.getJointMap(1).GetY();
                elab.misure('angle_hipbone_backbone')=[misura, x1, y1, x1, y1];
                
                %assegnazione hip_right_left, i numeri nei parametri sono
                %riferiti alla numerazione assegnata dalla kinect,
                %esplicitata nella classe Skeleton
                x1=skel.getJointMap(13).GetX();
                y1=skel.getJointMap(13).GetY();
                x2=skel.getJointMap(17).GetX();
                y2=skel.getJointMap(17).GetY();
                misura=abs(y1-y2);
                elab.misure('hip_right_left')=[misura, x1, y1, x2, y2];
                
                
                %assegnazione knee_right_left, i numeri nei parametri sono
                %riferiti alla numerazione assegnata dalla kinect,
                %esplicitata nella classe Skeleton
                x1=skel.getJointMap(14).GetX();
                y1=skel.getJointMap(14).GetY();
                x2=skel.getJointMap(18).GetX();
                y2=skel.getJointMap(18).GetY();
                misura=abs(y1-y2);
                elab.misure('knee_right_left')=[misura, x1, y1, x2, y2];
                
            end
        end
        
        
        %% funzioni di elaborazione
        function errori=CalcoloErrori(elab, paramUtenti) %?? a che serve restituire la variabile 'errori' ?
            %          angle_backbone_shoulders;
            %          angle_backbone;
            %          angle_hipbone_backbone;
            %          hip_right_left;
            %          knee_right_left;
            
            value=elab.misure('angle_backbone_shoulders');
            value(1)=paramUtenti.Get_angle_backbone_shoulders()-elab.Get_angle_backbone_shoulders();
            elab.errori('err_angle_backbone_shoulders')=value;
            
            
            value=elab.misure('angle_backbone');
            value(1)=paramUtenti.Get_angle_backbone()-elab.Get_angle_backbone();
            elab.errori('err_angle_backbone')=value;
            
            value=elab.misure('angle_hipbone_backbone');
            value(1)=paramUtenti.Get_angle_hipbone_backbone()-elab.Get_angle_hipbone_backbone();
            elab.errori('err_angle_hipbone_backbone')=value;
            
            value=elab.misure('hip_right_left');
            value(1)=paramUtenti.Get_hip_right_left()-elab.Get_hip_right_left();
            elab.errori('err_hip_right_left')=value;
            
            value=elab.misure('knee_right_left');
            value(1)=paramUtenti.Get_knee_right_left()-elab.Get_knee_right_left();
            elab.errori('err_knee_right_left')=value;
            
            return;
        end
        
        % funzione di export della mappa errori e del KeySet
        function export=Export(elab)
            export=elab.errori;
            return;
        end
        
        %% funzioni GET per attributi
        % funzione Get per angle_backbone_shoulders
        function angle= Get_angle_backbone_shoulders(elab)
            angle=elab.misure('angle_backbone_shoulders');
            angle=angle(1);
            return;
        end
        
        % funzione Get per angle_backbone
        function  angle = Get_angle_backbone(elab)
            angle=elab.misure('angle_backbone');
            angle=angle(1);
            return;
        end
        
        % funzione Get per angle_hipbone_backbone
        function angle = Get_angle_hipbone_backbone(elab)
            angle=elab.misure('angle_hipbone_backbone');
            angle=angle(1);
            return;
        end
        
        % funzione Get per hip_right_left
        function angle = Get_hip_right_left(elab)
            angle=elab.misure('hip_right_left');
            angle=angle(1);
            return;
        end
        
        % funzione Get per knee_right_left
        function angle = Get_knee_right_left(elab)
            angle=elab.misure('knee_right_left');
            angle=angle(1);
            return;
        end
    end
    
end

