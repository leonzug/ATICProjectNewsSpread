function [x] = random_distribution (N,distr)

if strcmp(distr{1},'uniform')
   x = unifrnd(distr{2}(1), distr{2}(2), N,1);
   
elseif strcmp(distr{1},'beta')
   x = sampleFromBeta(N, distr{2});

elseif or(strcmp(distr{1},'gaussian_discrete'),strcmp(distr{1},'gaussian'))
    x = normrnd(distr{2}(1), distr{2}(2), N,1);
    if strcmp(distr{1},'gaussian_discrete')
        x = round(x);
    end
elseif strcmp(distr{1},'fixed')
    x=ones(N,1)*distr{2};
end

end
    