%% VBCCA
rng(0);  % 设置随机种子为0

% Data Loading 
muscle = readtable('muscle_modified.xlsx');
ocular = readtable('modified_ocular.xlsx');
% Remove the 15th feature (column) from bone
% bone(:, 15 + 2) = []; % Adding 2 to 15 to account for the first two columns
% 
% % Remove the 4th feature (column) from ocular
% ocular(:, 4 + 3) = []; % Adding 3 to 4 to account for the first three columns


% Get the numeric features 
% For the space flight group
muscle_num_f = muscle(1:11, 2:end);
ocular_num_f = ocular(1:11, 4:end);

% For the ground control group 
muscle_num_gc = muscle(12:22, 2:end);
ocular_num_gc = ocular(12:22, 4:end);

% Change the form to matrix and transpose the matrix 
x1_f = table2array(muscle_num_f)';
x2_f = table2array(ocular_num_f)';

x1_gc = table2array(muscle_num_gc)';
x2_gc = table2array(ocular_num_gc)';

% Standardize the data
x1_f = (x1_f - mean(x1_f, 2)) ./ std(x1_f, 0, 2);
x2_f = (x2_f - mean(x2_f, 2)) ./ std(x2_f, 0, 2);

x1_gc = (x1_gc - mean(x1_gc, 2)) ./ std(x1_gc, 0, 2);
x2_gc = (x2_gc - mean(x2_gc, 2)) ./ std(x2_gc, 0, 2);

% Combine the data for overall VBCCA
x1 = [x1_f, x1_gc];
x2 = [x2_f, x2_gc];

% Set up the parameters 
parm.M = 1;
parm.beta_inv{1} = 0.13;
parm.beta_inv{2} = 0.13;
parm.A_inv{1} = ones(size(x1, 1), 1) * 0.1; 
parm.A_inv{2} = ones(size(x2, 1), 1) * 0.1;
parm.A0_inv{1} = zeros(size(x1, 1), 1);
parm.A0_inv{2} = zeros(size(x2, 1), 1);
parm.gamma0{1} = zeros(size(x1, 1), 1);
parm.gamma0{2} = zeros(size(x2, 1), 1);
parm.Nitr = 100;
parm.thres_a_inv = 1e-5;
parm.NitrDisp = 10;

% Run the code on separate groups
[tr_struct_f, ~] = BCCAtrainMain(x1_f, x2_f, parm);
[tr_struct_gc, ~] = BCCAtrainMain(x1_gc, x2_gc, parm);
[tr_struct, ~] = BCCAtrainMain(x1, x2, parm);

% Extract top 5 features based on coefficients for each group
num_top_features = 5;
[~, idx1_f] = sort(sum(abs(tr_struct_f.W{1}), 2), 'descend');
[~, idx2_f] = sort(sum(abs(tr_struct_f.W{2}), 2), 'descend');
top_features_bone_f = idx1_f(1:num_top_features);
top_features_ocular_f = idx2_f(1:num_top_features);

[~, idx1_gc] = sort(sum(abs(tr_struct_gc.W{1}), 2), 'descend');
[~, idx2_gc] = sort(sum(abs(tr_struct_gc.W{2}), 2), 'descend');
top_features_bone_gc = idx1_gc(1:num_top_features);
top_features_ocular_gc = idx2_gc(1:num_top_features);

%% Analysis
W1 = tr_struct.W{1};
W2 = tr_struct.W{2};

W1_f = tr_struct_f.W{1};
W2_f = tr_struct_f.W{2};

W1_gc = tr_struct_gc.W{1};
W2_gc = tr_struct_gc.W{2};

% Get the ratio comparison of weight matrix
W1_diff = W1_f - W1_gc;
W2_diff = W2_f - W2_gc;


% 
% % Calculate between-group correlations
% pearson_corr = corr(x1_combined_projected', x2_combined_projected');
% 
% disp('Between-group correlations:');
% disp(pearson_corr)
% 
% pearson_corr_f = corr(x1_f_projected', x2_f_projected');
% pearson_corr_gc = corr(x1_gc_projected', x2_gc_projected');
% 
% disp('Space flight group within-group correlations:');
% disp(pearson_corr_f);
% 
% disp('Ground control group within-group correlations:');
% disp(pearson_corr_gc);
% Visualize the ratio of weights for bone data using bar plot
figure;
subplot(2, 1, 1);
bar(W1_diff);
title('Difference of Muscle Data Feature Weights (Space Flight - Ground Control)');
xlabel('Feature Index');
ylabel('Diff');
hold on;
plot(xlim, [1 1], 'r--'); % Add a red dashed line to indicate ratio = 1

