function [A,people,FakeSources, RealSources,x0,nodenames] = generate_society (nPeople,traits, distr, nRealNews, nFakeNews, newsRange, locality, C, nRoot)

nTraits=length(traits);
people = zeros(nPeople,nTraits);
nodenames = {};

for i=1:nTraits
    people(:,i) = random_distribution(nPeople,distr{i});
end

[A, FakeSources, RealSources] = generate_adiacency(people, traits, nRealNews, nFakeNews, newsRange, locality, C, nRoot);

nNodes = size(A,1);
x0 = zeros(nNodes,1);
for i=1:nRealNews
    x0(RealSources(i))=1;
end
for i=1:nFakeNews
    x0(FakeSources(i))=-1;
end
counter_real = 1;
counter_fake = 1;
for j=1:nNodes
    if any(RealSources==j)
        nodenames = [nodenames,"Real Source " + (counter_real)];
        counter_real= counter_real+1;
        continue;
    elseif any(FakeSources==j)
        nodenames = [nodenames,"Fake Source "+(counter_fake)];
        counter_fake= counter_fake+1;
        continue;
    end
    nodenames = [nodenames, j];
end
end


