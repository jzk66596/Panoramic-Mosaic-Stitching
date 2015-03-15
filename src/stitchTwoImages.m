%Stich two images together
%Input: image1, image2 - two images
%       xshift, yshift - x and y shift
%Output: newImg - result image
function newImg = stitchTwoImages(image1, image2, xshift, yshift)
%ensure we have image1 and image2 while xshift > 0
if xshift < 0
    xshift = -xshift;
    yshift = -yshift;
    temp = image2;
    image2 = image1;
    image1 = temp;
end

rxdim = max(size(image1,2), xshift + size(image2,2));
rydim = max(size(image2,1),size(image1,1))+2*abs(yshift);

ybase = int32(abs(ceil(yshift)));
xbase = 0;
newImg = double(zeros(ybase+int32(rydim), xbase+int32(rxdim),3));

%Assign the first image
for y = 1 : size(image1,1)
    for x = 1 : size(image1,2)
        newImg(y+ybase,x+xbase,:) = double(image1(y,x,:));
    end
end

%imshow(newImg)

xboundary = xbase + size(image1,2);
%yboundary = ybase + size(image1,1);
w = 0.5;
%Blend the second image
for y = 1 : size(image2,1)
    for x = 1 : size(image2,2)
        nx = int32(x + xshift+xbase);
        ny = int32(y + yshift+ybase);
        %check whether it is overlap
        if nx < xboundary || sum(newImg(ny,nx,:) == 0) == 0
            newImg(ny,nx,:) = w*newImg(ny,nx,:)...
                + (1-w)*double(image2(y,x,:));
        else
            newImg(ny,nx,:) = double(image2(y,x,:));
        end  
    end
end
newImg = uint8(newImg);
%imshow(newImg)
end
