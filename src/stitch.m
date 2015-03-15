%Stich all images together
%Input: proj_images - input images
%Ouput: panormicImg
function finalImage = stitch(proj_images)
    curYshift = 0;
    yShiftSum = 0
    Ia = proj_images(:,:,:,1);
    temp = Ia;
    for i = 1 : size(proj_images,4)-1
        i
        %Ia = proj_images(:,:,:,i);
        Ia = temp;
        Ib = proj_images(:,:,:,i+1);
        [xshift, yshift] = translationMotion(Ia,Ib);
        yShiftSum = yShiftSum + yshift;
        curXshift = xshift;
        curYshift = -curYshift + yshift;
        if i < size(proj_images,4)-1
            Ic = proj_images(:,:,:,i + 2);
            Ib = ECChangeColor(Ib, Ia, Ic);
            temp = Ib;
        end
        if i == 1
            %panoramicImg = stitchTwoImages(Ia,Ib,curXshift,curYshift);
            panoramicImg = ECPyramidBlending(Ia,Ib,curXshift,curYshift);
        else
            %panoramicImg = stitchTwoImages(panoramicImg,Ib,curXshift,curYshift);
            panoramicImg = ECPyramidBlending(panoramicImg,Ib,curXshift,curYshift);
        end
    end
    %imshow(panoramicImg)
    %finalImage = panoramicImg;
    finalImage = driftImage(panoramicImg, yShiftSum);
    imshow(finalImage)
end

function finalImage = driftImage(inputImage, yShiftSum)
    
    if(yShiftSum < 0)
        yShiftSum = -yShiftSum;
    end
    height = size(inputImage, 1) - yShiftSum * 2;
    width = size(inputImage, 2);
    finalImage = zeros(height, width, 3);
    for i = 1 : height
        for j = 1 : width
            increment = (double(j) - 1 ) / (double(width) - 1) * yShiftSum * 2;
            newHeightValue = uint32(i + increment);
            finalImage(i, j, :) = inputImage(newHeightValue, j, :);
        end
    end    
    finalImage = uint8(finalImage);
end
