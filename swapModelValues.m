function [vals, matched, multiples] = swapModelValues(model, inVals, inString, outString, ...
                                returnFirst)
    if nargin < 5
        returnFirst = false;
    end
    
    % return reaction names in proper order
    vals = {}; multiples = {};
    if returnFirst
        matched = inVals;
    else
        matched = {};
    end
    allInVals = getfield(model, inString);
    allOutVals = getfield(model, outString);
    if ~iscell(allInVals) || ~iscell(allOutVals)
        error('must be cells');
    end
    for i=1:length(inVals)
        if returnFirst
            ind = find(ismember(allInVals,inVals{i}),1);
            vals = [vals; allOutVals(ind)];
            if isempty(ind)
                fprintf('no result for %s\n', inVals{i});
            end
        else
            sel = ismember(allInVals,inVals{i});
            vals = [vals; allOutVals(sel)];
            for j=1:length(find(sel))
                matched = [matched; inVals{i}];
            end
            if length(find(sel))>1
                multiples = [multiples; inVals{i}];
            end
        end
    end
end