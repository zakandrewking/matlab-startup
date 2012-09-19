function allMatToCsv(files, replaceExisting)

    if nargin < 1, files = []; end
    if nargin < 2, replaceExisting = false; end

    directory_name = cd;
    if isempty(files), files = dir(directory_name); end
    fileIndex = find(~[files.isdir]);

    for i = 1:length(fileIndex)

        filename = files(fileIndex(i)).name;
        if (findstr(filename,'.mat'))
            cell = load(filename);
            csvName = strrep(filename,'.mat','.csv');
            if exist(csvName,'file') 
                % warning(sprintf('file %s already exists',csvName));
                if ~replaceExisting
                    continue;
                else 
                    % warning('replacing');
                end
            end
            a = fieldnames(cell);
            try
                display(sprintf('saving %s', csvName));
                cell2csv(csvName,getfield(cell,a{1}));
            catch
                % warning(sprintf('error saving %s',csvName));
            end
        end
    end


end