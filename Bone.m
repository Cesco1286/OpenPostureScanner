%% VERSION 1: Valerio Dodet - DATE: 20/06/2016


classdef Bone
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Joint;
        AngleBone;
        Name;
    end
    
    methods
        %costruttore
        function bone = Bone(jointA, jointB, name)
            if (nargin>0)
                bone.Joint=[jointA, jointB];
                bone.AngleBone=bone.getAngle(bone.Joint);
                bone.Name=name;
            end
        end
        
        
        
        %% funzioni GET
        
        %ritorna l'oggetto Joint, scelto tra 1 e 2, ma anche per nome,
        %default il joint 1 nel caso il nome del joint 2 non corrispondesse
        function [jointA] = GetJoint(bone, joint)
            if(joint == 1 || joint == 2),
                jointA=bone.Joint(joint);
            else
                jointA = bone.Joint(1);
                jointB = bone.Joint(2);
                if jointB.sameName(joint)
                    jointA=jointB;
                end
                return;
            end
        end
        
        %funzione GET per AngleBone
        function angle = GetAngleBone(bone)
            angle=bone.AngleBone;
            return;
        end
        
        %GET name
        function name = GetName(bone)
            name=bone.Name;
            return
        end
        
        %% funzioni accessorie
        
        % sameName controlla se la stringa passata è simile al nome del
        % bone
        function ok = sameName(bone, stringa)
            sizeS=length(stringa);
            ok=0;
            if sizeS<=length(bone.Name),
                if bone.Name(1:sizeS)==stringa,
                    ok = 1;
                end
            end
            return;
        end
        
        %la funzione ritorna l'angolo in gradi che forma la linea tra i due joint passati
        %come parametri rispetto l'asse X
        %per eliminare l'ambiguità sull'angolo calcolato, si utilizzerà
        %come riferimento, il Joint con ordinata minore
        function [angleBone] = getAngle(bone, joint)
            
            if joint(1).GetY<joint(2).GetY,
                angleBone=rad2deg(atan((joint(1).GetY()-joint(2).GetY())/(joint(2).GetX()-joint(1).GetX())));
            else
                angleBone=rad2deg(atan((joint(2).GetY()-joint(1).GetY())/(joint(1).GetX()-joint(2).GetX())));
            end
            
        end
        
    end    %end methods
    
end
