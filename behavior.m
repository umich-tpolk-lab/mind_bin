function behavior(subject, mainfile)
Master = readtable('mindmaster_clean.csv', 'ReadRowNames', true); 
new = Master(:,{'Aud_P_Miss', 'Aud_P_Inc', 'Aud_D_Miss', 'Aud_D_Inc', 'Mot_P_Miss', 'Mot_D_Miss', 'Vis_P_Miss', 'Vis_P_Incor', 'Vis_D_Miss', 'Vis_D_Incor'});


try
new.Aud_P_Miss=str2double(new.Aud_P_Miss);
end
try
new.Aud_P_Inc=str2double(new.Aud_P_Inc);
end
try
new.Aud_D_Miss=str2double(new.Aud_D_Miss);
end
try
new.Aud_D_Inc=str2double(new.Aud_D_Inc);
end
try
new.Mot_P_Miss=str2double(new.Mot_P_Miss);
end
try
new.Mot_D_Miss=str2double(new.Mot_D_Miss);
end
try
new.Vis_P_Miss=str2double(new.Vis_P_Miss);
end
try
new.Vis_P_Incor=str2double(new.Vis_P_Incor);
end
try
new.Vis_D_Miss=str2double(new.Vis_D_Miss);
end
try
new.Vis_D_Incor=str2double(new.Vis_D_Incor);
end


new_mind2 = new;
new = new(1:47, :);
new_mind2 = new_mind2(48:end, :);
new_mind2.Aud_D_Miss = [];
new_mind2.Aud_D_Inc = [];
new_mind2.Mot_D_Miss = [];
new_mind2.Vis_D_Miss = [];
new_mind2.Vis_D_Incor = [];
new_mind2.Properties.VariableNames = ({'Aud_Miss', 'Aud_Inc', 'Mot_Miss', 'Vis_Miss', 'Vis_Inc'});
final4 = new_mind2;


new.Aud_Miss = (new.Aud_P_Miss + new.Aud_D_Miss);
new.Aud_Inc = (new.Aud_P_Inc + new.Aud_D_Inc);
new.Mot_Miss = (new.Mot_P_Miss + new.Mot_D_Miss);
new.Vis_Miss = (new.Vis_P_Miss + new.Vis_D_Miss);
new.Vis_Inc = (new.Vis_P_Incor + new.Vis_D_Incor);


final = new(:,{'Aud_Miss', 'Aud_Inc', 'Mot_Miss', 'Vis_Miss', 'Vis_Inc'});

final4.Properties.VariableNames = {'Number_of_Missed_Auditory_Response','Number_of_Incorrect_Auditory_Response','Number_of_Missed_Motor_Response','Number_of_Missed_Visual_Response','Number_of_Incorrect_Visual_Response'};
final.Properties.VariableNames = {'Number_of_Missed_Auditory_Response','Number_of_Incorrect_Auditory_Response','Number_of_Missed_Motor_Response','Number_of_Missed_Visual_Response','Number_of_Incorrect_Visual_Response'};
YourTable = final;
YourTable2 = final4;
x = YourTable.Properties.RowNames;
y = YourTable2.Properties.RowNames;
C = vertcat(x, y);
YourArray = table2array(YourTable);
YourArray2 = table2array(YourTable2);
FinalArray = [];
FinalArray = [FinalArray
			  YourArray
	          YourArray2];
YourNewTable = array2table(FinalArray.');
YourNewTable.Properties.RowNames = YourTable.Properties.VariableNames;
YourNewTable.Properties.VariableNames = C;


Tnew = YourNewTable(:, {subject});

H = height(Tnew);


if H > 0;
f = figure('visible','off');
uitable('Data',Tnew{:,:},'ColumnName',Tnew.Properties.VariableNames,...
'RowName',Tnew.Properties.RowNames,'Units', 'Normalized', 'Position',[0, 0, 1, 1]);
saveas(f, mainfile, 'png');
else 
end

