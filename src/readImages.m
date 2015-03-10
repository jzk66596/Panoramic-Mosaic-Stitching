%Read images
%Input: files - the vector of file names
%Output: images
function images = readImages(files, dirPath)% Number of files
    p = length(files);
    % Get image size
    imagesSize = size(imread(strcat(dirPath,files(1).name)));
    % Declare images matrix
    images = zeros([imagesSize p]);
    size(images)
    for i = 1:p
        strcat(dirPath,files(i).name)
        images(:,:,:,i) = imread(strcat(dirPath,files(i).name));
    end
    images = uint8(images);
end