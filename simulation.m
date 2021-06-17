addpath('Utilities');

N = 1000;
timesteps = 600;
nExperiments = 25;
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

i = 0;
X_average = 0;
while i<nExperiments
    [A,people,FakeSources, RealSources,x0,nodenames] = generate_society (N,traits, distr, nRealNews, nFakeNews, newsRange, locality, C, nRoot);
    [X] = spread_news(timesteps, A, x0);
    [isSteadyState,WhenSteadyState] = is_steady_state(X,tol);
    if isSteadyState
        i = i + 1;
        instance_average = metrics(X, 'avg', 10, 2);
        X_average = X_average + instance_average(end);
    else
        disp("Instance " + i + "did not reach steady state");
    end
end
X_average = X_average/nExperiments


%degree = 2;
%perturbation = 'censorship';


X_average = X_average(end);
%[average_indegree] = visualize_function(A,X',nodenames,timesteps,1,step_size);
%G = digraph(A,nodenames);
%average_indegree = mean(indegree(G));

%[idx, C] = k_means(X);
