addpath('Utilities');
close all;

nExperiments = 100;
% newsRange: how many people does a news reach. 
% locality: is the news local or homogeneously spread.
% index 1: Fake News; index 2: Real News.
C = [0.2; 0.3; 0.4; 0.5; 0.6];
nRoot = [2; 4; 8];
locality = [true, true];

totExp = size(C,1) * size(nRoot,1) * size(locality,1);

Result.C = zeros(totExp,1);
Result.nRoot = zeros(totExp,1);
Result.locality = zeros(totExp,2);
Result.avg = zeros(totExp,1);
Result.std = zeros(totExp,1);
Result.R2 = zeros(totExp,1);

line = 1;
for c = 1:size(C,1)
    for r=1:size(nRoot,1)
        for l=1:size(locality,1)
            AvgTot = 0;
            StdTot = 0;
            R2Tot = 0;
            valid = 0;
            for nexp = 1:nExperiments                
                [Avg, Std, R2, check] = simulate_sequence(C(c), nRoot(r), locality(l,:), nexp);
                if check
                    valid = valid + 1;
                    AvgTot = AvgTot + Avg;
                    StdTot = StdTot + Std;
                    R2Tot = R2Tot + R2;
                end
            end
            
            % store results
            Result.C(line,1) = C(c);
            Result.nRoot(line,1) = nRoot(r);
            Result.locality(line,:) = locality(l,:);
           
            Result.avg(line,1) = AvgTot/valid;
            Result.std(line,1) = StdTot/valid;
            Result.R2(line,1) = R2Tot/valid;
            line = line + 1;
        end
    end
end
                                 
% Table

T = table(Result.C, Result.nRoot, Result.locality, Result.avg, Result.std, Result.R2, ...
    'VariableNames',{'C', 'nRoot', 'locality', 'mean', 'std', 'R2'});

%% Plot

figure(1)
plot3(T.C, T.nRoot, T.mean,'o');
grid on
hold on
plot3(F.C, F.nRoot, F.mean,'o');
title('Polarization Experiment: mean');
xlabel('C');
ylabel('nRoot');
zlabel('Opinion Mean');

figure(2)
plot3(T.C, T.nRoot, T.std,'o');
grid on
hold on
plot3(F.C, F.nRoot, F.std,'o');
title('Polarization Experiment: standard deviation');
xlabel('C');
ylabel('nRoot');
zlabel('Opinion Standard Deviation');
%legend('local news', 'spread news')

figure(3)
plot3(T.C, T.nRoot, T.R2,'o');
grid on
hold on
plot3(F.C, F.nRoot, F.R2,'o');
title('Polarization Experiment: R2');
xlabel('C');
ylabel('nRoot');
zlabel('Opinion R2');
legend('local news', 'spread news')

figure(4)
plot(T.std,T.R2,'.')
title('Standard deviation vs R2')
xlabel('Standard deviation')
ylabel('R2')

