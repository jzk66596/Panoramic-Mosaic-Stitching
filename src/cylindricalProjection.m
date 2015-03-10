%Convert to cylindrical coordinates
%Input: images - images
%       f - focus length
%Output: proj_images - converted images
function proj_images = cylindricalProjection (images, f)
p = size(images,4);
proj_images = zeros(size(images));

xlen = size(images,2);
ylen = size(images,1);
xc = xlen/2;
yc = ylen/2;

for x = 1 : xlen
    theta = (x - xc)/f;
    for y = 1 : ylen
        h = (y - yc)/f;
        x_hat = sin(theta);
        y_hat = h;
        z_hat = cos(theta);
        ximg = int64(f*x_hat/z_hat + xc);
        yimg = int64(f*y_hat/z_hat + yc);
        if (ximg > 0 && ximg <= xlen && yimg > 0 && yimg <= ylen)
            for k = 1 : p
                proj_images(y, x,:,k) = uint8(images(yimg, ximg, :,k));
            end
        end
    end
end
proj_images = uint8(proj_images);
end