function [cp, cp_idx] = findClosestPoint(pointA, setB)
% INPUT
% point A - single point
% set B - set of points to be compared with point A
% OUTPUT
% cp - point from setB (that is closest to point A)
% cp_idx - index of cp in setB

distances = sqrt(sum(bsxfun(@minus, setB, pointA).^2, 2));
%find the smallest distance and use that as an index into B:
cp_idx = find(distances == min(distances));
cp = setB(cp_idx, :);