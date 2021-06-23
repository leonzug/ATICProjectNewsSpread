addpath('Utilities');
close all;

N = 100;
timesteps = 400;
nExperiments = 1;
traits = {'similarity', 'influenceable','critical thinker'};
distr = {{'polar',0.5}, {'fixed',0.5}, {'fixed',0.5}};
nRealNews = 3;
nFakeNews = 3;

step_size = 100;
tol = 0.0001;

C = 0.2;
nRoot = 4;

% newsRange: how many people does a news reach. 
% locality: is the news local or homogeneously spread.
% index 1: Fake News; index 2: Real News.
newsRange = round([0.1, 0.1]*N);
locality = [false, false];


[A,people,FakeSources, RealSources,x0,nodenames] = generate_society_pol (N,traits, distr, nRealNews, nFakeNews, newsRange, locality, C, nRoot);
[X] = spread_news(timesteps, A, x0);
[isSteadyState,WhenSteadyState] = is_steady_state(X,tol);
[average_indegree] = visualize_function(A,X',nodenames,timesteps,1,step_size,true,true);

%eval = metrics(X(:,end),'hyst',20,2);
figure(2)
histogram(X(1:end-nRealNews-nFakeNews,end),20)
xlim([-1, 1]);
title('Opinion distribution')
%[idx, C] = k_means(X);



