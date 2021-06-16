function [A,people,FakeSources, RealSources,x0,nodenames] = generate_society (nPeople,traits, distr, nRealNews, nFakeNews, newsRange, locality, C, nRoot)

nTraits=length(traits);
people = zeros(nPeople,nTraits);
nodenames = {};

for i=1:nTraits
    people(:,i) = random_distribution(nPeople,distr{i});
end

[A, FakeSources, RealSources] = generate_adiacency(people, traits, nRealNews, nFakeNews, newsRange, locality, C, nRoot);

nPeople = size(A,1);
x0 = zeros(nPeople,1);
for i=1:nRealNews
    x0(RealSources(i))=1;
end
for i=1:nFakeNews
    x0(FakeSources(i))=-1;
end
for j=1:nPeople
    if any(RealSources==j)
        nodenames = [nodenames,"Real Source" + j];
        continue;
    elseif any(FakeSources==j)
        nodenames = [nodenames,"Fake Source"+j];
        continue;
    end
    nodenames = [nodenames, j];
end
end


