function solverOK = setupCobraSolver
    solverOK = false;
    gurobi_matlab_path = '/Library/gurobi501/mac64/matlab/';
    if exist([gurobi_matlab_path 'gurobi.m'],'file')
        try
            addpath(gurobi_matlab_path)
            setenv('PATH',[getenv('PATH'),':/Library/gurobi501/mac64/bin'])
            setenv 'GUROBI_HOME' '/Library/gurobi501/mac64'
            setenv 'GRB_LICENSE_FILE' '/Library/gurobi501/gurobi.lic'
            solverOK = changeCobraSolver('gurobi5','LP');
            solver = 'gurobi5';
        catch
            solverOK = false;
            disp('error setting up gurobi 5')
        end
    end
    if ~solverOK && exist('gurobi_mex','file')
        setenv 'GUROBI_HOME' '/Library/gurobi461/mac64'
        setenv('PATH', [getenv('PATH') ':/Library/gurobi461/mac64/bin'])
        % setenv 'LD_LIBRARY_PATH' '/Library/gurobi461/mac64/lib:/usr/local/lib'
        % setenv 'DYLD_LIBRARY_PATH' '/usr/local/lib'
        setenv 'GRB_LICENSE_FILE' '/Library/gurobi461/gurobi.lic'
        solverOK = changeCobraSolver('gurobi','LP');
        solver = 'gurobi';
    end
    if solverOK
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