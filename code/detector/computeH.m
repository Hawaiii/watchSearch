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
% R = circleRadius*[1 0 circleCenter(1);...
%     0 1 circleCenter(2);...
%     0 0 1];
R = [1/circleRadius 0 -circleCenter(1)/circleRadius;...
    0 1/circleRadius -circleCenter(2)/circleRadius;...
    0 0 1];
H = H*R;

% scale H for numerical stability
% H = H/H(3,3);
end