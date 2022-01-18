function img = delete_background(img, isOneChannel)
    if ~exist('isOneChannel','var')
        isOneChannel = false;
    end
    [M,N,~]=size(img);
    L = max([M,N]);
    mask = create_circle_mask(L, L/2);
    if(isOneChannel)
%        minVal = min(img(:));
       img(repmat(mask(1:M,1:N,:),[1,1,1])==0)=0;
    else
        img(repmat(mask(1:M,1:N,:),[1,1,3])==0)=1;
    end
end