function ssp = printSsp(model, targetRxn, biomassRxn) 
    model.c = zeros(size(model.c));
    model.c(ismember(model.rxns, biomassRxn)) = 1;
    soln = optimizeCbModel(model); 
    if ~isempty(soln.x)
        ssp = soln.x(ismember(model.rxns, targetRxn))*soln.f;
        fprintf('%.4f,', ssp);
    else
        ssp = [];
        fprintf('no sol,');
    end
    fprintf('\n')
end