addpath('Utilities');
clear all;

N = 100;
timesteps = 2000;
nExperiments = 100;
traits = {'similarity', 'influenceable','critical thinker'};
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
similarity_level = 0:1:60;
averages = zeros(size(similarity_level,2),1);
stds = zeros(size(similarity_level,2),1);
t_steady = zeros(size(similarity_level,2),1);
i_avg = zeros(size(similarity_level,2),1);
for k=1:size(similarity_level,2)
    i = 0;
    X_average = 0;
    std_average = 0;
    steadystate = 0;
    connectivity_avg = 0;
    distr = {{'uniform',[-similarity_level(k),similarity_level(k)]}, {'uniform',[0,1]}, {'uniform',[0,1]}};
    while i<nExperiments
        [A,people,FakeSources, RealSources,x0,nodenames] = generate_society (N,traits, distr, nRealNews, nFakeNews, newsRange, locality, C, nRoot);
        [X] = spread_news(timesteps, A, x0);
        [isSteadyState,WhenSteadyState] = is_steady_state(X,tol);
        [average_indegree] = visualize_function(A,X',nodenames,timesteps,k+20,step_size,false,false);
        if isSteadyState
            i = i + 1;
            instance_average = metrics(X, 'avg', 10, 2,RealSources,FakeSources);
            instance_std = metrics(X, 'std', 10, 2,RealSources,FakeSources);
            X_average = X_average + instance_average(end);
            std_average = std_average + instance_std(end);
            steadystate = steadystate + WhenSteadyState;
            connectivity_avg = connectivity_avg + average_indegree;
        else
            disp("Instance " + i + "did not reach steady state");
        end
    end
    stds(k) = std_average/nExperiments;
    averages(k) = X_average/nExperiments;
    t_steady(k) = steadystate/nExperiments;
    i_avg(k) = connectivity_avg/nExperiments;

end
figure;
plot(similarity_level,averages);
figure;
plot(similarity_level,stds);
figure;
plot(similarity_level,t_steady);
%degree = 2;
%perturbation = 'censorship';


X_average = X_average(end);
%[average_indegree] = visualize_function(A,X',nodenames,timesteps,1,step_size);
%G = digraph(A,nodenames);
%average_indegree = mean(indegree(G));

%[idx, C] = k_means(X);