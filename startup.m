% check if we're on mac or pc
if isunix
    cd('~/repos/');
    addpath_recurse('~/repos/matlab-startup',{'.svn','.git'});
    addpath('~/models');
    addpath_recurse('~/sharedrepos/cobratoolbox',{'.svn','.git'});
    addpath_recurse('~/repos/optSwap',{'.svn','.git'});
    % addpath_recurse('~/lab/software/rBioNet')
    % libsbml
    addpath('/usr/local/lib/')
else
    cd('C:\Documents and Settings\z1king\My Documents\Dropbox\lab');
    git_path = 'C:\Documents and Settings\z1king\My Documents\Dropbox\git\'
    addpath([git_path 'Matlab\']);
    addpath([git_path 'optSwap\']);
    addpath([git_path 'optSwap\helper\']);
    addpath([git_path 'optSwap\max-yield\']);
end

setupCobraSolver
% dbstop if error