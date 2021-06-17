addpath('Utilities');
clear all;

N = 100;
timesteps = 600;
nExperiments = 100;
traits = {'similarity', 'influenceable','critical thinker'};
distr = {{'fixed',0.5}, {'fixed',0.5}, {'fixed',0.5}};
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
X_std = 0;
t_steady = 0;
i_avg = 0;
while i<nExperiments
    [A,people,FakeSources, RealSources,x0,nodenames] = generate_society (N,traits, distr, nRealNews, nFakeNews, newsRange, locality, C, nRoot);
    [X] = spread_news(timesteps, A, x0);
    [isSteadyState,WhenSteadyState] = is_steady_state(X,tol);
    [average_indegree] = visualize_function(A,X',nodenames,timesteps,1,step_size,true,false);
    if isSteadyState
        i = i + 1;
        instance_average = metrics(X, 'avg', 10, 2,RealSources,FakeSources);
        instance_std = metrics(X, 'std', 10, 2,RealSources,FakeSources);
        X_average = X_average + instance_average(end);
        X_std = X_std + instance_std(end);
        t_steady = t_steady + WhenSteadyState;
        i_avg = i_avg + average_indegree;
    else
        disp("Instance " + i + "did not reach steady state");
    end
end
X_average = X_average/nExperiments;
X_std = X_std/nExperiments;
t_steady = t_steady/nExperiments;
i_avg = i_avg/nExperiments;

%degree = 2;
%perturbation = 'censorship';


X_average = X_average(end);
%G = digraph(A,nodenames);
%average_indegree = mean(indegree(G));

%[idx, C] = k_means(X);