% Add the value of ratio at the middle of each bar
for i = 1:length(W1_diff)
    text(i, W1_diff(i), num2str(W1_diff(i), '%.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end

% Visualize the ratio of weights for ocular data using bar plot
subplot(2, 1, 2);
bar(W2_diff);
title('Difference of Ocular Data Feature Weights (Space Flight - Ground Control)');
xlabel('Feature Index');
ylabel('Diff');
hold on;
plot(xlim, [1 1], 'r--'); % Add a red dashed line to indicate ratio = 1

% Add the value of ratio at the middle of each bar
for i = 1:length(W2_diff)
    text(i, W2_diff(i), num2str(W2_diff(i), '%.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end
%% Permutation Test
num_permutations = 5000;
% perm_corrs_f = zeros(num_permutations, 1);
% perm_corrs_gc = zeros(num_permutations, 1);
% perm_corrs_combined = zeros(num_permutations, 1);
% perm_top_features_bone_f = zeros(num_top_features, num_permutations);
% perm_top_features_bone_gc = zeros(num_top_features, num_permutations);
% perm_top_features_ocular_f = zeros(num_top_features, num_permutations);
% perm_top_features_ocular_gc = zeros(num_top_features, num_permutations);
perm_W1_diff = zeros(size(W1, 1), num_permutations);
perm_W2_diff = zeros(size(W2, 1), num_permutations);
% Combine data for permutation
x1_combined = [x1_f, x1_gc];
x2_combined = [x2_f, x2_gc];
labels = [ones(1, size(x1_f, 2)), 2 * ones(1, size(x1_gc, 2))];

for i = 1:num_permutations
    % Permute labels between space flight and ground control
    perm_labels = labels(randperm(length(labels)));
    
    % Split the data back into permuted groups based on permuted labels
    perm_x1_f = x1_combined(:, perm_labels == 1);
    perm_x2_f = x2_combined(:, perm_labels == 1);
    perm_x1_gc = x1_combined(:, perm_labels == 2);
    perm_x2_gc = x2_combined(:, perm_labels == 2);
    
    % Recalculate correlations with permuted labels
    [tr_struct_perm_f, ~] = BCCAtrainMain(perm_x1_f, perm_x2_f, parm);
    perm_x1_f_projected = tr_struct_perm_f.W{1}' * perm_x1_f;
    perm_x2_f_projected = tr_struct_perm_f.W{2}' * perm_x2_f;
    
    [tr_struct_perm_gc, ~] = BCCAtrainMain(perm_x1_gc, perm_x2_gc, parm);
    perm_x1_gc_projected = tr_struct_perm_gc.W{1}' * perm_x1_gc;
    perm_x2_gc_projected = tr_struct_perm_gc.W{2}' * perm_x2_gc;

    perm_W1_f = tr_struct_perm_f.W{1};
    perm_W1_gc = tr_struct_perm_gc.W{1};
    perm_W1_diff(:, i) = perm_W1_f - perm_W1_gc;

    perm_W2_f = tr_struct_perm_f.W{2};
    perm_W2_gc = tr_struct_perm_gc.W{2};
    perm_W2_diff(:, i) = perm_W2_f - perm_W2_gc;
end

% Calculate p-values for weight differences for each dimension
p_values_W1 = zeros(size(W1_diff));
p_values_W2 = zeros(size(W2_diff));

for j = 1:size(W1_diff, 1)
    p_values_W1(j) = mean(perm_W1_diff(:, j) >= W1_diff(j));
end

for j = 1:size(W2_diff, 1)
    p_values_W2(j) = mean(perm_W2_diff(:, j) >= W2_diff(j));
end

% Output p-values
disp('P-values for W1 differences:');
disp(p_values_W1);

disp('P-values for W2 differences:');
disp(p_values_W2);

% Visualize p-values using bar plot
figure;
subplot(2, 1, 1);
bar(p_values_W1);
title('P-values for Muscle Data Feature Weights');
xlabel('Feature Index');
ylabel('P-value');
ylim([0 1]);
hold on;
plot(xlim, [0.05 0.05], 'r--'); % Add a red dashed line to indicate p = 0.05

% Annotate p-values on top of each bar
for i = 1:length(p_values_W1)
    text(i, p_values_W1(i) + 0.02, num2str(p_values_W1(i), '%.3f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end
hold off;

subplot(2, 1, 2);
bar(p_values_W2);
title('P-values for Ocular Data Feature Weights');
xlabel('Feature Index');
ylabel('P-value');
ylim([0 1]);
hold on;
plot(xlim, [0.05 0.05], 'r--'); % Add a red dashed line to indicate p = 0.05

% Annotate p-values on top of each bar
for i = 1:length(p_values_W2)
    text(i, p_values_W2(i) + 0.02, num2str(p_values_W2(i), '%.3f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end
hold off;



