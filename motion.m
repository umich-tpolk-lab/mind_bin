%This script finds the motion data for whatever drug condition and group
%you want, then graphs this data and saves the graph as a png.

%This subject needs the input of a subject (subject), where you want the figure
%saved (mainfile), and the directory of the motion data to graph
%(currfile).  This is provided by the makefile.
function motion(subject, mainfile, currfile)
	%Create a matrix, test, which is the imported motion data (located at
	%currfile).
    test = importdata(currfile);
	
	%The motion data (saved as test) has 6 columns.  The first three
	%correspond to rotation and are in radians.  The first row is the x
	%direction, second is y direction, and third is z direction.  The last
	%three rows correspond to translation (x y z directions) and is in mm.
	
	%This is the line of rotation in x direction
    line1 = test(:,1);
	
	%This is the line of rotation in y direction
    line2 = test(:,2);
	
	%This is the line of rotation in z direction
    line3 = test(:,3);
	
	%This is the line of translation in x direction
    line4 = test(:,4);
	
	%This is the line of translation in y direction
    line5 = test(:,5);
	
	%This is the line of translation in z direction
    line6 = test(:,6);
	
	% This gets the length (like number of rows) for test.
    szdim2 = size(test,1);
	
	% I set the variable x to be 1 through whatever szdim2 is, going by 1s.
	% 1, 2, 3, ....180, 181, etc. 
	x = (1:szdim2);
	
	% I create f, which is an empty figure, but I don't want it to
	% popup/appear.
    f = figure('visible','off');
	
	% I will eventually want the rotation and translation graphs to be in
	% one image, so I will plot them both with the rotation graph on top
	% and translation graph at the bottom.  This just sets up the location
	% of the first plot.
    plot1 = subplot(2,1,1);
	
	%Now I want to plot all the rotation data (line1, line2, line3), with
	%each value in the column lining up with a value in x.  
    plot(x, line1, x, line2, x, line3);
	
	% I will title the plot I just made "Rotations".
    title(plot1, 'Rotations');
	
	% I will give this plot a ylabel axis of "Rotation (rad)".
    ylabel(plot1, 'Rotation (rad)');
	
	% I will give this plot a xlabel axis of "Volume Number".
    xlabel(plot1, 'Volume Number');
	
	%This just sets the space for a second plot to fit under the first
	%plot.  This is where the translation data will go.  
    plot2 = subplot(2,1,2);
	
	%Now I want to plot all the translation data (line4, line5, line6), with
	%each value in the column lining up with a value in x.
    plot(x, line4, x, line5, x, line6);
	
	% I will title the plot I just made "Translations".
    title(plot2, 'Translations');
	
	% I will give this plot a ylabel axis of "Translation (mm)".
    ylabel(plot2, 'Translation (mm)');
	
	% I will give this plot a xlabel axis of "Volume Number".
    xlabel(plot2, 'Volume Number');
	
	%I will then save this figure I made (f) with the two plots of rotation
	%and translation to "mainfile", as specified by the makefile, and it
	%will be saved in png format. 
    saveas(f, mainfile, 'png');
	
	
end
