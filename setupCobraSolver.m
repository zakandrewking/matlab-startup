function solverOK = setupCobraSolver
    solverOK = false;
    if exist('gurobi_mex','file')
        setenv 'GUROBI_HOME' '/Library/gurobi461/mac64'
        setenv([getenv('PATH') ':/Library/gurobi461/mac64/bin'])
        setenv 'LD_LIBRARY_PATH' '/Library/gurobi461/mac64/lib:/usr/local/lib'
        setenv 'DYLD_LIBRARY_PATH' '/usr/local/lib'
        setenv 'GRB_LICENSE_FILE' '/Library/gurobi461/gurobi.lic'
        solverOK = changeCobraSolver('gurobi','LP');

        % test gurobi
        try
            model = loadModelNamed('iAF');
            soln = optimizeCbModel(model);
        catch err
            solverOK = 0;
            str = 'Error: could not create environment. Please make sure that GUROBI has a license and been validated.';
            if (strcmp(err.message,str))
                disp('GUROBI_mex could not run. Check license');
            else
                disp('GUROBI_mex could not run. Unknown error');
            end
        end
        solver = 'gurobi';
    end
    if ~solverOK && exist('tomRun.m','file')
        solverOK = changeCobraSolver('tomlab_cplex','LP');
        solver = 'tomlab_cplex';
    end
    if ~solverOK && exist('glpk.m','file')
        solverOK = changeCobraSolver('glpk','LP');
        solver = 'glpk';
    end


    if solverOK
        display(['Setting up solver ' solver]);
        changeCobraSolver(solver,'MILP');
        changeCobraSolver(solver,'QP');
        changeCobraSolver(solver,'MIQP');
    else
        error('no solver available');
    end


end