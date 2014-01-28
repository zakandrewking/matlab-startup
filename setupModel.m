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

    if strcmp(modelName,'yeast6') || strcmp(modelName,'yeast7')
        glucoseExchange = 'r_1714';
        oxygenExchange = 'r_1992';
    else
        glucoseExchange = 'EX_glc(e)';
        oxygenExchange = 'EX_o2(e)';
    end

    aerobicStr = lower(aerobicStr);
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
        transhydrogenaseKoStr = lower(transhydrogenaseKoStr);
        if strcmp(transhydrogenaseKoStr, 'thko')
            transhydrogenaseKnockout = true;
        elseif strcmp(transhydrogenaseKoStr, 'nothko')
            transhydrogenaseKnockout = false;
        else
            fprintf('misspelled %s\n', transhydrogenaseKoStr)
        end
    end
    if nargin < 5
        POR5Str = 'por5_irrev';
    else
        POR5Str = lower(POR5Str);
    end


    % load the model
    model = loadModelNamed(modelName);
    biomassRxn = model.rxns(model.c~=0);

    % prepare the model
    if transhydrogenaseKnockout
        % knock out th's
        thRxns = {'NADTRHD', 'THD2pp'};
        model = changeRxnBounds(model, thRxns, 0, 'b');
    end
    model = changeRxnBounds(model, glucoseExchange, 0, 'l');
    if ~strcmp(substrate,'none')
        model = changeRxnBounds(model, substrate, -10, 'l');
    end
    if isAerobic
        model = changeRxnBounds(model, oxygenExchange, -10, 'l');
    else
        model = changeRxnBounds(model, oxygenExchange, 0, 'l');
        % BAD REACTIONS, DOWN BOY
        if strcmp(modelName,'iND750') || strcmp(modelName, 'iMM904')
            necessary_ex = {'EX_ergst(e)', 'EX_zymst(e)', 'EX_hdcea(e)', ...
                            'EX_ocdca(e)', 'EX_ocdcea(e)', ...
                            'EX_ocdcya(e)'};
            % 'EX_k(e)','EX_na1(e)', 'EX_co2(e)'};
            model = changeRxnBounds(model, necessary_ex, -1000, 'l');
            model = changeRxnBounds(model, necessary_ex, 1000, 'u');
        elseif strcmp(modelName,'yeast6') && ~isAerobic
            if ~isAerobic
                model = changeRxnBounds(model, 'r_0226', 0, 'b'); % ATP synthase

                % Simulating anaerobic growth with Yeast 6 requires the simulated
                % medium to be supplemented with sterols [i.e. the exchange
                % reactions for episterol, ergosterol, fecosterol, lanosterol,
                % zymosterol and ergosta-5,7,22,24(28)-tetraen-3beta-ol must have
                % nonzero lower bounds].
                necessary_ex = {'r_1753', % episterol
                                'r_1757', % ergosterol
                                'r_1788', % fecosterol
                                'r_1915', % lanosterol
                                'r_2106', % zymosterol
                                'r_2137', % ergosta-5,7,22,24(28)-tetraen-3beta-ol
                                'r_1654', % ammonium exchange
                                'r_1992', % oxygen exchange
                                'r_2005', % phosphate exchange
                                'r_2060' }; % sulphate exchange

                model = changeRxnBounds(model, necessary_ex, -1000, 'l');
                model = changeRxnBounds(model, necessary_ex, 1000, 'u');
            end
        elseif strcmp(modelName,'yeast7')
            if ~isAerobic
                model = changeRxnBounds(model, 'r_0226', 0, 'b'); % ATP synthase
                necessary_ex = {'r_1753', % episterol
                                'r_1757', % ergosterol
                                'r_1788', % fecosterol
                                'r_1915', % lanosterol
                                'r_2106', % zymosterol
                                'r_2137', % ergosta-5,7,22,24(28)-tetraen-3beta-ol
                                'r_1654', % ammonium exchange
                                'r_1992', % oxygen exchange
                                'r_2005', % phosphate exchange
                                'r_2060' }; % sulphate exchange
                model = changeRxnBounds(model, necessary_ex, -1000, 'l');
                model = changeRxnBounds(model, necessary_ex, 1000, 'u');
            end
        elseif strcmp(modelName, 'ecoli_core_model')
        else
            model = changeRxnBounds(model, {'CAT';'SPODM';'SPODMpp'}, [0;0;0], 'b');
        end
        % can make oxygen...turn off for anaerobic simulations
    end

    % Make POR5 irreversible
    if ~(strcmp(modelName,'iND750') || strcmp(modelName, 'iMM904') || ...
         strcmp(modelName,'yeast6') || strcmp(modelName,'yeast7') || ...
         strcmp(modelName, 'ecoli_core_model'))
        if strcmp(POR5Str,'por5_irrev')
            model = changeRxnBounds(model, 'POR5', 0, 'l');
            model.rev(ismember(model.rxns, 'POR5')) = 0;
        elseif strcmp(POR5Str,'por5_rev')
        else
            error(sprintf('misspelled %s', POR5Str));
        end
    end

end