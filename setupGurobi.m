function setupGurobi(opt)

% if opt==1, set gurobi as LP solver
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% setup gurobi solver
    setenv 'GUROBI_HOME' '/Library/gurobi461/mac64'
    setenv([getenv('PATH') ':/Library/gurobi461/mac64/bin'])
    setenv 'LD_LIBRARY_PATH' '/Library/gurobi461/mac64/lib:/usr/local/lib'
    setenv 'DYLD_LIBRARY_PATH' '/usr/local/lib'
    setenv 'GRB_LICENSE_FILE' '/Library/gurobi461/gurobi.lic'
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if (nargin>0 && opt==1) 
        changeCobraSolver('gurobi','LP');
    end
end