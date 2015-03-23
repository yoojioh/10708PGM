%% Demo of the synthetic experiments.
%% Requires UGM at http://www.di.ens.fr/~mschmidt/Software/UGM_2009.zip
%% Requires TFOCS at http://tfocs.stanford.edu
clear all
close all

addpath(genpath('./UGM_2009')); 
addpath(genpath('./TFOCS-1.3.1'));
addpath(genpath('./pnopt-0.9-rc'));



%% load data
% load ToyData X Y D p q L n thcts maskDisCts maskDis
load ToyData_v2 ToyData



%% para setting
lam_given = 5 * sqrt(log(ToyData.p + ToyData.q) / ToyData.n_tr);
use_given_lam = 0;

if use_given_lam
     lambda_seq = lam_given;
else
    lambda_seq = [1 0.64 0.32 lam_given 0.16 0.08 0.04 0.02]; 
end



%% run!
kcv = 5; % k-fold CV
opt = syntheticExp2_PGM_CV_fn(ToyData, lambda_seq, kcv);



%% evaluate prediction error
fprintf('---------------------------------------\n');
[prederr] = PGM_predict(opt.theta, opt.alpha1, opt.beta, opt.betad, ToyData.Y_te, ToyData.D_te);
fprintf('PGM_model - lambda: %g\n, prediction error: %g\n', opt.lambda, prederr);



%% Plot parameters
if use_given_lam
    close all;
    data_name = 'fixed-lam -cts truth';
    figure(1); imagesc(triu(ToyData.thcts-diag(diag(ToyData.thcts)))); title(data_name); colorbar;
    saveas(gcf,sprintf('./PLOTS/%s_lam_%.2f_pred_%.4f_res.png', data_name, opt.lambda, prederr));
    data_name = 'fixed-lam -cts recover';
    figure(2); imagesc(-opt.beta); title(data_name); colorbar;
    saveas(gcf,sprintf('./PLOTS/%s_lam_%.2f_pred_%.4f_res.png', data_name, opt.lambda, prederr));
    data_name = 'fixed-lam -discrete truth';
    figure(3); imagesc(ToyData.maskDis); title(data_name);colorbar;
    saveas(gcf,sprintf('./PLOTS/%s_lam_%.2f_pred_%.4f_res.png', data_name, opt.lambda, prederr));
    % figure; imagesc(phi); title('dis recover');colorbar;
    data_name = 'fixed-lam -cts-dis truth';
    figure; imagesc(ToyData.maskDisCts); title(data_name);colorbar;
    saveas(gcf,sprintf('./PLOTS/%s_lam_%.2f_pred_%.4f_res.png', data_name, opt.lambda, prederr));
    data_name = 'fixed-lam -cts-dis recover';
    figure; imagesc(opt.theta'); title(data_name);colorbar;
    saveas(gcf,sprintf('./PLOTS/%s_lam_%.2f_pred_%.4f_res.png', data_name, opt.lambda, prederr));
    
else
    close all;
    data_name = 'cts truth';
    figure(1); imagesc(triu(ToyData.thcts-diag(diag(ToyData.thcts)))); title(data_name); colorbar;
    saveas(gcf,sprintf('./PLOTS/%s_lam_%.2f_pred_%.4f_res.png', data_name, opt.lambda, prederr));
    data_name = 'cts recover';
    figure(2); imagesc(-opt.beta); title(data_name); colorbar;
    saveas(gcf,sprintf('./PLOTS/%s_lam_%.2f_pred_%.4f_res.png', data_name, opt.lambda, prederr));
    data_name = 'discrete truth';
    figure(3); imagesc(ToyData.maskDis); title(data_name);colorbar;
    saveas(gcf,sprintf('./PLOTS/%s_lam_%.2f_pred_%.4f_res.png', data_name, opt.lambda, prederr));
    % figure; imagesc(phi); title('dis recover');colorbar;
    data_name = 'cts-dis truth';
    figure; imagesc(ToyData.maskDisCts); title(data_name);colorbar;
    saveas(gcf,sprintf('./PLOTS/%s_lam_%.2f_pred_%.4f_res.png', data_name, opt.lambda, prederr));
    data_name = 'cts-dis recover';
    figure; imagesc(opt.theta'); title(data_name);colorbar;
    saveas(gcf,sprintf('./PLOTS/%s_lam_%.2f_pred_%.4f_res.png', data_name, opt.lambda, prederr));
end



 