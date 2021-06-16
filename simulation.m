addpath('Utilities');

N = 15;
timesteps = 50;

traits = {'similarity', 'influenceable','critical thinker'};
distr = {{'uniform',[0,1]}, {'uniform',[0,1]}, {'uniform',[0,1]}};
nRealNews = 1;
nFakeNews = 1;
step_size = 10;

% newsRange: how many people does a news reach. 
% locality: is the news local or homogeneously spread.
% index 1: Fake News; index 2: Real News.
newsRange = round([0.1, 0.1]*N);
locality = [true, true];

[A,people,FakeSources, RealSources,x0,nodenames] = generate_society (N,traits, distr, nRealNews, nFakeNews, newsRange, locality);

[X] = spread_news(timesteps, A, x0);

eval = metrics (X,'hyst', 20,2);
eval2 = metrics (X,'mean', 10,2);


visualize_function(A,X',nodenames,timesteps,1,step_size);

[idx, C] = k_means(X);
