function coupledYield = printCoupledYield(model, targetRxn, biomassRxn)
    model.c = zeros(size(model.c));
    model.c(ismember(model.rxns, biomassRxn)) = 1;
    soln = optimizeCbModel(model);
    if ~isempty(soln.x)
        coupledYield = soln.x(ismember(model.rxns, targetRxn));
        fprintf('%.4f,', coupledYield);
    else
        coupledYield = [];
        fprintf('no sol,');
    end
    fprintf('\n')
end