function [evaluation] = metrics(X, metric, instances, nfigure,RealSources,FakeSources)

X(RealSources,:)=[];
X(FakeSources,:)=[];

if or(or(strcmp(metric,'avg'),strcmp(metric,'average')),strcmp(metric,'mean'))
    evaluation = zeros(instances,1);
    step = floor(size(X,2)/instances);
    for i=1:instances
        evaluation(i) = mean(X(:,step*i));
    end
end

if or(or(strcmp(metric,'hyst'),strcmp(metric,'peaks')),strcmp(metric,'hystogram'))
    figure(nfigure)
    histogram(X(:,end),instances)
    evaluation =[];
end
    
if or(strcmp(metric,'std'),strcmp(metric,'standard deviation'))
    evaluation = zeros(instances,1);
    step = floor(size(X,2)/instances);
    for i=1:instances
        evaluation(i) = std(X(:,step*i));
    end
end