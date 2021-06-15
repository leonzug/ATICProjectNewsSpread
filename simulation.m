addpath('Utilities');

N = 15;
timesteps = 1000;
%X = ...;X
traits = {'similarity', 'influenceable'};
distr = {{'uniform',[0,1]}, {'uniform',[0,1]}}


[A,people,FakeSources, RealSources,x0] = generate_society (N,traits, distr);

[X] = spread_news(timesteps, A, x0);


visualize_function(A,X',timesteps,1);