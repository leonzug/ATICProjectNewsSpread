function [isSteadyState,WhenSteadyState] = is_steady_state(X,tol)
X_shifted = circshift ( X , [0,1]);
dX = X-X_shifted;
dX = dX(:,2:end);
dX = sum(abs(dX),1);
WhenSteadyState = find(dX < tol);
if isempty(WhenSteadyState) == true
    WhenSteadyState = 'never reached';
    isSteadyState = 'False';
    return
end
WhenSteadyState = WhenSteadyState(1);
isSteadyState = 'True';
end