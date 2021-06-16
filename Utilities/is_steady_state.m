[isSteadyState,WhenSteadyState] = function(X,tol)
X_shifted = circshift ( X , [0,1]);
dX = X-X_shifted;
dX = dX(:,2:end);
dX = sum(abs(dX),2);
WhenSteadyState = 0;
WhenSteadyState = find(dX < tol)(1);
isSteadyState = WhenSteadyState >0;
end