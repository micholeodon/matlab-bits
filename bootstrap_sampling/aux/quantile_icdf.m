function x = quantile_icdf(X, a)
% Function that returns index of element from sorted list. 
% That element is the closest element to the alpha-quantile obtained from
% inverse cdf F^{-1}(a). See Lunneborg book about bootstraping p. 11.

X_sort = sort(X, 'ascend');
N = numel(X);

if(a <= 0.5)
    idx = floor(a*(N+1));
else
    idx = N + 1 - floor((1-a)*(N+1));
end

x = X_sort(idx);
