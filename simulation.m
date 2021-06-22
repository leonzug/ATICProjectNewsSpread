addpath('Utilities');

N = 50;
timesteps = 400;

traits = {'similarity', 'influenceable','critical thinker'};
distr = {{'polar',0.5}, {'fixed',0.2}, {'fixed',0.5}};
nRealNews = 4;
nFakeNews = 4;

step_size = 100;
tol = 0.000001;

C = 0.5;
nRoot = 2;

% newsRange: how many people does a news reach. 
% locality: is the news local or homogeneously spread.
% index 1: Fake News; index 2: Real News.
newsRange = round([0.1, 0.1]*N);
locality = [true, true];

[A,people,FakeSources, RealSources,x0,nodenames] = generate_society (N,traits, distr, nRealNews, nFakeNews, newsRange, locality, C, nRoot);

[X] = spread_news(timesteps, A, x0);
[isSteadyState,WhenSteadyState] = is_steady_state(X,tol);
eval = metrics (X,'hyst', 20,2);
eval2 = metrics (X,'mean', 10,2);

%degree = 2;
%perturbation = 'censorship';

X_average = metrics(X, 'avg', 10, 2)
X_average = X_average(end);
[average_indegree] = visualize_function(A,X',nodenames,timesteps,1,step_size);
%G = digraph(A,nodenames);
%average_indegree = mean(indegree(G));

%[idx, C] = k_means(X);
