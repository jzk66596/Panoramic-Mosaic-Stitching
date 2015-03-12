% set up sift feature toolbox
VLFEATROOT = '../vlfeat-0.9.20';
run(strcat(VLFEATROOT,'/toolbox/vl_setup'))
% read images
dirPath = '../data/testingImages/';
files = dir(strcat(dirPath,'*.jpg'));

disp('Start reading images');
images = readImages(files,dirPath);
disp('Finish reading images');

f = 595;
disp('Start cylindrical projection');
proj_images = cylindricalProjection(images,f);
disp('Finish cylindrical projection');

disp('Start cropping images');
crop_images = cropImages(proj_images);
disp('Finish cropping images');

disp('Start stiching images');
finalImage = stich(crop_images);
disp('Finish stiching images');

