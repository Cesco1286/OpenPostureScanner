% %% VERSION 1: Valerio Dodet - DATE: 12/07/2016
%
%


classdef ParametriUtente < handle
    %ParametriUtente permette all'utente di impostare dei parametri di
    %riferimento per la misura della postura.
    % Attualmente sono registrati i seguenti punti di riferimento
    %   angolo schiena spalle
    %   angolo schiena
    %   angolo hipbone e schiena
    %   differenza tra l'altezza dei Joint dei fianchi
    %   differenza tra l'altezza dei Joint delle ginocchia
    
    properties
        %   angolo schiena spalle, shoulders è da ricavare tra i joint
        %   Shoulder_left e shoulder_right
        angle_backbone_shoulders;
        
        %   angolo schiena
        angle_backbone;
        
        %   angolo hipbone e schiena
        angle_hipbone_backbone;
        
        %   differenza tra l'altezza dei Joint dei fianchi
        hip_right_left;
        
        %   differenza tra l'altezza dei Joint delle ginocchia
        knee_right_left;
        
    end
    
    methods
        
        % costruttore dell'istanza parametri utente
        % Input: vettore di 5 valori numerici inseriti dall'utente
        % Output: puntatore all'oggetto con parametri inizializzati
        function params = ParametriUtente(parametri)
            if(nargin>0 && size(parametri,2)>0),
                params.angle_backbone_shoulders=parametri(1);
                params.angle_backbone=parametri(2);
                params.angle_hipbone_backbone=parametri(3);
                params.hip_right_left=parametri(4);
                params.knee_right_left=parametri(5);
            end
            return;
        end
        
        
        % funzione di export in blocco dei valori dei parametri
        function parametri=Export(params)
            parametri(1)=params.angle_backbone_shoulders;
            parametri(2)=params.angle_backbone;
            parametri(3)=params.angle_hipbone_backbone;
            parametri(4)=params.hip_right_left;
            parametri(5)=params.knee_right_left;
            return;
        end
        
        %% funzioni GET per attributi
        % funzione Get per angle_backbone_shoulders
        function angle= Get_angle_backbone_shoulders(params)
            angle=params.angle_backbone_shoulders;
            return;
        end
        
        % funzione Get per angle_backbone
        function  angle = Get_angle_backbone(params)
            angle=params.angle_backbone;
            return;
        end
        
        % funzione Get per angle_hipbone_backbone
        function angle = Get_angle_hipbone_backbone(params)
            angle=params.angle_hipbone_backbone;
            return;
        end
        
        % funzione Get per hip_right_left
        function angle = Get_hip_right_left(params)
            angle=params.hip_right_left;
            return;
        end
        
        % funzione Get per knee_right_left
        function angle = Get_knee_right_left(params)
            angle=params.knee_right_left;
            return;
        end
        
        %% funzioni SET per attributi
        % funzione Set per angle_backbone_shoulders
        function params = Set_angle_backbone_shoulders(params,angle)
            params.angle_backbone_shoulders=angle;
            return;
        end
        
        % funzione Set per angle_backbone
        function params = Set_angle_backbone(params,angle)
            params.angle_backbone=angle;
            return;
        end
        
        % funzione Set per angle_hipbone_backbone
        function params = Set_angle_hipbone_backbone(params, angle)
            params.angle_hipbone_backbone=angle;
            return;
        end
        
        % funzione Set per hip_right_left
        function params = Set_hip_right_left(params, differenza)
            params.hip_right_left=differenza;
            return;
        end
        
        % funzione Set per knee_right_left
        function params = Set_knee_right_left(params, differeza)
            params.knee_right_left=differeza;
            return;
        end
        
        
    end
    
end

