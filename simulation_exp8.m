addpath('Utilities');
clear all;

N = 100;
timesteps = 3000;
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
infl_polarity = 0:0.01:1;
averages = zeros(size(infl_polarity,2),1);
stds = zeros(size(infl_polarity,2),1);
t_steady = zeros(size(infl_polarity,2),1);
dt_avgs = zeros(size(infl_polarity,2),50);
i_avg = zeros(size(infl_polarity,2),1);
for k=1:size(infl_polarity,2)
    i = 0;
    X_average = 0;
    std_average = 0;
    steadystate = 0;
    connectivity_avg = 0;
    dt_avg = zeros(1,50);
    distr = {{'uniform',[0,1]},{'beta',infl_polarity(k)}, {'uniform',[0,1]}};
    while i<nExperiments
        [A,people,FakeSources, RealSources,x0,nodenames] = generate_society (N,traits, distr, nRealNews, nFakeNews, newsRange, locality, C, nRoot);
        [X] = spread_news(timesteps, A, x0);
        [isSteadyState,WhenSteadyState] = is_steady_state(X,tol);
        [average_indegree] = visualize_function(A,X',nodenames,timesteps,k+20,step_size,false,false);
        if isSteadyState
            i = i + 1;
            instance_average = metrics(X, 'avg', 10, 2,RealSources,FakeSources);
            instance_std = metrics(X, 'std', 10, 2,RealSources,FakeSources);
            instance_avg_dt = metrics(X, 'avg_dt', 50, 2,RealSources,FakeSources)';
            X_average = X_average + instance_average(end);
            std_average = std_average + instance_std(end);
            steadystate = steadystate + WhenSteadyState(1);
            dt_avg = dt_avg + instance_avg_dt;
            connectivity_avg = connectivity_avg + average_indegree;
        else
            disp("Instance " + i + "did not reach steady state");
        end
    end
    stds(k) = std_average/nExperiments;
    averages(k) = X_average/nExperiments;
    t_steady(k) = steadystate/nExperiments;
    i_avg(k) = connectivity_avg/nExperiments;
    dt_avgs(k,:) = dt_avg./nExperiments;

end
figure(1);
plot(infl_polarity,averages);
title("Influenceability level vs Averages")
figure(2);
plot(infl_polarity,stds);
title("Influenceability Level vs Stds")
figure(3);
plot(infl_polarity,t_steady);
title("Influenceability Level vs Time to Steady State")
figure(4);
plot_names = [];
for k=1:size(infl_polarity,2)
    hold on
    semilogy(1:1:50,dt_avgs(k,:));
    plot_names = [plot_names; " " + round(k/size(infl_polarity,2),1)];
end
lgd = legend(plot_names);
title(lgd,"Influenceability")
hold off

%title("Influenceability Level vs Average Derivative")
%degree = 2;
%perturbation = 'censorship';


X_average = X_average(end);
[average_indegree] = visualize_function(A,X',nodenames,timesteps,5,step_size,true,true);

%G = digraph(A,nodenames);
%average_indegree = mean(indegree(G));

%[idx, C] = k_means(X);