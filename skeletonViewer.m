function [ lineSke ] = skeletonViewer(skeleton, image, nSkeleton, skID)
% viewer per gli scheletri della kinect sovrascritti ad un'immagine
%   skeleton=metaData_Depth.JointImageIndices;
%   image=immagine su cui stampare lo scheletro;
%   nSkeleton = numero degli scheletri;
%   skID= numero dello scheletro tra i 6 disponibili sulla kinect;
% return: array di line che compongono lo scheletro, non sono riuscito a
% fare di meglio, mi stanno chiudendo dentro

% nomi dei Joint nella matrice skeleton
Hip_Center = 1;
Spine = 2;
Shoulder_Center = 3;
Head = 4;
Shoulder_Left = 5;
Elbow_Left = 6;
Wrist_Left = 7;
Hand_Left = 8;
Shoulder_Right = 9;
Elbow_Right = 10;
Wrist_Right = 11;
Hand_Right = 12;
Hip_Left = 13;
Knee_Left = 14;
Ankle_Left = 15;
Foot_Left = 16;
Hip_Right = 17;
Knee_Right = 18;
Ankle_Right = 19;
Foot_Right = 20;

%dichiarazione array di ritorno dello scheletro
%lineSke===???

SkeletonConnectionMap = [[1 2]; % Spine
    [2 3];
    [3 4];
    [3 5]; %Left Hand
    [5 6];
    [6 7];
    [7 8];
    [3 9]; %Right Hand
    [9 10];
    [10 11];
    [11 12];
    [1 17]; % Right Leg
    [17 18];
    [18 19];
    [19 20];
    [1 13]; % Left Leg
    [13 14];
    [14 15];
    [15 16]];

% ciclo di disegno dello scheletro sull'immagine
imshow(image(:,:,1:3),[]);
hold on;
for i = 1:19
    
    if nSkeleton > 0
        X1 = [skeleton(SkeletonConnectionMap(i,1),1,skID) skeleton(SkeletonConnectionMap(i,2),1,skID)];
        Y1 = [skeleton(SkeletonConnectionMap(i,1),2,skID) skeleton(SkeletonConnectionMap(i,2),2,skID)];
        lineSke(i)=line(X1,Y1, 'LineWidth', 1, 'LineStyle', '-', 'Marker', '+', 'Color', 'r');
    end
    if nSkeleton > 1
        X2 = [skeleton(SkeletonConnectionMap(i,1),1,2) skeleton(SkeletonConnectionMap(i,2),1,2)];
        Y2 = [skeleton(SkeletonConnectionMap(i,1),2,2) skeleton(SkeletonConnectionMap(i,2),2,2)];
        line(X2,Y2, 'LineWidth', 1, 'LineStyle', '-', 'Marker', '+', 'Color', 'g');
    end
    
end
hold off;

end

