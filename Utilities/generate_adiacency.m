function [A, FakeSources, RealSources] = generate_adiacency(people, traits, nRealNews, nFakeNews)

% 
nPeople = size(people,1);
A = zeros(nPeople, nPeople);
nTraits=length(traits);
FakeSources = randi(nPeople,nFakeNews,1);
RealSources = randi(nPeople,nRealNews,1);
infl_index = 0;

% pairs =[];
% for 
%             
%         end
%     end
% end
% initial network
C = 0.5;
nRoot = 2;

for i = 1:nPeople
    for j = (i+1):nPeople
        distance = min(abs(j-i), abs(nPeople-i));
        u = rand;
        if u < C/nthroot(distance, nRoot)
            A(i,j) = 1;
            A(j,i) = A(i,j);
            for k=1:nTraits
                k_i = people(i,k);
                k_j = people(j,k);
                if strcmp(traits(k), 'similarity')
                    A(i,j) = A(i,j)/abs(k_i-k_j);
                    A(j,i) = A(j,i)/abs(k_j-k_i);
                end
                if strcmp(traits(k), 'influenceable')
                    infl_index = k;
                end
            end
        end
    end
end
if infl_index > 0
    infl_index
    people
    A = A + diag(people(:,infl_index));
end

for i=1:nFakeNews
    A(FakeSources(i,1), :) = A(FakeSources(i,1), :)*0;
    A(FakeSources(i,1),FakeSources(i,1)) = 1;
end
for i=1:nRealNews
    A(RealSources(i,1), :) = A(RealSources(i,1), :)*0;
    A(RealSources(i,1), RealSources(i,1)) = 1;
end
sum(A,2)
A = A./(ones(nPeople,1)*sum(A,2)')';

end