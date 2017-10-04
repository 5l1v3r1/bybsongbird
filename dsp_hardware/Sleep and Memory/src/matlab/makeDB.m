function [ out ] = makeDB( varargin )
%MAKESPIKEDB Summary of this function goes here
%   Detailed explanation goes here

TargetDir = {'Nap+Cues+Good_Use'};

for iDir = 1 : length(TargetDir)
    if TargetDir{iDir}(1) == '\'
        TargetDir{iDir} = TargetDir{iDir};
    end
end

for iarg= 1:2:(nargin-1),   % assume an even number of varargs

    switch lower(varargin{iarg}),

        case {'dir','path','filepath'}
            TargetDir = varargin{iarg+1};

        case ''

        otherwise,

    end % end of switch
end % end of for iarg


current_dir = pwd;
if ~iscell(TargetDir)
    temp{1}=TargetDir;
    TargetDir=temp;
    clear temp;
end

s = {};

jsonfiles = dir([TargetDir{1} '/*.json'])

disp( ['Found ' num2str(length(jsonfiles)) ' sessions.']);

for iSession = 1:length(jsonfiles)

    jsonVersion = 1;
    
    disp(['Analyzing ' jsonfiles(iSession).name ]);
        try
            d = loadjson( [TargetDir{1} '/' jsonfiles(iSession).name]);
        
            if isfield(d, 'tmrEntries') 
                jsonVersion = 0.5;
                
                s.subject = jsonfiles(iSession).name(1:end-5);

               
                isCued = structfun(@(x) (strcmp( x.isTargeted, 'True')), d.tmrEntries, 'UniformOutput', false);
                s.treatment.cuedTargetIDs = find(struct2array( isCued ));

      
                s.treatment.uncuedTargetIDs = find(struct2array( isCued )==0);

                preNap = struct2array(structfun(@(x) (str2num(x.distanceBeforeSleep)), d.tmrEntries, 'UniformOutput', false));
               
                for iTrial = 1:size(preNap,2)
                    trials{iTrial}.targetID = iTrial;
                    trials{iTrial}.preNap = 1;
                    trials{iTrial}.feedback = 0;
                    trials{iTrial}.distanceInPoints = preNap(iTrial);
                end
                s.testing{3}.trials = trials;
                trials = [];

                
                postNap = struct2array(structfun(@(x) (str2num(x.distanceAfterSleep)), d.tmrEntries, 'UniformOutput', false));
                for iTrial = 1:size(postNap,2)
                    trials{iTrial}.targetID = iTrial;
                    trials{iTrial}.preNap = 0;
                    trials{iTrial}.feedback = 0;
                    trials{iTrial}.distanceInPoints = postNap(iTrial);
                end 
                s.testing{4}.trials = trials;
                
                s.treatment.subjectNapped = 1;
                s.treatment.subjectCued = 1;

            else
                s = d;
                
                %We can make slight changes to the jSON here.  For
                %exmpample, no cue during sleep.
                s.treatment.subjectCued = 1;
                
                if strcmp( s.subject, 'Subject05')
                    s.treatment.subjectCued = 0;
                end
                if strcmp( s.subject, 'Subject07')
                    s.treatment.subjectCued = 0;
                end
            end
        
        catch
            
        end
        
        out{iSession} = s;

end

