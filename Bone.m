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
        function bone = Bone(jointA, jointB, name)
            if (nargin>0)
                bone.Joint=[jointA, jointB];
                bone.AngleBone=bone.getAngleBone(bone.Joint);
                bone.Name=name;
            end
        end
        
        %la funzione ritorna l'angolo in gradi che forma la linea tra i due joint passati
        %come parametri rispetto l'asse X
        %per eliminare l'ambiguità sull'angolo calcolato, si utilizzerà
        %come riferimento, il Joint con ordinata minore
        function [angleBone] = getAngleBone(bone,joint)
            
            if joint(1).GetY<joint(2).GetY,
                rif=joint(1);
                oth=joint(2);
            else
                rif=joint(2);
                oth=joint(1);
            end
            angleBone=rad2deg(atan((rif.GetY()-oth.GetY())/(oth.GetX()-rif.GetX())));
        end
        
        %ritorna l'oggetto Joint, scelto tra 1 e 2
        function [joint] = GetJoint(bone, num)
            joint=bone.Joint(num);
            return;
        end
    end
    
end

