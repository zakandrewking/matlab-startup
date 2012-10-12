function vals = swapModelValues(model, inVals, inString, outString)
% return reaction names in proper order
    vals = {};
    allInVals = getfield(model, inString);
    allOutVals = getfield(model, outString);
    if ~iscell(allInVals) || ~iscell(allOutVals)
        error('must be cells');
    end
    for i=1:length(inVals)
        vals = [vals; allOutVals(ismember(allInVals,inVals{i}))];
    end
end