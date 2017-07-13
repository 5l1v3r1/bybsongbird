function [ y, stdError ] = plotPrePost( d, varargin )
%PLOTPREPOST will plot the pre- and post- treatment differences from an EEG
%sleep exeriment

barColor = 'b';
makeplot = 1;
errorbarColor = 'r';

for iarg= 1:2:(nargin-2),   % assume an even number of varargs

        switch lower(varargin{iarg}),

            case {'color','barcolor'}
                barColor = varargin{iarg+1};

            case {'errorcolor','errorbarcolor'}
                errorbarColor = varargin{iarg+1};

            case 'plot',
                makeplot = varargin{iarg+1};

        end % end of switch
end % end of for iarg


allCuedImages = (d.treatment.cuedTargetIDs);
allUnCuedImages = (d.treatment.uncuedTargetIDs);

numOfCuedImages = length(allCuedImages);
numOfUnCuedImages = length(allUnCuedImages);

trialsForPreNapNoFeedback = d.testing{3}.trials;
numOfPreTrials = length(trialsForPreNapNoFeedback);

trialsForPostNapNoFeedback = d.testing{4}.trials
numOfPostTrials = length(trialsForPostNapNoFeedback);

cuedBS = [];
cuedAS = [];
unCuedBS = [];
unCuedAS = [];

for t = 1:numOfPreTrials
    preIDs = trialsForPreNapNoFeedback{t}.targetID;
    if(sum(allCuedImages==preIDs)>0)
        cuedBS = [cuedBS trialsForPreNapNoFeedback{t}.distanceInPoints];
        
    else
        unCuedBS = [unCuedBS trialsForPreNapNoFeedback{t}.distanceInPoints];
    end   
end

for i = 1:numOfPostTrials
    postIDs = trialsForPostNapNoFeedback{i}.targetID;
    if(sum(allCuedImages==postIDs)>0)
        cuedAS = [cuedAS trialsForPostNapNoFeedback{i}.distanceInPoints];
        
    else
        unCuedAS = [unCuedAS trialsForPostNapNoFeedback{i}.distanceInPoints];
    end   
end
% out.cuedBS = cuedBS;
% out.cuedAS = cuedAS;
% out.uncuedBS = uncuedBS;
% out.uncuedAS = uncuedAS;D
out.meanCuedBS = mean(cuedBS);
out.stdCuedBS = (std(cuedBS))/sqrt(24);
out.meanCuedAS = mean(cuedAS);
out.stdCuedAS = (std(cuedAS))/sqrt(24);
out.meanUnCuedBS = mean(unCuedBS);
out.stdUnCuedBS = (std(unCuedBS))/sqrt(24);
out.meanUnCuedAS = mean(unCuedAS);
out.stdUnCuedAS = (std(unCuedAS))/sqrt(24);

meanCued = (out.meanCuedAS - out.meanCuedBS);
stdCued = out.stdCuedAS - out.stdCuedBS;
meanUnCued = (out.meanUnCuedAS - out.meanUnCuedBS);
stdUncued = out.stdUnCuedAS - out.stdUnCuedBS;

%y =[out.meanCuedBS out.meanCuedAS out.meanUnCuedBS out.meanUnCuedAS];
y = [meanCued meanUnCued];
%stdError = [out.stdCuedBS out.stdCuedAS out.stdUnCuedBS out.stdUnCuedAS];
stdError = [stdCued stdUncued];

 bar(y,0.3)
 %set(gca,'XTickLabel',{'CuedBS','CuedAS','UnCuedBS','UnCuedAS'})
set(gca,'XTickLabel',{'Cued','UnCued'})
 hold on;
 h=errorbar(y,stdError,'r'); set(h,'linestyle','none');

