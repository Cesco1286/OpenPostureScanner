%% VERSION 1: Valerio Dodet - DATE: 20/06/2016
% 
% 

classdef Skeleton 
    %SKELETON oggetto scheletro a partire da una matrice 20x2 e l'ID dello
    %
    %
    
    
    properties(Constant = true)
        JointNameMap=char('Hip_Center','Spine','Shoulder_Center','Head','Shoulder_Left','Elbow_Left','Wrist_Left','Hand_Left','Shoulder_Right','Elbow_Right','Wrist_Right','Hand_Right','Hip_Left','Knee_Left','Ankle_Left','Foot_Left','Hip_Right','Knee_Right','Ankle_Right','Foot_Right');
        
        %         %Joint restituiti dalla kinect
        %         Hip_Center = 1;
        %         Spine = 2;
        %         Shoulder_Center = 3;
        %         Head = 4;
        %         Shoulder_Left = 5;
        %         Elbow_Left = 6;
        %         Wrist_Left = 7;
        %         Hand_Left = 8;
        %         Shoulder_Right = 9;
        %         Elbow_Right = 10;
        %         Wrist_Right = 11;
        %         Hand_Right = 12;
        %         Hip_Left = 13;
        %         Knee_Left = 14;
        %         Ankle_Left = 15;
        %         Foot_Left = 16;
        %         Hip_Right = 17;
        %         Knee_Right = 18;
        %         Ankle_Right = 19;
        %         Foot_Right = 20;
        
        BoneNameMap = char('HipBone','schienaBone','HeadBone','LeftShoulderBone','LeftBraccioBone','LeftAvambraccioBone','LeftHandBone','RightShoulderBone','RightBraccioBone','RightAvambraccioBone','RightHandBone','RightHipBone','RightCosciaBone','RightStincoBone','RightFootBone','LeftHipBone','LeftCosciaBone','LeftStincoBone','LeftFootBone');
        
        SkeletonConnectionsMap = [[1 2],[2 3],[3 4],[3 5],[5 6],[6 7],[7 8],[3 9],[9 10],[10 11],[11 12],[1 17],[17 18],[18 19],[19 20],[1 13],[13 14],[14 15],[15 16]];
    end
    properties
        SkeletonJointMap=Joint();
        SkeletonBoneMap=Bone();
        %         SkeletonBoneMap = [
        %             HipBone;
        %             schienaBone;
        %             HeadBone;
        %             LeftShoulderBone;
        %             LeftBraccioBone;
        %             LeftAvambraccioBone;
        %             LeftHandBone;
        %             RightShoulderBone;
        %             RightBraccioBone;
        %             RightAvambraccioBone;
        %             RightHandBone;
        %             RightHipBone;
        %             RightCosciaBone;
        %             RightStincoBone;
        %             RightFootBone;
        %             LeftHipBone;
        %             LeftCosciaBone;
        %             LeftStincoBone;
        %             LeftFootBone
        %             ];
        
    end
    
    methods
        
        %costruttore scheletro, istanzia anche i relativi oggetti Joint e Bone
        %Input: JointImagesIndices matrice 20x2 delle posizioni dei joint
        
        function skel = Skeleton(JointImagesIndices)
            if (nargin>0)
                
               % JointImagesIndices=JointImagesIndices(:,:,TrackID);
                for i=1:20,
                    skel.SkeletonJointMap(i)=Joint(JointImagesIndices(i,1),JointImagesIndices(i,2),skel.JointNameMap(i,:));
                end
                
                % inizializzazione ossa scheletro con "Bone(jointA, jointB, name)"
                for i=1:19,
                    skel.SkeletonBoneMap(i)=Bone(skel.SkeletonJointMap(skel.SkeletonConnectionsMap(1,i)),skel.SkeletonJointMap(skel.SkeletonConnectionsMap(1,i+1)),skel.BoneNameMap(i,:));
                end
            end
            
            return;
        end
        
%         %costruttore vuoto per scheletro
%         function skel = Skeleton()
%             skel;
%         end
        
        
        %la funzione ritorna un oggetto Bone
        %Input: bone può essere il numero riferito alla posizione in
        %       SkeletonConnectionMap ma anche il nome dell'osso
        function [bone] = getBone(skel, bone)
            if (bone>0 && bone <20),
                bone=skel.SkeletonConnectionMap(bone);
            else
                bone=skel.SkeletonConnectionMap(bone.Name==bone);
            end
            return;
        end
        
        
    end
    
end

