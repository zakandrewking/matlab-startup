function output = solnForModelRxns(model,soln,rxns)
    output = [model.rxns(ismember(model.rxns,rxns)) num2cell(soln.x(ismember(model.rxns,rxns)))];
end