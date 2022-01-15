function C = normalize_pdf(C)
    C(isinf(C)) = -1* realmin; %because we might get -Inf from log(normpdf) we need to change it to smallest possible value we can compute
    min_C = min(C,[],2);
    max_C = max(C,[],2);
    C = (C - min_C)./(max_C - min_C);
end