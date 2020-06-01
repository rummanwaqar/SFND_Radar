% speed of light
c = 3 * 10e8;
% range resolution
dRes = 1;
% max range
rMax = 300;

% Find the Bsweep of chirp for 1 m resolution
Bsweep = c / (2*dRes);

% Calculate the chirp time based on the Radar's Max Range
tChirp = 5.5 * 2 * rMax / c;


% define the frequency shifts (MHz)
beatFreqs = {0, 1.1, 13, 24};


% Display the calculated range
for i = 1 : length(beatFreqs)
    range = c * tChirp * beatFreqs{i} * 10e6 / (2 * Bsweep);
    disp(range);
end