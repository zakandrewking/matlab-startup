function [model, biomassRxn] = ...
        setupModel(modelName,substrate,aerobicStr,transhydrogenaseKoStr,POR5Str)
% setupModel
% 
% INPUTS
%   modelName
%   substrate
%   aerobicStr - 'aerobic' or 'anaerobic'
%   transhydrogenaseKoStr - 'THKO' or 'noTHKO'
% 
% OUTPUTS
%   model
%   biomassRxn
%
% Zachary King 9/12/12

    if strcmp(aerobicStr, 'aerobic')
        isAerobic = true;
    elseif strcmp(aerobicStr, 'anaerobic')
        isAerobic = false;
    else
        fprintf('misspelled %s\n', aerobicStr)
    end
    if nargin < 4
        transhydrogenaseKnockout = false;
    else
        if strcmp(transhydrogenaseKoStr, 'THKO')
            transhydrogenaseKnockout = true;
        elseif strcmp(transhydrogenaseKoStr, 'noTHKO')
            transhydrogenaseKnockout = false;
        else
            fprintf('misspelled %s\n', transhydrogenaseKoStr)
        end 
    end 
    if nargin < 5
        POR5Str = 'POR5_irrev';
    end
    
    % load the model
    model = loadModelNamed(modelName);
    biomassRxn = model.rxns(model.c~=0);
    
    % set ATPM
    % model = changeRxnBounds(model, 'ATPM', 8.37, 'b');
    
    % prepare the model
    if transhydrogenaseKnockout
        % knock out th's
        thRxns = {'NADTRHD', 'THD2pp'};
        model = changeRxnBounds(model, thRxns, 0, 'b');
    end
    model = changeRxnBounds(model, 'EX_glc(e)', 0, 'l');
    model = changeRxnBounds(model, substrate, -20, 'l');
    if isAerobic
        model = changeRxnBounds(model, 'EX_o2(e)', -20, 'l');
    else
        model = changeRxnBounds(model, 'EX_o2(e)', 0, 'l'); 
        % BAD REACTIONS, DOWN BOY
        model = changeRxnBounds(model, {'CAT';'SPODM';'SPODMpp'}, [0;0;0], 'b');
        % can make oxygen...turn off for anaerobic simulations 
    end
    % Swap reactions, keeping wild type dehydrogenases
    % [~, newNames] = modelSwap(model, dhRxns, true);

    
    % Make POR5 irreversible
    if strcmp(POR5Str,'POR5_irrev')
        model = changeRxnBounds(model, 'POR5', 0, 'l');
        model.rev(ismember(model.rxns, 'POR5')) = 0;
    elseif strcmp(POR5Str,'POR5_rev')
    else
        error(sprintf('misspelled %s', POR5Str));
    end
    
end