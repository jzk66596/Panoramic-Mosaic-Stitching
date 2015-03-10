% set up sift feature toolbox
VLFEATROOT = '../vlfeat-0.9.20';
run(strcat(VLFEATROOT,'/toolbox/vl_setup'))
% read images
dirPath = '../data/testingImages/';
files = dir(strcat(dirPath,'*.jpg'));
images = readImages(files,dirPath);

f = 595;
proj_images = cylindricalProjection(images,f);

I = proj_images(:,:,:,1);
image(I)

I = single(rgb2gray(I));
[f,d] = vl_sift(I);
perm = randperm(size(f,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(f(:,sel)) ;
h2 = vl_plotframe(f(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;