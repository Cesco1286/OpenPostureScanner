%% VERSION 1: Valerio Dodet - DATE: 20/06/2016


classdef Joint
    properties
        X=0;
        Y=0;
        Name;
    end
    
    methods
        function joint = Joint(X,Y,name)
            if (nargin>0)
                joint.X=X;
                joint.Y=Y;
                joint.Name=name;
            end
        end
        
        function [X]= GetX(joint )
            X=joint.X;
            return;
        end
        
        function [Y]= GetY(joint )
            Y=joint.Y;
            return;
        end
        
        function [Name]= GetName(joint )
            Name=joint.Name;
            return;
        end
        
    end
    
end
