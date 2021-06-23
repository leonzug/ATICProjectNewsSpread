addpath('Utilities');

N = 100;
timesteps = 600;
nExperiments = 100000;
traits = {'similarity', 'influenceable','critical thinker'};
distr = {{'uniform',[0,1]}, {'uniform',[0,1]}, {'uniform',[0,1]}};
nRealNews = 2;
nFakeNews = 2;

step_size = 100;
tol = 0.000001;

C = 0.2;
nRoot = 4;

% newsRange: how many people does a news reach. 
% locality: is the news local or homogeneously spread.
% index 1: Fake News; index 2: Real News.
newsRange = round([0.1, 0.1]*N);
locality = [true, true];

counter = 0;
percentage_counter = 0;
for i=1:nExperiments
    disp(percentage_counter + "%");
    percentage_counter = percentage_counter + 1/nExperiments*100;
    [A,people,FakeSources, RealSources,x0,nodenames] = generate_society (N,traits, distr, nRealNews, nFakeNews, newsRange, locality, C, nRoot);
    A = A(1:N,1:N);
    matrix = eye(size(A));
    for j=1:(N-1)
        matrix = matrix + A^j;
    end
    if sum(sum(matrix>0)) == N*N
        counter = counter + 1;
    end
end
counter
counter/nExperiments*100
