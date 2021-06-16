function [idx, C] = k_means(X)
X = X(:,end);
[idx,C] = kmeans(X,2);
figure(10);
plot(X(idx==1,1),X(idx==1,1)*0,'r.','MarkerSize',12);
hold on
plot(X(idx==2,1),X(idx==2,1)*0,'b.','MarkerSize',12);
plot(C(:,1),C(:,1)*0,'kx',...
     'MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off
end

