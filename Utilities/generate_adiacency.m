function [A, FakeSources, RealSources] = generate_adiacency(people, traits, nRealNews, nFakeNews, newsRange, locality, C, nRoot)

% Settable Parameters: 
% P(connection between node i and node j) = C / (distance(i,j))^(1/nRoot)

% Implicit Parameters
div_coeff = [1,1]; % 1/(div_coeff(i)+parameter) 1: similarity, 2: critical thinking
nPeople = size(people,1);
A = zeros(nPeople, nPeople);
nTraits=length(traits);
infl_index = 0;
for k=1:nTraits
    if strcmp(traits(k), 'influenceable')
        infl_index = k;
        continue;
    end
    if strcmp(traits(k), 'critical thinker')
        crit_index = k;
        continue;
    end
    for i = 1:nPeople
        for j = (i+1):nPeople
            distance = min(abs(j-i), abs(nPeople-j+i));
            u = rand;
            if u < C/nthroot(distance, nRoot)
                A(i,j) = 1;
                A(j,i) = A(i,j);
                k_i = people(i,k);
                k_j = people(j,k);
                if strcmp(traits(k), 'similarity')
                    A(i,j) = A(i,j)/(div_coeff(1)+abs(k_i-k_j));
                    A(j,i) = A(j,i)/(div_coeff(1)+abs(k_j-k_i));
                end
            end
        end
    end
end
if infl_index > 0
    A = A + 10*diag(1./(div_coeff(2)+people(:,infl_index)));
end

A = [A, zeros(nPeople, nRealNews + nFakeNews)];
A = [A; zeros(nRealNews + nFakeNews, nPeople + nRealNews + nFakeNews)];
A = A + diag([zeros(nPeople,1); ones(nFakeNews+nRealNews,1)]);

for i=1:nFakeNews
    if locality(1)
        val = randi(nPeople);
        for z=1:newsRange(1)
            idx = mod(val+z,nPeople)+1;
            A(idx,nPeople+i) = 1-people(idx,crit_index);
        end
    else
        targets = randperm(nPeople, newsRange(1),1);
        for z=1:newsRange(1)
            A(targets(z,1),nPeople+i) = 1-people(targets(z,1),crit_index);
        end
    end
end

for i=1:nRealNews
    if locality(2)
        val = randi(nPeople);
        for z=1:newsRange(2)
            idx = mod(val+z,nPeople)+1;
            A(idx,nPeople+nFakeNews+i) = people(idx,crit_index);
        end
    else
        targets = randperm(nPeople, newsRange(1),1);
        for z=1:newsRange(2)
            A(targets(z,1),nPeople+nFakeNews+i) = people(targets(z,1),crit_index);
        end
    end
end

A = A./(ones(nPeople+nFakeNews+nRealNews,1)*sum(A,2)')';
FakeSources = [(nPeople+1):(nPeople+nFakeNews)]';
RealSources = [(nPeople+nFakeNews+1):(nPeople+nFakeNews+nRealNews)]';

end