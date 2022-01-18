function modified_model_img = apply_illuminant(model_img, isDark)
    if ~exist('isDark','var')
        isDark = false;
    end
    if(isDark)
        illuminant = im2double(imread('SceneIlluminant.png'));
        modified_model_img =im2double(imfuse(model_img,illuminant,'blend','Scaling','joint'));
    else
        modified_model_img=model_img;
    end
    mask = create_circle_mask(540, 270);
    modified_model_img(repmat(mask,[1,1,3])==0)=1; 
    if(isDark)
        modified_model_img = illumination_normalization(modified_model_img);
%             modified_model_img = imlocalbrighten(modified_model_img);
    end
end  