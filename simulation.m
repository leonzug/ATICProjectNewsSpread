addpath('Utilities');

N = 1000;
timesteps = 400;

traits = {'similarity', 'influenceable'};
distr = {{'uniform',[0,1]}, {'uniform',[0,1]}}
nRealNews = 3;
nFakeNews = 3;
step_size = 10;

[A,people,FakeSources, RealSources,x0,nodenames] = generate_society (N,traits, distr, nRealNews, nFakeNews);

[X] = spread_news(timesteps, A, x0);

eval = metrics (X,'hyst', 20,2);
eval = metrics (X,'mean', 10,2)

visualize_function(A,X',nodenames,timesteps,1,step_size);