function [Avg, Std, R2, check] = simulate_sequence(C, nRoot, locality, nexp)

% initialize
Avg = 0;
Std = 0;
R2 = 0;
check = true;


N = 100;
timesteps = 600;

traits = {'similarity', 'influenceable','critical thinker'};
distr = {{'polar',0.5}, {'fixed',0.5}, {'fixed',0.5}};
nRealNews = 3;
nFakeNews = 3;

tol = 0.0001;
newsRange = round([0.1, 0.1]*N);


[A,~,~, ~,x0,~] = generate_society_pol (N,traits, distr, nRealNews, nFakeNews, newsRange, locality, C, nRoot);
[X] = spread_news(timesteps, A, x0);
[isSteadyState,~] = is_steady_state(X,tol);


if strcmp(isSteadyState,'False')
    fprintf('Experiment %i with C= %d, nroot= %d did not reach steady state \n', nexp, C, nRoot)
    check = false;
    return
else
Xf = X(1:end-nRealNews-nFakeNews, end);

Avg = mean(Xf);
Std = std(Xf);
R2 = norm(Xf)^2/N;


end

end