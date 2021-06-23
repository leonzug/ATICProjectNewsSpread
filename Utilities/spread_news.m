function [X] = spread_news(timesteps, A, x0)
    X= zeros(size(A,1),timesteps+1);
    X(:,1)=x0;
    for i=1:timesteps
        X(:,i+1)=A*X(:,i);
    end
end
