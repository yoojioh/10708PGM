clear all
close all


%% Graph parameters
p = 20; % number of cts variables
q = 300%60; % number of discrete variables
n_tr = 15%1000%15; % # of trainig samples
n_te = 2; % # of test samples
L = 2 * ones(q,1); % levels in each categorical variable

GenerateToyData_fn2(p, q, L, n_tr, n_te);

% save ToyData_v2 ToyData