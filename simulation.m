addpath('Utilities');

N = 30;
timesteps = 1000;
%X = ...;X
traits = {'similarity', 'influenceable'};
distr = {{'uniform',[0,1]}, {'uniform',[0,1]}}
nRealNews = 0;
nFakeNews = 3;
step_size = 10;

[A,people,FakeSources, RealSources,x0] = generate_society (N,traits, distr, nRealNews, nFakeNews);

[X] = spread_news(timesteps, A, x0);


visualize_function(A,X',timesteps,1,step_size);