addpath('Utilities');

N = 6;
timesteps = 100;

traits = {'similarity', 'influenceable'};
distr = {{'uniform',[0,1]}, {'uniform',[0,1]}};
nRealNews = 1;
nFakeNews = 2;
step_size = 10;
tol = 0.0001;

[A,people,FakeSources, RealSources,x0,nodenames] = generate_society (N,traits, distr, nRealNews, nFakeNews);
[X] = spread_news(timesteps, A, x0);
[isSteadyState,WhenSteadyState] = is_steady_state(X,tol);
%eval = metrics (X,'hyst', 20,2);
eval2 = metrics (X,'mean', 10,2);

degree = 2;
perturbation = 'censorship';

[A_perturbed] = perturb_network(A,FakeSources,RealSources,perturbation,degree)
FakeSources
RealSources
A
A_perturbed


%visualize_function(A,X',nodenames,timesteps,1,step_size);

%[idx, C] = k_means(X);
