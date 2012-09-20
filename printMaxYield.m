function yield = printMaxYield(model, targetRxn, biomassRxn, minBiomass)
    model = changeRxnBounds(model, biomassRxn, minBiomass, 'l'); 
    model.c = zeros(size(model.c));
    model.c(ismember(model.rxns, targetRxn)) = 1;
    soln = optimizeCbModel(model);
    yield = soln.f;
    fprintf('%.4f,', yield);
    fprintf('\n');
end