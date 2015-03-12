%Stich all images together
%Input: proj_images - input images
%Ouput: panormicImg
function panoramicImg = stich(proj_images)
    for i = 1 : size(proj_images,4)-1
        i
        Ia = proj_images(:,:,:,i);
        Ib = proj_images(:,:,:,i+1);
        [xshift, yshift] = translationMotion(Ia,Ib);
        curXshift = xshift;
        curYshift = yshift;
        if i == 1
            panoramicImg = stichTwoImages(Ia,Ib,curXshift,curYshift);
        else
            panoramicImg = stichTwoImages(panoramicImg,Ib,curXshift,curYshift);
        end
    end
end