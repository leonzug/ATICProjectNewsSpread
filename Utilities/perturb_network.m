function [A_perturbed] = perturb_network(A,FakeSources,RealSources,perturbation,degree)
% degree: percentage of sources to add/remove
% decrease number of fake news media
if strcmp(perturbation, 'censorship')
    A_perturbed = A;
    nFakeSourcesNew = round(size(FakeSources,1)/degree);
    FakeSources = FakeSources(randi(size(FakeSources,nFakeSourcesNew,1)));
    for i=1:size(FakeSources,1)
       A_perturbed(:,FakeSources(i)) = zeros(size(A,2),1);
       A_perturbed(FakeSources(i),FakeSources(i))=1;
    end
    A_perturbed = A_perturbed./(ones(size(A_perturbed,1),1)*sum(A_perturbed,2)')';
end
% increase connection strenght of real news sources
if strcmp(perturbation, 'information')
    A_perturbed = A;
    for i=1:size(RealSources,1)
       A_perturbed(:,RealSources(i)) = degree*A_perturbed(:,RealSources(i));
       A_perturbed(RealSources(i),RealSources(i))=A_perturbed(RealSources(i),RealSources(i))/degree;
    end
    A_perturbed = A_perturbed./(ones(size(A_perturbed,1),1)*sum(A_perturbed,2)')';
end
% increase connection strenght of fake news sources
if strcmp(perturbation, 'disinformation')
    A_perturbed = A;
    for i=1:size(FakeSources,1)
       A_perturbed(:,FakeSources(i)) = degree*A_perturbed(:,FakeSources(i));
       A_perturbed(FakeSources(i),FakeSources(i))=A_perturbed(FakeSources(i),FakeSources(i))/degree;
    end
    A_perturbed = A_perturbed./(ones(size(A_perturbed,1),1)*sum(A_perturbed,2)')';
end

end


