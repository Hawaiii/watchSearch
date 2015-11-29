function H = computeH(eparams, circleCenter, circleRadius)
% Computes H that projects a circle centered at circleCenter and has radius
% circleRadius to given ellipse
% Input:
%  eparams: 1x5 vector
%  circleCenter: 1x2 vector specifying (x,y) of circle center
%  circleRadius: number that specifies radius of circle
% Output:
%  H: 3x3 homography matrix

% Convert eparams to 3x3 matrix E
% A = eparams(1)^2*(sin(eparams(5))^2) + eparams(2)^2*(cos(eparams(5))^2);
% B2 = (eparams(2)^2-eparams(1)^2)*sin(eparams(5))*cos(eparams(5));
% C = eparams(1)^2*(cos(eparams(5))^2) + eparams(2)^2*(sin(eparams(5))^2);
% D2 = - A*eparams(3)-B2*eparams(4);
% E2 = -B2*eparams(3) - C*eparams(4);
% F = A*eparams(3)^2+2*B2*eparams(3)*eparams(4)+C*eparams(4)^2-eparams(1)^2*eparams(2)^2;
a = eparams(3);
b = eparams(4);
cx = eparams(1);
cy = eparams(2);
theta = eparams(5);
A = a^2*(sin(theta))^2+b^2*(cos(theta))^2;
B2 = (b^2-a^2)*sin(theta)*cos(theta);
C = a^2*(cos(theta))^2+b^2*(sin(theta))^2;
D2 = -A*cx - B2*cy;
E2 = -B2*cx - C*cy;
F = A*cx^2 + 2*B2*cx*cy + C*cy^2 - a^2*b^2;
E = [A B2 D2; B2 C E2; D2 E2 F];

% eigenvalue decompose E
[V_, U] = eig(E);
V = V_; V(:,1) = V_(:,3); V(:,3) = V_(:,1);

% compute H
H = V*[1/sqrt(U(3,3)) 0 0; 0 1/sqrt(U(2,2)) 0; 0 0 1/sqrt(-U(1,1))];

% scale H from unit circle to circle=(circleCenter, circleRadius)
R = [1/circleRadius 0 -circleCenter(1)/circleRadius;...
    0 1/circleRadius -circleCenter(2)/circleRadius;...
    0 0 1];
H = H*R;

% scale H for numerical stability
H = H/H(3,3);
end