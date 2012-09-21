% check if we're on mac or pc
if isunix
    cd('~/Dropbox/lab/');
    addpath_recurse('~/git',{'.svn','.git'});
else
    cd('C:\Documents and Settings\z1king\My Documents\Dropbox\lab');
    addpath('C:\Documents and Settings\z1king\My Documents\Dropbox\git\optSwap');
    addpath('C:\Documents and Settings\z1king\My Documents\Dropbox\git\optSwap\helper');
    addpath('C:\Documents and Settings\z1king\My Documents\Dropbox\git\optSwap\max-yield\');
end

setupCobraSolver;