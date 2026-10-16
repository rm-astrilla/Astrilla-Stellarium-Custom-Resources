% Convert Milky Way to J2000 Coordinate

clear all;
clc;

A = imread('mw.jpg'); % Image of the Milky Way (square format) stretched horizontally from left to right, flipped horizontally, both magellanic clouds are in top left
out_height = 3000;
out_width  = 6000;
in_height  = size(A, 1);
in_width   = size(A, 2);

x_range = linspace(-pi, pi, out_width);
y_range = linspace(-pi/2, pi/2, out_height);
[X_az, X_el] = meshgrid(x_range, y_range);
[x, y, z] = sph2cart(X_az(:), X_el(:), 1);

r1 = rotz_local(180 - 192.859508);
r2 = rotx_local(90 - 27.128336);
r3 = rotz_local(122.932 - 90);

tilt_correction = -0.0; 
r_corr = rotz_local(tilt_correction); % for Z axis

r = r1 * r2 * r3 * r_corr; 


m = [x, y, z] * r;
[U_az, U_el, ~] = cart2sph(m(:,1), m(:,2), -m(:,3));

col_in = (U_az + pi) * (in_width - 1) / (2 * pi) + 1;
row_in = (U_el + pi/2) * (in_height - 1) / pi + 1;
col_in = mod(col_in - 1, in_width) + 1; 

col_in = reshape(col_in, out_height, out_width);
row_in = reshape(row_in, out_height, out_width);

B = zeros(out_height, out_width, 3, 'like', A);
for channel = 1:size(A, 3)
    B(:, :, channel) = interp2(double(A(:, :, channel)), col_in, row_in, 'cubic', 0);
end

imwrite(uint8(B), 'milkyway_projected.png');
disp('saved as 'milkyway_projected.png'.'); % changing name to 'milkyway.png' in Stellarium/Texture folder

function R = rotx_local(deg), rad=deg*pi/180; c=cos(rad); s=sin(rad); R=[1 0 0; 0 c -s; 0 s c]; end
function R = rotz_local(deg), rad=deg*pi/180; c=cos(rad); s=sin(rad); R=[c -s 0; s c 0; 0 0 1]; end
