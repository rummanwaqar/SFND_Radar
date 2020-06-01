% Doppler Velocity Calculation
c = 3*10^8;         %speed of light
frequency = 77e9;   %frequency in Hz

% Calculate the wavelength
lambda = frequency / c;

% Define the doppler shifts in Hz using the information from above 
dopplerShifts = [3, 4.5, 11, -3] * 10e3;

% Calculate the velocity of the targets  fd = 2*vr/lambda
velocity = dopplerShifts * lambda / 2;
disp(velocity);