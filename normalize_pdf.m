function C = normalize_pdf(C)
    if sum(isinf(C(:)))>0
        [M,N] = size(C);
        for i = 1:M
            minimum_val = min(C(i,~isinf(C(i,:))));
            C(i,isinf(C(i,:))) = minimum_val-1;
        end
    end
    min_C = min(C,[],2);
    max_C = max(C,[],2);
    C = (C - min_C)./(max_C - min_C);
end