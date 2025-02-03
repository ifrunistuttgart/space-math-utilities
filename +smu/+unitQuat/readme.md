# unitQuat - Namespace for Operations on Unit Quaternions
This namespace provides functions for operations on unit quaternions.
A unit quaternion is a quaternion with a magnitude of 1 and is often used to represent rotations in 3D space.
While some of the provided functionality might be valid for quaternions with arbitrary magnitudes, the functions are designed to work with unit quaternions.

## Multiplication
The product of two (unit) quaternions can be rewritten as matrix-vector products:\
$$q_1 \otimes q_2 = L(q_1) q_2 = R(q_2) q_1$$\
This namespace provides the functions `qpml.m` and `qpmr.m` for computing the so-called left and right quaternion product matrices $L$ and $R$.

## Structure
### rot - Namespace for Rotation Quaternions
A rotation depends on an axis. This axis must be expressed in some coordinate system.
The associated unit quaternion, whose values depend on this axis, performs the desired rotation only in the correct coordinate system.
Within this toolbox, these are called _rotation quaternions_.
This namespace includes a nested namespace `rot` that provides functions for rotation quaternions.
The comments in the code explanation use the notation `rot_quat_BA_C` to denote the rotation quaternion that describes the rotation from coordinate system A to coordinate system B.
The subscript C denotes the coordinate system in which the rotation axis is expressed.
When the composition or separation of two rotation quaternions is calculated, the resulting rotation quaternion's axis is expressed in the same frame as those of the two inputs.  

### att - Namespace for Attitude Quaternions
If a unit quaternion describes the attitude of one coordinate system B relative to another system A, the expression of the rotation axis is identical for both of these systems.
It is therefore common practice to use this expression of the axis and omit the subscript indicating the coordinate system of the axis expression.
Within this toolbox, these quaternions are called _attitude quaternions_.
The comments in the code explanation use the notation `att_quat_BA` to denote the attitude quaternion that describes the attitude of coordinate system B relative to coordinate system A.
Calculating the composition or separation of two attitude quaternions is different from the rotation quaternions since the rotation axes of the two inputs and the output need to be expressed in different coordinate systems.
One could use the `composition` and `separation` functions from the `rot` namespace with switched and inverted arguments to achieve the desired result.
However, this toolbox provides a separate namespace `att` that already implements those functions specifically for attitude quaternions.
Therefore, the user can pick the appropriate namespace depending on the context and does not need to remember when to invert or switch inputs.
