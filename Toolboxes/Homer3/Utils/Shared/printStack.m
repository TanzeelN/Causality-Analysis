function printStack(ME)
global logger

if ~exist('ME','var')
    ME = [];
end

if isempty(logger)
    printcmd = 'fprintf';
elseif isa(logger, 'Logger')
    if ~logger.IsOpen()
        logger.Open();
    end
    if ~logger.IsOpen()
        printcmd = 'fprintf';
    else
        printcmd = 'logger.Write';
    end
else
    printcmd = 'logger.Write';
end

if isempty(ME)
    s = dbstack;
else
    s = ME.stack;
end

eval( sprintf('%s(''----------------------------------------------\\n'')', printcmd) );
if ~isempty(ME)
    eval( sprintf('%s(''ERROR:    %%s\\n'', ME.message)', printcmd) );
    eval( sprintf('%s(''Current Folder :  %%s\\n'', filesepStandard(pwd))', printcmd) );
end
eval( sprintf('%s(''Call stack:\\n'')', printcmd) );
for ii = 1:length(s)
    [~,f,e] = fileparts(s(ii).file); %#ok<*ASGLU>
    eval( sprintf('%s(''    Error in %%s > %%s (line %%d)\\n'', [f, e], s(ii).name, s(ii).line)', printcmd) );
end
eval( sprintf('%s(''----------------------------------------------\\n\\n'')', printcmd) );


