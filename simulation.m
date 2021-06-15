addpath('Utilities');

N = 100;
timesteps = 100;
%X = ...;X
traits = {'similarity', 'influenceable'};
distr = {{'uniform',[0,1]}, {'uniform',[0,1]}}
nRealNews = 1;
nFakeNews = 1;
step_size = 10;

[A,people,FakeSources, RealSources,x0] = generate_society (N,traits, distr, nRealNews, nFakeNews);

[X] = spread_news(timesteps, A, x0);

visualize_function(A,X',timesteps,1,step_size);

X = X(:,end);
opts = statset('Display','final');
[idx,C] = kmeans(X,2,'Distance','cityblock',...
    'Replicates',5,'Options',opts);
figure(10);
plot(X(idx==1,1),X(idx==1,1)*0,'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),X(idx==2,1)*0,'b.','MarkerSize',12)
plot(C(:,1),C(:,1)*0,'kx',...
     'MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off