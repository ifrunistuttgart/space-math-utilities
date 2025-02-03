function rot_quat_BA = fromRotm(rotm_BA_D)
%% Rotation Quaternion from Rotation Matrix
%   rot_quat_BA = fromRotm(rotm_BA_D)
%
%   This function calculates the rotation quaternion from a rotation matrix.
%
%  Inputs:
%   - rotm_BA_D: Rotation matrix from frame B to frame A with a rotation
%     axis expressed in frame D
%
%  Outputs:
%   - rot_quat_BA: Rotation quaternion from frame B to frame A with a rotation
%     axis expressed in frame D
%
%% References
% [1] D. H. Eberly, Game Physics, 0 ed. CRC Press, 2010. doi: 10.1201/b18213.

arguments
    rotm_BA_D (3,3) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeSpecialOrthogonalMatrix}
end

% Calculate the quaternion from the rotation matrix
% Algorithm from [1, p. 537, Figure 10.6]
% attempts to avoid precision loss by using a component with a
% large magnitude as the divisor

R = rotm_BA_D;
v = zeros(3,1);

tr = trace(R);
if tr < 0

    i = 1;
    j = 2;
    k = 3;

    if R(2,2) > R(1,1)
        i = 2;
        j = 3;
        k = 1;
    end

    if R(3,3) > R(i,i)
        i = 3;
        j = 1;
        k = 2;
    end

    r = sqrt(R(i,i) - R(j,j) - R(k,k) + 1);
    s = 0.5 / r;

    v(i) = 0.5 * r;
    v(j) = (R(i,j) + R(j,i)) * s;
    v(k) = (R(k,i) + R(i,k)) * s;
    w = (R(k,j) - R(j,k)) * s;
    
else

    r = sqrt(1 + tr);
    s = 0.5 / r;

    v(1) = (R(3,2) - R(2,3)) * s;
    v(2) = (R(1,3) - R(3,1)) * s;
    v(3) = (R(2,1) - R(1,2)) * s;
    w = 0.5 * r;
end

rot_quat_BA = [w; v];
    

end