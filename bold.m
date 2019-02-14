%This function saves the raw BOLD images for each subject as a jpg.  This
%is done for both conditions (drug/placebo) in all groups (auditory,
%connectivity, etc).  This does make every individual image pop up then
%close as it is being saved. 

%This subject needs the input of a subject (subject), where you want the figure
%saved (mainfile), and the directory of the motion data to graph
%(currfile).  This is provided by the makefile.
function bold(subject, mainfile, currfile)
%In the directory currfile, there is a nifti image run_01.nii.  If we use
%the command spm_check_registration on this image, the image is opened up
%in the format that we want.
spm_check_registration run_01.nii

%spm_print will save whatever image is open then close the image.  This
%saves the image as a jpg to the mainfile (specified by make) then closes 
% the image.
spm_print(mainfile, 'Graphics', 'jpg')
end
