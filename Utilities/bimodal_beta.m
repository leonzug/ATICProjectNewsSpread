function [x] = bimodal_beta(N, polarity_level)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
x = NaN*ones(N,1);
if polarity_level <= 1 && polarity_level >= 0
    polarity_level = 0.5*(polarity_level+1);
    choice = randi(2,N,1);
    for i = 1:N
        if choice(i) == 1
            x(i) = sampleFromBeta(1, polarity_level);
        elseif choice(i) == 2
            x(i) = sampleFromBeta(1, 1-polarity_level);
        end
    end
else
    disp("Error: polarity levels are between 0 and 1");
end
end

